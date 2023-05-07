resource "aws_ecs_task_definition" "main" {
  family             = var.family_name
  task_role_arn = aws_iam_role.task_role.arn
  execution_role_arn = aws_iam_role.main_ecs_tasks.arn
  network_mode       = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu    = var.fargate_cpu
  memory = var.fargate_memory
  container_definitions = jsonencode([
    {
      name : var.container_name,
      image : var.app_image,
      cpu : var.fargate_cpu,
      memory : var.fargate_memory,
      networkMode : "awsvpc",
      portMappings : [
        {
          name: var.port_mapping,
          containerPort : var.app_port
          protocol : "tcp",
          hostPort : var.app_port,
          appProtocol: "http"
        }
      ],
            "essential": true,
            "environment": jsondecode(file("${var.env_file}")),
      "logConfiguration": {
                "logDriver": "awslogs",
                "options": {
                    "awslogs-create-group": "true",
                    "awslogs-group": var.logs,
                    "awslogs-region": "us-east-1",
                    "awslogs-stream-prefix": "ecs"
                }
            }
    }
  ])
}
