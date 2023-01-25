provider "aws" {
  region  = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "terraform-state-files-jenkins"
    region = "us-east-1"
  }
}
