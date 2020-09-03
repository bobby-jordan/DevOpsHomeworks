echo "* Add hosts ..."
echo "192.168.99.100 web.dof docker" >> /etc/hosts
echo "192.168.99.101 db.dof docker" >> /etc/hosts

echo "* Add Docker repository ..."
yum install -y https://download.docker.com/linux/centos/7/x86_64/stable/Packages/containerd.io-1.2.6-3.3.el7.x86_64.rpm
dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
echo "* Add the missing dependency ..."
dnf install -y https://download.docker.com/linux/centos/7/x86_64/stable/Packages/containerd.io-1.2.13-3.1.el7.x86_64.rpm
echo "* Install Docker ..."
dnf install -y docker-ce docker-ce-cli
dnf install docker-engine
echo "* Adjust Docker configuration ..."
mkdir -p /etc/docker
echo '{ "hosts": ["tcp://0.0.0.0:2375", "unix:///var/run/docker.sock"] }' | tee /etc/docker/daemon.json
mkdir -p /etc/systemd/system/docker.service.d/
echo [Service] | tee /etc/systemd/system/docker.service.d/docker.conf
echo ExecStart= | tee -a /etc/systemd/system/docker.service.d/docker.conf
echo ExecStart=/usr/bin/dockerd | tee -a /etc/systemd/system/docker.service.d/docker.conf
echo "* Enable and start Docker ..."
systemctl enable docker
systemctl start docker
echo "* Firewall - open port 80, 2375, and 8080 ..."
firewall-cmd --add-port=80/tcp --permanent
firewall-cmd --add-port=2375/tcp --permanent
firewall-cmd --add-port=8080/tcp --permanent
echo "* Firewall - set adapter zone ..."
firewall-cmd --add-interface docker0 --zone trusted --permanent
echo "* Firewall - reload rules ..."
firewall-cmd --reload
groupadd -f docker
echo "* Add vagrant user to docker group ..."
usermod -aG docker vagrant
