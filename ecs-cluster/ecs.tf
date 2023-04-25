  resource "aws_ecs_cluster" "main" {
  name = var.name

  tags = {
    Name = var.cluster_tag_name
  }
}

resource "aws_service_discovery_http_namespace" "service_connect" {
  name        = var.namespace
  description = "cloudMmap namespace used in ecs service connect"
}

