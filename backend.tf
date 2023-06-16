terraform {
  required_version = ">=0.12"
  backend "s3" {
    bucket = "peaqock-state.terraform"
    key    = "state.tfstate"
    region = "us-east-1"
  }
}
