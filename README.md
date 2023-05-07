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

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | Value of the Environment Tag for the S3 bucket | `string` | n/a | yes |
| <a name="input_instance_1_ami"></a> [instance\_1\_ami](#input\_instance\_1\_ami) | Value of the AMI ID for the EC2 instance | `string` | n/a | yes |
| <a name="input_instance_1_name"></a> [instance\_1\_name](#input\_instance\_1\_name) | Value of the Name Tag for the EC2 instance | `string` | n/a | yes |
| <a name="input_instance_1_type"></a> [instance\_1\_type](#input\_instance\_1\_type) | Value of the Instance Type for the EC2 instance | `string` | n/a | yes |
| <a name="input_instance_2_ami"></a> [instance\_2\_ami](#input\_instance\_2\_ami) | Value of the AMI ID for the EC2 instance | `string` | n/a | yes |
| <a name="input_instance_2_name"></a> [instance\_2\_name](#input\_instance\_2\_name) | Value of the Name Tag for the EC2 instance | `string` | n/a | yes |
| <a name="input_instance_2_type"></a> [instance\_2\_type](#input\_instance\_2\_type) | Value of the Instance Type for the EC2 instance | `string` | n/a | yes |
| <a name="input_terraform"></a> [terraform](#input\_terraform) | Value of the Terraform Tag for the S3 bucket | `string` | n/a | yes |
| <a name="input_website_s3_bucket_1_name"></a> [website\_s3\_bucket\_1\_name](#input\_website\_s3\_bucket\_1\_name) | Value of the Name Tag for the S3 bucket | `string` | n/a | yes |
| <a name="input_website_s3_bucket_2_name"></a> [website\_s3\_bucket\_2\_name](#input\_website\_s3\_bucket\_2\_name) | Value of the Name Tag for the S3 bucket | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_instance_1_id"></a> [instance\_1\_id](#output\_instance\_1\_id) | The ID of the instance-1 |
| <a name="output_instance_2_id"></a> [instance\_2\_id](#output\_instance\_2\_id) | The ID of the instance-2 |
| <a name="output_website_bucket_1_arn"></a> [website\_bucket\_1\_arn](#output\_website\_bucket\_1\_arn) | ARN of the bucket |
| <a name="output_website_bucket_1_domain"></a> [website\_bucket\_1\_domain](#output\_website\_bucket\_1\_domain) | Domain name of the bucket |
| <a name="output_website_bucket_1_name"></a> [website\_bucket\_1\_name](#output\_website\_bucket\_1\_name) | Name (id) of the bucket |
| <a name="output_website_bucket_2_arn"></a> [website\_bucket\_2\_arn](#output\_website\_bucket\_2\_arn) | ARN of the bucket |
| <a name="output_website_bucket_2_domain"></a> [website\_bucket\_2\_domain](#output\_website\_bucket\_2\_domain) | Domain name of the bucket |
| <a name="output_website_bucket_2_name"></a> [website\_bucket\_2\_name](#output\_website\_bucket\_2\_name) | Name (id) of the bucket |
<!-- END_TF_DOCS -->

