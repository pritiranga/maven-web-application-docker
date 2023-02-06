# Creating VPC
resource "aws_vpc" "demovpc" {
  cidr_block       = "${var.vpc_cidr}"
  instance_tenancy = "default"

  tags = {
    Name = "Demo VPC"
  }
}

# Creating Internet Gateway 
resource "aws_internet_gateway" "demogateway" {
  vpc_id = "${aws_vpc.demovpc.id}"
}

# Grant the internet access to VPC by updating its main route table
resource "aws_route" "internet_access" {
  route_table_id         = "${aws_vpc.demovpc.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.demogateway.id}"
}

# Creating 1st subnet 
resource "aws_subnet" "demosubnet" {
  vpc_id                  = "${aws_vpc.demovpc.id}"
  cidr_block             = "${var.subnet_cidr}"
  map_public_ip_on_launch = true
  availability_zone = "us-east-1a"

  tags = {
    Name = "Demo subnet"
  }
}

# Creating 2nd subnet 
resource "aws_subnet" "demosubnet1" {
  vpc_id                  = "${aws_vpc.demovpc.id}"
  cidr_block             = "${var.subnet1_cidr}"
  map_public_ip_on_launch = true
  availability_zone = "us-east-1b"

  tags = {
    Name = "Demo subnet 1"
  }
}

# Creating Security Group
resource "aws_security_group" "demosg" {
  name        = "Demo Security Group"
  description = "Demo Module"
  vpc_id      = "${aws_vpc.demovpc.id}"

  # Inbound Rules
  # HTTP access from anywhere
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    #cidr_blocks = ["0.0.0.0/0"]
    self = true
  }

  # Outbound Rules
  # Internet access to anywhere
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


# Creating Instances
resource "aws_instance" "terra-staging" {

  # AMI based on region 
  ami = var.ami

  # Launching instance into subnet 
  subnet_id = "${aws_subnet.demosubnet.id}"

  # Instance type 
  instance_type = var.instance_type
  
  # Count of instance
#   count= 1
  
  # SSH key that we have generated above for connection
  key_name = var.key

  # Attaching security group to our instance
  vpc_security_group_ids = ["${aws_security_group.demosg.id}"]

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
      host        = aws_instance.terra-staging.public_ip
      user        = "ubuntu"
      private_key = "${file("~/.ssh/id_rsa")}"
      timeout     = "4m"
    }
  
    # Installing splunk & creating distributed indexer clustering on newly created instance
    provisioner "remote-exec" {
        inline = [
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



