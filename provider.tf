# Provider Requirements
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>3.0"
    }
  }
}

# AWS Provider (aws) with region
provider "aws" {
  region = var.region
}