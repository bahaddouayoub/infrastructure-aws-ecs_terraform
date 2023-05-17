resource "aws_msk_cluster" "msk_cluster" {
  cluster_name           = var.cluster_name 
  kafka_version          = "2.8.1"
  number_of_broker_nodes = 2

  broker_node_group_info {
    instance_type = "kafka.t3.small"
    client_subnets = var.private_subnet_ids
    security_groups = [aws_security_group.msk_sg.id]
    storage_info {
      ebs_storage_info {
        volume_size = 100
      }
    }
  } 
  encryption_info {
    encryption_in_transit {
      client_broker = "PLAINTEXT" 
      in_cluster = "true"
    }
  }
  client_authentication {
       unauthenticated = true
  }
}

resource "aws_security_group" "msk_sg" {
  name = "msk-sg"
  description = "allow trafic to msk cluster"
  vpc_id      = "${var.vpc_id}"
  ingress {
    from_port   = 9092
    to_port     = 9092
    protocol    = "tcp"
    security_groups = ["${var.tasks_sg}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}