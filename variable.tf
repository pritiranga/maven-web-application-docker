variable "key" {
  type        = string
  default     = "terra-key"
  description = "description"
}

# Defining Private Key
variable "private_key" {
  default = "terra-key.pem"
}

# Defining Public Key
variable "public_key" {
  default = "terra-key.pub"
}

variable "region" {
    default = "us-east-1"
}

variable "ami" {
    default = "ami-0b93ce03dcbcb10f6"
}

variable "instance_type" {
    default = "t2.micro"
}

variable "bucket_prefix"{
    default = "terrform-jenkins"
}

variable "acl" {
  type        = string
  default     = "private"
  description = "description"
}

variable "versioning" {
  type        = string
  default     = true
  description = "description"
}







