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