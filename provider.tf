provider "aws" {
  region  = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "terraform-state-files-jenkins"
    key = "task-demo"
    region = "us-east-1"
  }
}
