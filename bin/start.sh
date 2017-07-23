#!/bin/bash

echo 'Installing Letsencrypt cerbot'
sudo add-apt-repository -y ppa:certbot/certbot
sudo apt-get update
sudo apt-get install -y certbot

echo 'Generate Strong Diffie-Hellman Group'
sudo openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048

./bin/stop.sh

echo "Execute: docker build"
docker build -t static-nginx .

echo "Execute: docker run"
docker run \
  -d \
  -p 80:80 \
  -p 443:443 \
  -v $(pwd)/client:/www/data \
  -v $(pwd)/nginx:/etc/nginx/conf.d \
  -v /etc/letsencrypt:/etc/letsencrypt \
  -v /etc/ssl:/etc/ssl \
  --name=static-nginx \
  static-nginx
