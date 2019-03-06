#!/usr/bin/env bash
set -ex

# install dependencies
apt-get update
apt-get install -y --no-install-recommends \
   ca-certificates \
   curl \
   htop \
   nginx

cp /configs/nginx/nginx.service /lib/systemd/system/nginx.service
systemctl daemon-reload
systemctl enable nginx
systemctl start nginx

# install traefik
curl -fsSL "https://github.com/containous/traefik/releases/download/v1.7.9/traefik_linux-amd64" -o /usr/bin/traefik
chmod +x /usr/bin/traefik
cp /configs/traefik/traefik.service /lib/systemd/system/traefik.service
systemctl daemon-reload
systemctl enable traefik
systemctl start traefik

# create a big file
mkdir -p /var/www/webroot
dd if=/dev/urandom of=/var/www/webroot/big-file bs=64M count=16
