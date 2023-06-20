resource "aws_db_subnet_group" "peaq_ock_db" {
  name       = "peaq-ock-db"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "peaq-ock-db"
  }
}

resource "aws_security_group" "rds" {
  name   = "peaq-ock-db-rds"
  vpc_id = var.vpc_id

  ingress {
    from_port   = var.db_port
    to_port     = var.db_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = var.db_port
    to_port     = var.db_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "peaq-ock-db-rds"
  }
}

resource "aws_db_parameter_group" "peaq_ock_db" {
  name        = var.parameter_group_name
  family      = var.parameter_group_family

  parameter {
    name  = "log_statement"
    value = var.param_log_statement
  }
}

resource "aws_db_instance" "peaq_ock_db" {
  identifier             = "peaq-ock-db-server"

  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage
  storage_type          = var.storage_type
  storage_encrypted     = true
  iops = 3000

  instance_class         = var.instance_class
  engine                 = "postgres"
  # engine_version         = "14.7-R1"  
  publicly_accessible    = true

  username               = var.db_username
  password               = var.db_password
  port                   = var.db_port
  db_name                = var.db_name 

  db_subnet_group_name   = aws_db_subnet_group.peaq_ock_db.name
  vpc_security_group_ids = [aws_security_group.rds.id]
  parameter_group_name   = aws_db_parameter_group.peaq_ock_db.name
  multi_az               = var.multi_az

  skip_final_snapshot    = var.skip_final_snapshot
  backup_retention_period= var.backup_retention_period 

  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports ? ["postgresql", "upgrade"] : []

}


resource "aws_secretsmanager_secret" "secret_manager" {
  name                    = "weather-tracker-rds-password"
  recovery_window_in_days = 0 // Overriding the default recovery window of 30 days
}

resource "aws_secretsmanager_secret_version" "secret_version" {
  secret_id     = aws_secretsmanager_secret.secret_manager.id
  secret_string = "{\"username\":\"${var.db_username}\", \"password\":\"${var.db_password}\"}"
}
