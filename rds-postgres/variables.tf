variable "db_password" {
  description = "RDS root user password"
  sensitive   = true
  type        = string
}

variable "db_username" {
  description = "RDS root username"
  type        = string
}

variable "vpc_id" {
  description = "AWS VPC Cider block for rds databases"
  type        = string
}

variable "subnet_ids" {
  description = "AWS public subnet ids"
  type = list(string)
  
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


