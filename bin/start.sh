#!/bin/bash

echo 'Installing Letsencrypt cerbot'
sudo apt-get update
sudo apt-get install -y software-properties-common git
sudo add-apt-repository -y ppa:certbot/certbot
sudo apt-get update
sudo apt-get install -y certbot

echo 'Generate Strong Diffie-Hellman Group... it can take a while'
sudo openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048

echo 'Installing Nginx'
sudo apt-get install -y nginx

echo 'Installing Node'
# From https://www.digitalocean.com/community/tutorials/how-to-install-node-js-on-ubuntu-16-04#how-to-install-using-a-ppa
curl -sL https://deb.nodesource.com/setup_6.x -o nodesource_setup.sh
sudo bash nodesource_setup.sh
sudo apt-get install -y nodejs build-essential

echo 'Installing pm2'
sudo npm install -g pm2
