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
| <a name="module_website_s3_bucket_1"></a> [website\_s3\_bucket\_1](#module\_website\_s3\_bucket\_1) | ./modules/aws-s3-static-website-bucket | n/a |
| <a name="module_website_s3_bucket_2"></a> [website\_s3\_bucket\_2](#module\_website\_s3\_bucket\_2) | ./modules/aws-s3-static-website-bucket | n/a |

