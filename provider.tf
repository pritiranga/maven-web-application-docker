terraform {

  required_providers {

    docker = {

      source  = "kreuzwerker/docker"

      version = "~> 2.13.0"

    }

    aws = {

      source  = "hashicorp/aws"
      
      version = "~> 4.16"

    }

  }

}



