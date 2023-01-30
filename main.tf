#creating ec2 instance 
resource "aws_instance" "dev_terra" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name = var.key
  tags = {
    Env = "dev"
  }
}