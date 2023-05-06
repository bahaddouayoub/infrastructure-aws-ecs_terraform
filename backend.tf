terraform {
    required_version = ">=0.12"
    backend "s3" {
        bucket = "terra.stateterra"
        key = "state.tfstate"
        region = "us-east-1"
    }
}