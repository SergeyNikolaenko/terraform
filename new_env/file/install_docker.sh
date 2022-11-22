#!/bin/bash

echo "###### Update OS - start"

apt-get update -y && apt-get upgrade -y

echo "###### Install App - start"

apt install -y \
curl \
wget \
ncdu \
lnav \
ca-certificates \
gnupg \
lsb-release 


echo "###### Install Docker Engine on Ubuntu - start"

mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

apt-get update

chmod a+r /etc/apt/keyrings/docker.gpg
apt-get update

apt install -y \
docker-ce \
docker-ce-cli \
containerd.io \
docker-compose-plugin

docker run -it -d nginx
sleep 3
docker ps


echo "###### Install CTOP - start"

wget https://github.com/bcicen/ctop/releases/download/v0.7.7/ctop-0.7.7-linux-amd64 -O /usr/local/bin/ctop
chmod +x /usr/local/bin/ctop

echo "###### END"

usermod -aG docker ubuntu
reboot
