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

echo 'Installing Node through nvm'
# From https://github.com/creationix/nvm
sudo apt-get install -y build-essential
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.8/install.sh | bash
nvm install 8

echo 'Installing pm2'
sudo npm install -g pm2

echo 'Generating a SSH key'
ssh-keygen -t rsa
echo "Copy the following public key in the Github's UI"
cat ~/.ssh/id_rsa.pub
