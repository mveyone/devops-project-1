#! /bin/bash
echo "--------------------Installing Docker--------------------"
sudo apt-get remove docker docker-engine docker.io containerd runc
sudo apt-get update -y 
sudo apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update -y
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y
Install ansible
echo "--------------------Installing Ansible--------------------"
sudo apt update -y
sudo apt install software-properties-common -y
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install ansible -y
Install docker-compose
echo "--------------------Installing Docker-compose--------------------" 
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
sudo chmod 666 /var/run/docker.sock
#Install AWS-CLI
echo "--------------------Installing AWS-CLI--------------------"
sudo apt-get install zip -y
sudo curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && unzip awscliv2.zip
sudo ./aws/install
#Install EksCtl
echo "--------------------Installing EKS-CTL--------------------"
sudo curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin
#Install Kubectl
echo "----------"----------Installing Kubectl"--------------------"
sudo curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
echo "$(<kubectl.sha256)  kubectl" | sha256sum --check
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl 
#Install Minikube
echo "--------------------Installing Minikube--------------------"
sudo curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
minikube start
minikube addons enable ingress
#Install K9s
echo "--------------------Installing K9s--------------------"
wget https://github.com/derailed/k9s/releases/download/v0.25.18/k9s_Linux_x86_64.tar.gz
sudo tar -xvzf k9s_Linux_x86_64.tar.gz
sudo install -m 755 k9s /usr/local/bin
#Add docker to sudo group
echo "--------------------Add Docker to Sudo group--------------------"
sudo groupadd docker 
sudo usermod -aG docker $USER 
sudo newgrp docker
 sudo chmod 777 /var/run/docker.sock
 echo "--------------------minikube start and installing nginx ingress---------------------"
 sudo minikube start
#  minikube addons enable ingress
 echo "--------------------install zip--------------------"
sudo apt install zip -y 
sudo apt install unzip -y
#Show Jenkins Password
# echo "--------------------Jenkins Password--------------------"
# sudo cat /var/lib/jenkins/secrets/initialAdminPassword