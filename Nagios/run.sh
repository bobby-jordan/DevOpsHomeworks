vagrant up
sudo scp -r docker_setup.sh check_docker_container.sh scripts/master.sh config/master/ vagrant@192.168.99.100:.
sudo scp -r docker_setup.sh check_docker_container.sh scripts/nodeone.sh config/nodeone/ vagrant@192.168.99.101:.
sudo scp -r docker_setup.sh check_docker_container.sh scripts/nodetwo.sh config/nodetwo/ vagrant@192.168.99.102:.
