# Creating key pair
resource "aws_key_pair" "demokey" {
  key_name   = "${var.key}"
  public_key = "${file(var.public_key)}"
}

# Creating Instances
resource "aws_instance" "demoinstance1" {
    ami = var.ami
    instance_type = var.instance_type
    count = 1
    key_name = "${aws_key_pair.demokey.id}"   # SSH key that we have generated above for connection

    # Attaching Tag to Instance 
    tags = {
        Name = "Demo-Instance"
    }
  
    # SSH into instance 
    connection {
        
        user = "ubuntu"   # The default username for our AMI
        
        private_key = "${file(var.private_key)}"   # Private key for connection
        
        type = "ssh"       # Type of connection
  }
  
  # Installing docker on newly created instance
    provisioner "remote-exec" {
        inline = [
            "sudo apt update -y",
            "sudo groupadd docker",
            "sudo usermod -aG docker $USER",
            "sudo newgrp docker",
            "sudo chmod 666 /var/run/docker.sock"
  ]
 }
}
