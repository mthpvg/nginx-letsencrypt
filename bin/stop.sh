#!/bin/bash

echo "Execute: docker stop"
docker stop static-nginx
echo "Execute: docker remove"
docker rm static-nginx
