variable "private_subnet_ids" {
  type = list(string) 
  description = "the private_subnet_ids "
}

variable "vpc_id" {
  type = string 
  description = "The id for the VPC where the ECS container instance should be deployed"
}

variable "aws_security_group_alb_id" {
  type = string 
  description = "the aws_security_group_alb_id "
}

variable "environment" {
  type = string
  description = "The application environment"
}

# variable "aws_lb_target_group_arn" {
#   type = string
#   description = "IDs for private subnets"
# }