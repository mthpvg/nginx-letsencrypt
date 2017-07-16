#!/bin/bash

./bin/stop.sh

echo "Execute: docker build"
docker build -t static-nginx .

echo "Execute: docker build"
docker run \
  -d \
  -p 80:80 \
  --name=static-nginx \
  static-nginx
