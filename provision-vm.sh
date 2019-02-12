#!/usr/bin/env bash

# install Docker
apt-get update
apt-get install -y --no-install-recommends \
   apt-transport-https \
   ca-certificates \
   curl \
   gnupg-agent \
   software-properties-common \
   htop
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
apt-get update
apt-get install -y --no-install-recommends \
   docker-ce \
   docker-ce-cli \
   containerd.io
usermod -a -G docker vagrant

# create a big file
mkdir -p /var/www/webroot
dd if=/dev/urandom of=/var/www/webroot/big-file bs=64M count=16

# initialize Docker Swarm
docker swarm init --advertise-addr 172.10.10.10

# download Images and start containers
docker pull nginx:stable-alpine
docker pull traefik:1.7.8

docker stack deploy -c /configs/docker-stack.yml --resolve-image always traefik-debugging
