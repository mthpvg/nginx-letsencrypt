#!/bin/bash

# $1 is SERVERNAME
# $2 email

cd ./client

mkdir $1
cp index.template.html $1/index.html

cd ../nginx

sed -e "s/SERVERNAME/$1/g" -e "s/WEBSITE_DIRECTORY/$1/g" template > $1.conf

docker restart static-nginx

sudo certbot certonly --webroot --webroot-path=/www/data/$1 --agree-tos --email $2 -d $1
