# network
module "vpc_for_ecs_fargate" {
  source                     = "./vpc-cluster"
  environment                = var.environment
  vpc_tag_name               = var.vpc_tag_name
  vpc_cidr_block             = var.vpc_cidr_block
  number_of_private_subnets  = var.number_of_private_subnets
  private_subnet_tag_name    = var.private_subnet_tag_name
  public_subnet_tag_name     = var.public_subnet_tag_name
  private_subnet_cidr_blocks = var.private_subnet_cidr_blocks
  public_subnet_cidr_blocks  = var.public_subnet_cidr_blocks
  availability_zones         = var.availability_zones
  region                     = var.region
}
