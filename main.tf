# Creating key-pair
resource "aws_key_pair" "demo-key" {
    key_name = var.key
    public_key = tls_private_key.rsa.public_key_openssh
}

resource "tls_private_key" "rsa" {
    algorithm = "RSA"
    rsa_bits = 4096
}

resource "local_file" "save-key" {
    content = tls_private_key.rsa.private_key_pem
    filename = var.private_key
}

# Creating Instances
resource "aws_instance" "terra-staging" {

  # AMI based on region 
  ami = var.ami
  vpc_security_group_ids = ["sg-0426fcc5469e1658e"]


  # Instance type 
  instance_type = var.instance_type
  
  # Count of instance
   count= 1
  
  # SSH key that we have generated above for connection
  key_name = var.key

  # Attaching Tag to Instance 
  tags = {
    Name = "Staging-Instance with Terraform"
  }
   
#Root Block Storage
#   root_block_device {
#     volume_size = "40"
#     volume_type = "standard"
#   }
  
#EBS Block Storage
#   ebs_block_device {
#     device_name = "/dev/sdb"
#     volume_size = "80"
#     volume_type = "standard"
#     delete_on_termination = false
#   }
  
    # SSH into instance 
    connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ubuntu"
      private_key = "${file("~/.ssh/id_rsa")}"
      timeout     = "60s"
    }
  
    # Installing splunk & creating distributed indexer clustering on newly created instance
    provisioner "remote-exec" {
        inline = [
            "sudo chmod 600 .ssh/id_rsa",
            "sudo apt update -y",
            "sudo groupadd docker",
            "sudo usermod -aG docker $USER",
            "sudo newgrp docker",
            "sudo apt install docker.io",
            "cd maven-project",
            "docker build -t pritidevops/web-app .",
            "docker run -itd -p 8080:8080 pritidevops/web-app --name webapp"
  ]
 }
}


# data "aws_security_group" "demosg" {
#     id = "sg-06f293b32926c8afc"  
# }

# resource "aws_instance" "ec2" {
#     ami = var.ami 
#     instance_type = var.instance_type
#     key_name= var.key
#     # security_groups = data.aws_security_group.demosg.id
#     vpc_security_group_ids = [data.aws_security_group.demosg.id]

#     # Attaching Tag to Instance 
#     tags = {
#         Name = "Demo-terra-Instance"
#     }

#     # SSH into instance 
#     connection {
        
#         # The default username for our AMI
#         user = "ubuntu"
        
#         # Private key for connection
#         private_key = file("./keys/task-demo.pem")
        
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
#             "docker --version",
#             "docker build -t webapp .",
#             "sudo chmod 666 /var/run/docker.sock",
#             # "docker pull pritidevops/webapp:latest .",
#             # "docker run -itd -p 8080:8080 pritidevops/webapp:latest --name web-app"
            
#         ]
#     }
# }



