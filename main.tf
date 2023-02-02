terraform {

  required_providers {

    docker = {

      source  = "kreuzwerker/docker"

      version = "3.0.1"

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

# provider "aws" {
#   region  = "us-east-1"
# }


#creating ec2 instance 
# resource "aws_instance" "dev_terra" {
#   ami           = var.ami
#   instance_type = var.instance_type
#   key_name = var.key
#   tags = {
#     Env = "dev"
#   }
# }

# Creating key pair
# resource "aws_key_pair" "demokey" {
#   key_name   = "${var.key_name}"
#   public_key = "${file(var.public_key)}"
# }

# Creating a Docker Image ubuntu with the latest as the Tag
resource "docker_image" "tomcat" {               
  name = "tomcat:8.0.20-jre8"
}

# Creating a Docker Container using the latest ubuntu image
# resource "docker_container" "my_container" {   
#   # Specifying the name of the container as my_container
#   name = "my_container"  
#   image = docker_image.tomcat.latest       
# }

# Creating a Docker Service named myservice using ubuntu image with a latest
# resource "docker_service" "my_service" {       
#   name = "myservice"
#   task_spec {
#    container_spec {
#      image = docker_image.tomcat.latest     
#     }
#    }
#   endpoint_spec {
#     ports {
#      target_port = "8080"
#        }
#     }
# }