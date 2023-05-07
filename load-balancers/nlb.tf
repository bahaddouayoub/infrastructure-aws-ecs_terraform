

# resource "aws_lb_target_group" "alb_as_tg" {
#     depends_on  = [
#     aws_lb.nlb
#   ]
#   name        = "alb-as-tg"
#   target_type = "alb"
#   port        = 80
#   protocol    = "TCP"
#   vpc_id      = var.vpc_id 
# }

# resource "aws_lb_target_group_attachment" "alb_attachment" {
#   target_group_arn = aws_lb_target_group.alb_as_tg.arn
#   target_id        = aws_lb.alb.id
#   port             = 80
# }


