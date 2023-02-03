#Generating aws key-pairs
resource "tls_private_key" "terrafrom_generated_private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {

    # Name of key : Write the custom name of your key
    key_name   = var.key

    # Public Key: The public will be generated using the reference of tls_private_key.terrafrom_generated_private_key
    public_key = tls_private_key.terrafrom_generated_private_key.public_key_openssh

    # Store private key :  Generate and save private key(aws_keys_pairs.pem) in current directory
    provisioner "local-exec" {
    command = <<-EOT
      echo '${tls_private_key.terrafrom_generated_private_key.private_key_pem}' > terrakey.pem
      chmod 400 terrakey.pem
    EOT
  }
}

provider "aws" {
   region     = "eu-central-1"
   access_key = "AKIATQ37NXB2BYDxxxxx"
   secret_key = "JzZKiCia2vjbq4zGGGewdbOhnacm2QIMgcBxxxxx"
   
}

resource "aws_instance" "ec2" {
    ami = var.ami 
    instance_type = var.instance_type
    key_name= var.key

    # SSH into instance 
    connection {
        # The default username for our AMI
        user = "ubuntu"
        # Private key for connection
        private_key = "${file(var.private_key)}"
        # Type of connection
        type = "ssh"
    }

    # Installing docker on newly created instance
    provisioner "remote-exec" {
        inline = [
            "sudo apt update -y",
            "sudo groupadd docker",
            "sudo usermod -aG docker $USER",
            "sudo newgrp docker",
            "sudo apt install docker.io",
            "sudo chmod 666 /var/run/docker.sock"
        ]
    }
}



