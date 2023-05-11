variable "private_subnet_ids" {
    type = list(string)
    description = "private subnets ids"  
}

variable "tasks_sg" {
    type = string
    description = "allow trafic from ecs tasks to msk cluster"
}
 
variable "cluster_name" {
    type = string
    description = "msk cluster name"
}

variable "vpc_id" {
    type = string
}
 