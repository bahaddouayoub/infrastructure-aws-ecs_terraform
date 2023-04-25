resource "aws_ecs_service" "main" {
  name            = "${var.family_name}-service"
  cluster         = var.cluster_id
  task_definition = aws_ecs_task_definition.main.family
  desired_count   = var.app_count
  launch_type     = "FARGATE"

  network_configuration {
    security_groups = ["${aws_security_group.ecs_tasks.id}"]
    subnets         = var.private_subnet_ids
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.tg.arn
    container_name   = var.family_name
    container_port   = var.app_port
  }

  service_connect_configuration {
    enabled = true
    namespace = var.namespace
    service {
       port_name =  var.port_mapping
      client_alias {
        port     = var.service_connect_port
        dns_name = var.dns_name
      }
    }
    # log_configuration{

    # }
  }

  depends_on = [
    aws_ecs_task_definition.main,
  ]
}

# Traffic to the ECS Cluster should only come from the ALB
# or AWS services through an AWS PrivateLink
resource "aws_security_group" "ecs_tasks" {
  name        = "${var.security_group_ecs_tasks_name}-${var.environment}"
  description = var.security_group_ecs_tasks_description
  vpc_id      = "${var.vpc_id}"

  ingress {
    protocol    = "tcp"
    from_port   = var.app_port
    to_port     = var.app_port
    security_groups = ["${var.alb_sg}"]
  }

  ingress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}


# Target group for alb
resource "aws_lb_target_group" "tg" {
  depends_on  = [
    var.aws_lb
  ]
  name        = var.tg_name
  port        = var.app_port
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id

  health_check {
    path = var.health_check_path
    healthy_threshold = 6
    unhealthy_threshold = 2
    timeout = 2
    interval = 5
    matcher = "200"  # has to be HTTP 200 or fails
  }
}

#listners
resource "aws_lb_listener_rule" "rule" {
  listener_arn = var.aws_lb_listener_arn
  priority     = var.priority

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }

  condition {
    path_pattern {
      values = ["${var.path_pattern}"]
    }
  }

}


