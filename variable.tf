variable "key" {
  type        = string
  default     = "task-demo"
  description = "description"
}

# Defining Private Key
variable "private_key" {
  default = "keys/key.pem"
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

variable "key_name" {
  type        = string
  default     = "jenkinspipeline-terra"
  description = "description"
}

variable "public_key" {
  type        = string
  default     = "test.pub"
  description = "description"
}

variable "private_key" {
  type        = string
  default     = "test.pem"
  description = "description"
}





