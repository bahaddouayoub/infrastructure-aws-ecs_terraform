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

resource "aws_lb_target_group" "alb_as_tg" {
    depends_on  = [
    aws_lb.nlb
  ]
  name        = "alb-as-tg"
  target_type = "alb"
  port        = 80
  protocol    = "TCP"
  vpc_id      = var.vpc_id 
}

resource "aws_lb_target_group_attachment" "alb_attachment" {
  target_group_arn = aws_lb_target_group.alb_as_tg.arn
  target_id        = aws_lb.alb.id
  port             = 80
}


# Redirect all traffic from the NLB to the application load balancer as a target group
resource "aws_lb_listener" "nlb_listener_movie" {
  load_balancer_arn = aws_lb.nlb.id
  port              = 80
  protocol    = "TCP"

  default_action {
    target_group_arn = aws_lb_target_group.alb_as_tg.id
    type             = "forward"
  }
}