#!/bin/bash

# $1 email
# $2 is SERVERNAME

set -eu

echo "Creating a directory for $2"
cd ./client
mkdir $2
cp index.template.html $2/index.html

echo "Setting a dummy Nginx config for Letsencrypt ACME challenge"
cd ../nginx
sed -e "s/SERVERNAME/$2/g" -e "s/WEBSITE_DIRECTORY/$2/g" template > $2.conf

echo "Restarting Nginx"
docker restart static-nginx

echo "Starting Letsencrypt ACME challenge"
cd ../client

sudo certbot certonly \
    --webroot \
    --webroot-path=$(pwd)/$2 \
    --agree-tos \
    --no-eff-email \
    --email $1 \
    -d $2

echo "Setting the real Nginx config"
cd ../nginx
sed -e "s/SERVERNAME/$2/g" -e "s/WEBSITE_DIRECTORY/$2/g" ssl-template > $2.conf

echo "Restarting Nginx"
docker restart static-nginx

echo "Checking auto-renewal"
/usr/bin/certbot renew --dry-run

echo "Enabling auto renewal"
crontab -l | grep -q 'certbot'  && echo 'Auto Renewal is already in place' || (crontab -l 2>/dev/null; echo '15 3 * * * /usr/bin/certbot renew --quiet --renew-hook "docker restart static-nginx') | crontab -
