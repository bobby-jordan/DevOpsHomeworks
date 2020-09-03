#!/bin/bash
echo "Add hosts"
echo "192.168.99.100 docker.dob.lab docker" >> /etc/hosts
echo "Add Docker repository ..."
sudo dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
echo "Add the missing dependency ..."
sudo dnf install -y https://download.docker.com/linux/centos/7/x86_64/stable/Packages/containerd.io-1.2.13-3.1.el7.x86_64.rpm
echo "Install Docker ..."
sudo dnf install -y docker-ce docker-ce-cli
echo "Enable and start Docker ..."
sudo systemctl enable docker
sudo systemctl start docker
echo "Firewall-open port 8080 ..."
sudo firewall-cmd --add-port=8080/tcp --permanent
echo "Firewall-set adapter zone ..."
sudo firewall-cmd --add-interface docker0 --zone trusted --permanent
echo "Fireall - reload rules ..."
sudo firewall-cmd --reload
echo "Add vagrant user to docker group ..."
sudo usermod -aG docker vagrant
