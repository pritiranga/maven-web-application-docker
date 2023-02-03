# Declaring the Required provider (Docker provider)
terraform {
  required_providers {
    docker = {
        source = "kreuzwerker/docker"
        version = "3.0.1"
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
    #host ="unix:///home/user/.docker/desktop/docker.sock"

}

provider "aws" {
    region = var.region
}

