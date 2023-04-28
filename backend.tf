terraform {
    required_version = ">=0.12"
    backend "s3" {
        bucket = "state-bucket.terraform"
        key = "state.tfstate"
        region = "us-east-1"
    }
}