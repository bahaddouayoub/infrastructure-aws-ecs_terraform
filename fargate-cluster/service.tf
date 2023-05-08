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
  }

  depends_on = [
    aws_ecs_task_definition.main,
  ]
}

# Traffic to the ECS Cluster should only come from the VPC
resource "aws_security_group" "ecs_tasks" {
  name        = "${var.security_group_ecs_tasks_name}-${var.environment}"
  description = var.security_group_ecs_tasks_description
  vpc_id      = "${var.vpc_id}"

  ingress {
    protocol    = "tcp"
    from_port   = var.app_port
    to_port     = var.app_port
    cidr_blocks = ["11.0.0.0/16"]
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
# networ load balancer
resource "aws_lb" "nlb" {
  name               = "nlb"
  internal           = true
  load_balancer_type = "network"
  subnets            = var.private_subnet_ids

  enable_deletion_protection = false

  tags = {
    Environment = var.environment
  }
}

# Target group for alb
resource "aws_lb_target_group" "tg" {
  depends_on  = [
    aws_lb.nlb
  ]
  name        = var.tg_name
  port        = var.app_port
  protocol    = "TCP"
  target_type = "ip"
  vpc_id      = var.vpc_id
}


# Redirect all traffic from the NLB to the application load balancer as a target group
resource "aws_lb_listener" "nlb_listener" {
  load_balancer_arn = aws_lb.nlb.arn
  port              = var.app_port
  protocol    = "TCP"

  default_action {
    target_group_arn = aws_lb_target_group.tg.arn
    type             = "forward"
  }
}


