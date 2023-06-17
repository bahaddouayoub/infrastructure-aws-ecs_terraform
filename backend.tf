terraform {
  required_version = ">=0.12"
  backend "s3" {
    bucket = "peaq-state.terra"
    key    = "state.tfstate"
    region = "us-east-1"
  }
}
