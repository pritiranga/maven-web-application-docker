#creating ec2 instance 
resource "aws_instance" "dev_terra" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name = var.key
  tags = {
    Env = "dev"
  }

# Creating key pair
# resource "aws_key_pair" "demokey" {
#   key_name   = "${var.key_name}"
#   public_key = "${file(var.public_key)}"
# }

# SSH into instance 
connection {
  # The default username for our AMI
  user = "ubuntu"
  # Private key for connection
  private_key = "${file(var.private_key)}"
  # Type of connection
  type = "ssh"
}

# Installing splunk & creating distributed indexer clustering on newly created instance
  provisioner "remote-exec" {
    inline = [
      "sudo apt update -y",
      "sudo groupadd docker",
      "sudo usermod -aG docker $USER",
      "newgrp docker",
      "sudo apt install docker.io -y",
      "sudo chmod 666 /var/run/docker.sock"  
  ]
 }
}
