output arn {
  value = aws_ecs_cluster.main.arn
}

output id {
  value = aws_ecs_cluster.main.id
}

output "namespace" {
  value = aws_service_discovery_http_namespace.service_connect.name
}