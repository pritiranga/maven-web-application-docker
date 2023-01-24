provider "aws" {
  region  = "us-east-1"
}

terraform {
  backend "s3" {
  bucket = "terraform-state-demo"
  key = "task_demo"
  region = "us-east-1"
  }
}