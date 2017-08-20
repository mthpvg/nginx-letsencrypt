#!/bin/bash

# $1 email
# $2 is www-domain
# $3 is no-www-domain

set -e

echo "Creating a directory for $2"
cd ./client
mkdir $2
cp index.template.html $2/index.html
cp -r $2 /var/www

echo "Setting a dummy Nginx config for Letsencrypt ACME challenge"
cd ../nginx
sed -e "s/SERVERNAME/$2 $3/g" -e "s/WEBSITE_DIRECTORY/$2/g" template > $2.conf
cp $2.conf /etc/nginx/sites-available
ln -s /etc/nginx/sites-available/$2.conf /etc/nginx/sites-enabled/

echo "Reloading Nginx"
sudo systemctl reload nginx

echo "Starting Letsencrypt ACME challenge"
cd ../client

if [ -z "$3" ]; then
sudo certbot certonly \
    --webroot \
    --webroot-path=/var/www/$2 \
    --agree-tos \
    --no-eff-email \
    --email $1 \
    -d $2
else
  sudo certbot certonly \
      --webroot \
      --webroot-path=/var/www/$2 \
      --agree-tos \
      --no-eff-email \
      --email $1 \
      -d $2 \
      -d $3
fi

echo "Setting the real Nginx config"
cd ../nginx
sed -e "s/SERVERNAME/$2 $3/g" -e "s/WEBSITE_DIRECTORY/$2/g" ssl-template > $2.conf
rm -rf /etc/nginx/sites-enabled/$2.conf
rm -rf /etc/nginx/sites-available/$2.conf
cp $2.conf /etc/nginx/sites-available
ln -s /etc/nginx/sites-available/$2.conf /etc/nginx/sites-enabled/

echo "Reloading Nginx"
sudo systemctl reload nginx

echo "Checking auto-renewal"
/usr/bin/certbot renew --dry-run

echo "Create a crontab or display it if it exists"
crontab -l

echo "Enabling auto renewal"
crontab -l | grep -q 'certbot'  && echo 'Auto Renewal is already in place' || (crontab -l 2>/dev/null; echo '15 3 * * * /usr/bin/certbot renew --quiet --renew-hook "docker restart static-nginx') | crontab -
