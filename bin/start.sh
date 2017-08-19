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
