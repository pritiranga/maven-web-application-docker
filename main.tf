#creating ec2 instance 
resource "aws_instance" "dev_terra" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name = var.key
  tags = {
    Env = "dev"
  }
}

# Creating key pair
# resource "aws_key_pair" "demokey" {
#   key_name   = "${var.key_name}"
#   public_key = "${file(var.public_key)}"
# }
