#!/bin/bash

docker build -t static-nginx .

docker run \
  -d \
  -v $(pwd)/client:/wwww/data:ro -p 80:80 \
  --name=static-nginx \
  static-nginx
