resource "aws_instance" "jenkins-instance" {
  ami           = var.ami
  instance_type = "t2.micro"
  key_name      = "ubuntu-key"
  security_groups = ["${aws_security_group.UbuntuSG.name}"]
  user_data = file("install_jenkins.sh")

  tags  = {
    Name  = "jenkins-EC2"
  }
}

resource "aws_instance" "ansible-instance" {
  ami           = var.ami
  instance_type = "t2.micro"
  key_name      = "ubuntu-key"
  security_groups = ["${aws_security_group.UbuntuSG.name}"]
  user_data = file("install_ansible-docker.sh")

  tags  = {
    Name  = "ansible-EC2"
  }
}

resource "aws_instance" "k8s-instance" {
  ami           = var.ami
  instance_type = "t2.medium"
  key_name      = "ubuntu-key"
  security_groups = ["${aws_security_group.UbuntuSG.name}"]
  user_data = file("install_k8s.sh")

  tags  = {
    Name  = "k8s-EC2"
  }
}

# The default storage size of the created EC2 will be 8GB SSD and since we will be running minikube, kubectl and docker we will need more storage 
# So in this example we will make the storage 30GB which is the maximum free storage you can use
  root_block_device {
    volume_size = 30
    volume_type = "gp2"
    encrypted   = false
  }

