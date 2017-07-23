#!/bin/bash

# $1 email
# $2 is SERVERNAME

set -eu

cd ./client

mkdir $2
cp index.template.html $2/index.html

cd ../nginx

sed -e "s/SERVERNAME/$2/g" -e "s/WEBSITE_DIRECTORY/$2/g" ssl-template > $2.conf

docker restart static-nginx

cd ../client

DOMAINS='-d $2'

sudo certbot certonly \
    --webroot \
    --webroot-path=$(pwd)/$2 \
    --agree-tos \
    --no-eff-email \
    --email $1 \
    $DOMAINS
