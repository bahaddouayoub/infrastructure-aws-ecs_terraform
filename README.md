# Deploy Dataflow in ECS Fargate behind API Gateway & NLB for Secure Optimal Accessibility (with Terraform)
## Overview
This repository contains the source code for a containerised application in AWS ECS Fargate inside a VPC's private subnets. An API Gateway is used as the doorway to the private network using a VPC link to access the VPC. An NLB is for optimal performance of accessing the application running in the private subnets.


## Technical Architecture Diagram
<img src="assets/dataflow-infra.png" alt="infrastructure-terraform" title="infrastructure-terraform">

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~>3.0 |
| <a name="requirement_aws"></a> [Terraform](#requirement\_aws) | v1.4.5 |


## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.59.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| vpc_for_ecs_fargate | ./vpc-cluster | n/a |
| ecs_cluster | ./ecs-cluster | n/a |
| msk_cluster | ./msk-cluster | n/a |   
| rds_postgresql | ./rds-postgres | n/a | 
| api_gateway | ./api-gateway | n/a | 
| fargate_cluster | ./fargate-cluster | n/a | 


## Resources

| Name | Type |
|------|------|
| [aws_instance.instance_1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_instance.instance_2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |

## vpc_for_ecs_fargate module Inputs 

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a href="environment">environment</a>| Value of the Environment (dev, uat, prod, ...) | `string` | n/a | yes |
| <a href="vpc_cidr_block">vpc_cidr_block</a> | Vpc cidr block | `string` | n/a | yes |
| <a href="number_of_private_subnets">number_of_private_subnets</a>| Number of private subnets | `number` | n/a | yes |
| <a href="private_subnet_tag_name">private_subnet_tag_name</a> | Private subnet tag name | `string` | n/a | yes |
| <a href="private_subnet_cidr_blocks">private_subnet_cidr_blocks</a>| Private subnet cidr blocks | `string` | n/a | yes |
| <a href="availability_zones">availability_zones</a> | Availability zones | `string` | n/a | yes |   
| <a href="region">region</a> | AWS region | `string` | n/a | yes |  
| <a href="vpc_tag_name">vpc_tag_name</a> | Vpc tag name  | `string` | n/a | yes |


## vpc_for_ecs_fargate module Outputs

| Name | Description |
|------|-------------|
| <a href="output vpc_id">output vpc_id</a> | The ID of vpc |
| <a href="output vpc_arn">output vpc_arn</a> | The  vpc arn |
| <a href="output private_subnet_ids">output private_subnet_ids</a> | The private subnet idsc |


## ecs_cluster module Inputs 

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a href="name">name</a>| The name of the cluster | `string` | n/a | yes |
| <a href="cluster_tag_name">cluster_tag_name</a> |Cluster tag name | `string` | n/a | yes |
| <a href="namespace">number_of_private_subnets</a>|The namespace related with ecs cluster | `string` | n/a | yes |

## ecs_cluster module Outputs

| Name | Description |
|------|-------------|
| <a href="output id">output id</a> | The ID of ecs cluster |
| <a href="output arn">output arn</a> | The  ecs cluster arn |
| <a href="output namespace">output namespace</a> | cloudMmap namespace used in ecs service connect |


## msk_cluster module Inputs 

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a href="cluster_name">cluster_name</a>| The name of the msk cluster | `string` | n/a | yes |
| <a href="private_subnet_ids">private_subnet_ids</a> | Private subnet ids when the MSK cluster provisioned | `string` | n/a | yes |
| <a href="vpc_id">vpc_id</a>|The network when the MSK cluster provisioned | `string` | n/a | yes |


## msk_cluster module Outputs

| Name | Description |
|------|-------------|
| <a href="output bootstrap_brokers">output bootstrap_brokers</a> | PLAINTEXT connection host:port pairs |



## fargate_cluster module Inputs 

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a href="environment">environment</a>|Value of the Environment (dev, uat, prod, ...)| `string` | n/a | yes |
| <a href="family_name">family_name</a>| The name of the task definition family | `string` | n/a | yes |
| <a href="env_file">env_file</a> | The location of the container environment variables file | `string` | n/a | yes |
| <a href="dns_name">dns_name</a>|Service connect dns name | `string` | n/a | yes |
| <a href="container_name">container_name</a>|The name of the container | `string` | n/a | yes |
| <a href="app_image">app_image</a>| The name of docker image used that we store on ECR | `string` | n/a | yes |
| <a href="namespace">namespace</a>|Service connect namespace in cloudMap | `string` | n/a | yes |
| <a href="port_mapping">port_mapping</a>| The name of port mapping created in task def before | `string` | n/a | yes |
| <a href="fargate_cpu">fargate_cpu</a>|the number of vcpu will use by the task | `number` | n/a | yes |
| <a href="fargate_memory">fargate_memory</a>| The amount of memory  will use by the task  | `number` | n/a | yes |
| <a href="app_port">app_port</a>|The container port  | `number` | n/a | yes |
| <a href="vpc_id">vpc_id</a>|The vpc id  | `string` | n/a | yes |
| <a href="logs">logs</a>|The cloudwatch log group  | `string` | n/a | yes |
| <a href="tg_name">tg_name</a>|The target group name  | `string` | n/a | yes |
| <a href="service_connect_port">service_connect_port</a>|Service connect port that will use to inter-connect micro-services  | `number` | n/a | yes |
| <a href="cluster_id">cluster_id</a>|Ecs cluster id  | `string` | n/a | yes |
| <a href="app_count">app_count</a>|The number of desired tasks   | `number` | n/a | yes |
| <a href="security_group_ecs_tasks_name">security_group_ecs_tasks_name</a>| Task security group  | `string` | n/a | yes |
| <a href="private_subnet_ids">private_subnet_ids</a>|Private subnet ids when tasks deployed  | `string` | n/a | yes |


## fargate_cluster module Outputs

| Name | Description |
|------|-------------|
| <a href="output nlb_dns_name">output nlb_dns_name</a> | DNS name for the internal NLB |
| <a href="output nlb_arn">output nlb_arn</a> | ARN for the internal NLB |



## api_gateway module Inputs 

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a href="environment">environment</a>|Value of the Environment (dev, uat, prod, ...)| `string` | n/a | yes |
| <a href="name">name</a>| The name of the api gateway | `string` | n/a | yes |
| <a href="integration_input_type">integration_input_type</a> | The integration type(HTTP_PROXY)  | `string` | n/a | yes |
| <a href="path_part">path_part</a>|The path part({proxy+}) | `string` | n/a | yes |
| <a href="nlb_dns_name">nlb_dns_name</a>| The network load balancer dns  | `string` | n/a | yes |
| <a href="nlb_arn">nlb_arn</a> | The network load balancer arn  | `string` | n/a | yes |




## rds_postgresql module Inputs 

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a href="vpc_id">vpc_id</a>|The vpc id  | `string` | n/a | yes |
| <a href="subnet_ids">subnet_ids</a>| subnet ids when RDS postgres database deployed  | `string` | n/a | yes |
| <a href="parameter_group_name">parameter_group_name</a>| The name of the parametre group | `string` | n/a | yes |
| <a href="parameter_group_family">parameter_group_family</a> | The parametre group family  | `string` | n/a | yes |
| <a href="param_log_statement">param_log_statement</a>| The parametre log statement | `string` | n/a | yes |
| <a href="max_allocated_storage">max_allocated_storage</a> | The max allocated storage for database serve  | `number` | n/a | yes |
| <a href="allocated_storage">allocated_storage</a>|The allocated storage for database server | `number` | n/a | yes |
| <a href="storage_type">storage_type</a>| The storage type | `string` | n/a | yes |
| <a href="instance_class">instance_class</a> | The instance class | `string` | n/a | yes |
| <a href="db_username">db_username</a>| The db username | `string` | n/a | yes |
| <a href="db_password">db_password</a> | The db password | `string` | n/a | yes |
| <a href="db_port">db_port</a>| The db port | `number` | n/a | yes |
| <a href="instance_class">instance_class</a> | The instance class(db.t3.medium) | `string` | n/a | yes |
| <a href="multi_az">multi_az</a> | multi_az or not | `bool` | n/a | yes |
| <a href="skip_final_snapshot">skip_final_snapshot</a>| skip final snapshot or not | `bool` | n/a | yes |
| <a href="backup_retention_period">backup_retention_period</a> | The backup retention period | `number` | n/a | yes |
| <a href="enabled_cloudwatch_logs_exports">enabled_cloudwatch_logs_exports</a>| enabled cloudwatch logs exports or not | `bool` | n/a | yes 




<!-- END_TF_DOCS -->

