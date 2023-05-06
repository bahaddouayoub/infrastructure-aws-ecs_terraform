variable "region" {
  description = "aws region to deploy to"
  type        = string
}

variable "environment" {
  description = "Applicaiton environment"
  type        = string
}

variable "skipper_env_file" {
  description = "skipper env_file"
  type        = string
}
variable "kafka_env_file" {
  description = "kafka env_file"
  type        = string
}

variable "app_port_home" {
  description = "Application port"
  type        = number
}

variable "app_port_movie" {
  description = "Application port"
  type        = number
}

variable "availability_zones" {
  type        = list(string)
  description = "List of availability zones for the selected region"
}

variable "vpc_tag_name" {
  type        = string
  description = "Name tag for the VPC"
}

variable "number_of_private_subnets" {
  type        = number
  default     = 1
  description = "The number of private subnets in a VPC."
}

variable "private_subnet_tag_name" {
  type        = string
  description = "Name tag for the private subnet"
}

variable "security_group_ecs_tasks_name" {
  type        = string
  default     = "ecs-tasks-sg"
  description = "ECS Tasks security group name"
}


variable "security_group_lb_name" {
  type        = string
  default     = "alb-sg"
  description = "alb security group name"
}


variable "security_group_ecs_tasks_description" {
  type        = string
  default     = "allow inbound access from the ECS ALB only"
  description = "ECS tasks security group description"
}


variable "security_group_lb_description" {
  type        = string
  default     = "allow inbound access from the vpc"
  description = "alb security group description"
}


variable "vpc_cidr_block" {
  type        = string
  default     = "10.0.0.0/16"
  description = "CIDR block range for vpc"
}

variable "private_subnet_cidr_blocks" {
  type        = list(string)
  default     = ["10.0.0.0/24", "10.0.4.0/24"]
  description = "CIDR block range for the private subnets"
}

variable "cluster_tag_name" {
  type        = string
  description = "Name tag for the cluster"
}

variable "home_port_mapping" {
  type        = string
  description = "The name of the container"
}

variable "movie_port_mapping" {
  type        = string
  description = "The name of the container"
}


variable "home_container_name" {
  type        = string
  description = "The name of the container"
}

variable "movie_container_name" {
  type        = string
  description = "The name of the container"
}

variable "home_family_name" {
  type        = string
  description = "The name of the task definition family"
}

variable "movie_family_name" {
  type        = string
  description = "The name of the task definition family"
}


variable "movie_dns_name" {
  type        = string
  description = "domain name that will for service to service communication"
}

variable "home_dns_name" {
  type        = string
  description = "domain name that will for service to service communication"
}

variable "health_check_path_home" {
  type        = string
  description = "health_check_path_home"
}

variable "tg_name_home" {
  type        = string
  description = "tg_name_home"
}

# variable "path_pattern_home" {
#   type        = string
#   description = "the path_pattern home"
# }

variable "app_image_home" {
  type        = string
  description = "Container image to be used for application in task definition file"
}


variable "app_image_movie" {
  type        = string
  description = "Container image to be used for application in task definition file"
}


variable "health_check_path_movie" {
  type        = string
  description = "health_check_path_movie"
}


variable "tg_name_movie" {
  type        = string
  description = "tg_name_movie"
}


# variable "path_pattern_movie" {
#   type        = string
#   description = "the path_pattern movie"
# }

variable "security_group_ecs_tasks_name_movie" {
  type        = string
  description = "the security group ecs_tasks_name_movie"
}

variable "security_group_ecs_tasks_name_home" {
  type        = string
  description = "the security group ecs_tasks_name_home"
}

# variable "fargate_cpu" {
#   type = number
#   description = "Fargate cpu allocation"
# }

# variable "fargate_memory" {
#   type = number
#   description = "Fargate memory allocation"
# }

variable "app_count" {
  type        = string
  description = "The number of instances of the task definition to place and keep running."
}
variable "namespace" {
  type        = string
  description = "default namespace"
}

# rds variables
variable "db_password" {
  description = "RDS root user password"
  sensitive   = true
  type        = string
}

variable "db_username" {
  description = "RDS root username"
  type        = string
}

variable "db_port" {
  description = "rds postgres databases port "
  type        = number
}


variable "allocated_storage" {
  description = "Allocate storage"
  type        = number
  default     = 100
}

variable "max_allocated_storage" {
  description = "Max allocate storage"
  type        = number
  default     = 500
}

variable "storage_type" {
  description = "Storage type (e.g. gp2, io1)"
  type        = string
  default     = "io1"
}

variable "instance_class" {
  description = "Instance class"
  type        = string
  default     = "db.t2.micro"
}

variable "backup_retention_period" {
  description = "Backup retention period in days"
  type        = number
  default     = 14
}

variable "skip_final_snapshot" {
  description = "Skip final snapshot"
  type        = bool
  default     = true
}

variable "apply_immediately" {
  description = "Apply immediately, do not set this to true for production"
  type        = bool
  default     = false
}

variable "enabled_cloudwatch_logs_exports" {
  default     = true
  type        = bool
  description = "Indicates that postgresql logs will be configured to be sent automatically to Cloudwatch"
}

variable "multi_az" {
  default     = false
  type        = bool
  description = "Specifies if the RDS instance is multi-AZ."
}

variable "parameter_group_name" {
  description = "The name of the rds parameter group"
  type        = string
  default     = "rds-postgres-pg"
}


variable "param_log_statement" {
  description = "Sets the type of statements logged. Valid values are none, ddl, mod, all"
  type        = string
  default     = "none"
}

variable "parameter_group_family" {
  description = "Sets the parameter group family "
  type        = string
}


