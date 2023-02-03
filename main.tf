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
    resource "local_file" "TF_key" {
        content = tls_private_key.rsa.private_key_pem
        filename = var.private_key
    }
}

# resource "aws_instance" "ec2" {
#     ami = var.ami 
#     instance_type = var.instance_type
#     key_name= var.key
#     security_groups = "Default"

#     # SSH into instance 
#     connection {
        
#         # The default username for our AMI
#         user = "ubuntu"
        
#         # Private key for connection
#         private_key = file(var.private_key)"
        
#         # Type of connection
#         type = "ssh"

#         host = self.public_ip
#     }

#     # Installing docker on newly created instance
#     provisioner "remote-exec" {
#         inline = [
#             "sudo apt update -y",
#             "sudo groupadd docker",
#             "sudo usermod -aG docker $USER",
#             "sudo newgrp docker",
#             "sudo apt install docker.io",
#             "sudo chmod 666 /var/run/docker.sock"
#         ]
#     }
# }



