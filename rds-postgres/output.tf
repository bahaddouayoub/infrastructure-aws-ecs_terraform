output "rds_endpoint" {
  value = aws_db_instance.peaq_ock_db.endpoint
}

# output "rds_username" {
#   value = aws_secretsmanager_secret_version.secret_version.secret_string[1]
# }

# output "rds_password" {
#   value = aws_secretsmanager_secret_version.secret_version.secret_string["password"]
# }