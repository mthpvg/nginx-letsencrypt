#!/bin/bash

sudo add-apt-repository -y ppa:certbot/certbot
sudo apt-get update
sudo apt-get install -y certbot

./bin/stop.sh

echo "Execute: docker build"
docker build -t static-nginx .

echo "Execute: docker build"
docker run \
  -d \
  -p 80:80 \
  -v $(pwd)/client:/www/data \
  -v $(pwd)/nginx:/etc/nginx/conf.d \
  --name=static-nginx \
  static-nginx
