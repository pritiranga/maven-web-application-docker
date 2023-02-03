data "aws_security_group" "demosg" {
    id ="sg-06f293b32926c8afc"  
}

resource "aws_instance" "ec2" {
    ami = var.ami 
    instance_type = var.instance_type
    key_name= var.key
    aws_security_group = data.aws_security_group.demosg.id

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
            "sudo groupadd docker",
            "sudo usermod -aG docker $USER",
            "sudo newgrp docker",
            "sudo apt install docker.io",
            "docker --version",
            "docker build -t webapp .",
            "sudo chmod 666 /var/run/docker.sock",
            # "docker pull pritidevops/webapp:latest .",
            # "docker run -itd -p 8080:8080 pritidevops/webapp:latest --name web-app"
            
        ]
    }
}



