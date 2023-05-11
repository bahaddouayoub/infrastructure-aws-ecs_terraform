### VPC Network Setup
resource "aws_vpc" "custom_vpc" {
  cidr_block       = var.vpc_cidr_block
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.vpc_tag_name}-${var.environment}"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.custom_vpc.id

  tags = {
    Name = "igw-${var.environment}"
  }
}

#Create the public subnets
resource "aws_subnet" "public_subnet" {
  count = var.number_of_private_subnets
  vpc_id            = "${aws_vpc.custom_vpc.id}"
  cidr_block = "${element(var.public_subnet_cidr_blocks, count.index)}"
  availability_zone = "${element(var.availability_zones, count.index)}"

  tags = {
    Name = "${var.public_subnet_tag_name}-${count.index}-${var.environment}"
  }
}
#Create the private subnets 
resource "aws_subnet" "private_subnet" {
  count = var.number_of_private_subnets
  vpc_id            = "${aws_vpc.custom_vpc.id}"
  cidr_block = "${element(var.private_subnet_cidr_blocks, count.index)}"
  availability_zone = "${element(var.availability_zones, count.index)}"

  tags = {
    Name = "${var.private_subnet_tag_name}-${count.index}-${var.environment}"
  }
}

#Create public and private route table
resource "aws_route_table" "public_rt" {
    vpc_id= aws_vpc.custom_vpc.id
    route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
    }
    tags = {
        Name: "public-rtb-${var.environment}"
    }
}
resource "aws_route_table" "private_rt" {
    vpc_id= aws_vpc.custom_vpc.id
    route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
    }
    tags = {
        Name: "priavte-rtb-${var.environment}"
    }
}


# Route table and subnet associations
resource "aws_route_table_association" "rt_association" {
    count = var.number_of_private_subnets
    subnet_id= aws_subnet.public_subnet[count.index].id
    route_table_id= aws_route_table.public_rt.id
    depends_on = [aws_internet_gateway.gw, aws_subnet.public_subnet]
}

resource "aws_route_table_association" "subnet_route_assoc" {
  count = var.number_of_private_subnets
  subnet_id      = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.private_rt.id
  depends_on = [aws_subnet.private_subnet]
}

# Nat Gateway

resource "aws_eip" "ip" {
  vpc      = true
}
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.ip.id
  subnet_id     = aws_subnet.public_subnet[1].id

  tags = {
    Name = "NAT Gateway - ${var.environment}"
  }
  # To ensure proper ordering, it is recommended to add an explicit dependency.
}



# AWS services through an AWS PrivateLink
resource "aws_security_group" "privatelink_sg" {
    lifecycle {
    ignore_changes = [name]
  }
  name        = "privatelinks-sg-${var.environment}"
  description = "allow between subnet and ecr s3 cloudwatch"
  vpc_id      = "${aws_vpc.custom_vpc.id}"

  ingress {
    protocol        = "tcp"
    from_port       = 443
    to_port         = 443
    cidr_blocks = [var.vpc_cidr_block]
  }

  egress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    prefix_list_ids = [
      aws_vpc_endpoint.s3.prefix_list_id
    ]
  }

  egress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    cidr_blocks = [var.vpc_cidr_block]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

##PrivateLink VPC privatelink_sg

# ECR
resource "aws_vpc_endpoint" "ecr_dkr" {
  vpc_id       = "${aws_vpc.custom_vpc.id}"
  service_name = "com.amazonaws.${var.region}.ecr.dkr"
  vpc_endpoint_type = "Interface"
  private_dns_enabled = true
  subnet_ids          = aws_subnet.private_subnet.*.id

  security_group_ids = [
    aws_security_group.privatelink_sg.id,
  ]

  tags = {
    Name = "ECR Docker VPC Endpoint Interface - ${var.environment}"
    Environment = var.environment
  }
}

resource "aws_vpc_endpoint" "ecr_api" {
  vpc_id       = "${aws_vpc.custom_vpc.id}"
  service_name = "com.amazonaws.${var.region}.ecr.api"
  vpc_endpoint_type = "Interface"
  private_dns_enabled = true
  subnet_ids          = aws_subnet.private_subnet.*.id

  security_group_ids = [
    aws_security_group.privatelink_sg.id,
  ]

  tags = {
    Name = "ECR API VPC Endpoint Interface - ${var.environment}"
    Environment = var.environment
  }
}

# CloudWatch
resource "aws_vpc_endpoint" "cloudwatch" {
  vpc_id       = "${aws_vpc.custom_vpc.id}"
  service_name = "com.amazonaws.${var.region}.logs"
  vpc_endpoint_type = "Interface"
  subnet_ids          = aws_subnet.private_subnet.*.id
  private_dns_enabled = true

  security_group_ids = [
    aws_security_group.privatelink_sg.id,
  ]

  tags = {
    Name = "CloudWatch VPC Endpoint Interface - ${var.environment}"
    Environment = var.environment
  }
}

#

# S3
resource "aws_vpc_endpoint" "s3" {
  vpc_id       = "${aws_vpc.custom_vpc.id}"
  service_name = "com.amazonaws.${var.region}.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids = [aws_vpc.custom_vpc.default_route_table_id]

  tags = {
    Name = "S3 VPC Endpoint Gateway - ${var.environment}"
    Environment = var.environment
  }
}