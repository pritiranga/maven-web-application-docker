# Declaring the Required provider (Docker provider)
terraform {
  required_providers {
    docker = {
        source = "kreuzwerker/docker"
        version = "2.16.0"
    }

    aws = {
        source  = "hashicorp/aws"
        version = "~> 4.16"

    }
  }
}

# Specifying the Docker provider configuration
provider "docker" {
    host = "unix:///var/run/docker.sock"
}

provider "aws" {
    region = var.region
}

