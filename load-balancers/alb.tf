resource "aws_lb" "alb" {
  name               = "alb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = ["${var.aws_security_group_alb_id}"]
  subnets            = var.private_subnet_ids

  enable_deletion_protection = false

  tags = {
    Environment = var.environment
  }
}


# Redirect all traffic from the ALB to the target group
resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.alb.id
  port              = 80
  protocol    = "HTTP"

  # default_action {
  #   target_group_arn = var.aws_lb_target_group
  #   type             = "forward"
  # }

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}
