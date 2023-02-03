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

# Creating VPC
resource "aws_vpc" "demovpc" {
  cidr_block       = "${var.vpc_cidr}"
  instance_tenancy = "default"

  tags = {
    Name = "terra VPC"
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
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTPS access from anywhere
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
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

resource "aws_instance" "ec2" {
    ami = var.ami 
    instance_type = var.instance_type
    key_name= var.key
    
    # Launching instance into subnet 
    subnet_id = "${aws_subnet.demosubnet.id}"

    # Attaching security group to our instance
    vpc_security_group_ids = ["${aws_security_group.demosg.id}"]

    # Attaching Tag to Instance 
    tags = {
        Name = "Demo-terra-Instance"
    }

    # SSH into instance 
    connection {
        
        # The default username for our AMI
        user = "ubuntu"
        
        # Private key for connection
        private_key = file("./keys/task-demo.pem")
        
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
            # "docker --version",
            # "docker pull pritidevops/webapp:latest ."
            # "sudo chmod 666 /var/run/docker.sock"
        ]
    }
}



