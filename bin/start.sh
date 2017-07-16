#!/bin/bash

./bin/stop.sh

cd ..

echo "Execute: docker build"
docker build -t static-nginx .

echo "Execute: docker build"
docker run \
  -v $(pwd)/client:/wwww/data:ro -p 80:80 \
  --name=static-nginx \
  static-nginx
