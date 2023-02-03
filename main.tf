# resource "aws_key_pair" "demo-key" {
#     key_name = var.key
#     public_key = tls_private_key.rsa.public_key_openssh
# }

# resource "tls_private_key" "rsa" {
#     algorithm = "RSA"
#     rsa_bits = 4096
# }

# resource "local_file" "save-key" {
#     content = tls_private_key.rsa.private_key_pem
#     filename = var.private_key
# }

resource "aws_instance" "ec2" {
    ami = var.ami 
    instance_type = var.instance_type
    key_name= var.key

    # SSH into instance 
    connection {
        
        # The default username for our AMI
        user = "ubuntu"
        
        # Private key for connection
        private_key = file(var.private_key)
        
        # Type of connection
        type = "ssh"

        host = self.public_ip
    }

    # Installing docker on newly created instance
    provisioner "remote-exec" {
        inline = [
            "sudo apt update -y",
            # "sudo groupadd docker",
            # "sudo usermod -aG docker $USER",
            # "sudo newgrp docker",
            # "sudo apt install docker.io",
            "docker --version",
            "docker pull pritidevops/webapp:latest ."
            # "sudo chmod 666 /var/run/docker.sock"
        ]
    }
}



