resource "aws_security_group" "UbuntuSG" {

  # ingress {
  #   from_port = 22
  #   to_port   = 22
  #   protocol  = "tcp"
  #   cidr_blocks  = ["0.0.0.0/0"]
  # }
  ingress {
    from_port = 0
    to_port   = 65535
    protocol  = "tcp"
    cidr_blocks  = ["0.0.0.0/0"]
  }
  

  egress  {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "tls_private_key" "pk" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "UbuntuKP" {
  key_name = "ubuntu-key"
  public_key = var.public_key

#   provisioner "local-exec" {
#     command = "echo '${tls_private_key.pk.private_key_pem}' > ./ubuntu-key.pem"
#   }
}