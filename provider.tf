terraform {

  required_providers {

    docker = {

      source  = "kreuzwerker/docker"

      version = "2.15.0"

    }

    aws = {

      source  = "hashicorp/aws"

      version = "~> 4.16"

    }

  }

}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

provider "aws" {
  region  = "us-east-1"
}



