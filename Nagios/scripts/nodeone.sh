sudo dnf install -y epel-release
sudo dnf config-manager --set-enabled PowerTools
sudo dnf install -y nrpe nrpe-selinux tree nagios-plugins-nrpe nagios-plugins-all nagios nagios-common nagios-selinux
sudo systemctl enable --now httpd
sudo systemctl enable --now nagios
sudo firewall-cmd --add-service={http,https} --permanent
sudo firewall-cmd --add-port=3306/tcp --permanent
sudo firewall-cmd --reload
sudo systemctl enable --now nrpe
echo 'command[check-docker-container]=/usr/lib64/nagios/plugins/check_docker_container.sh $ARG1$' >> /etc/nagios/nrpe.cfg
sudo cp -f localhost.cfg /etc/nagios/objects/localhost.cfg
sudo cp -f -r nodeone/ /etc/nagios/objects/files
sudo rm /etc/nagios/objects/files/localhost.cfg
echo 'cfg_dir=/etc/nagios/objects/files' >> /etc/nagios/nagios.cfg
sudo nagios -v /etc/nagios/nagios.cfg
sudo systemctl restart nagios

echo '<h1>Remote host: Demo site.</h1>' | sudo tee /var/www/html/index.html
