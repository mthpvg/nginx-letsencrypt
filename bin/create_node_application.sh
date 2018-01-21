#!/bin/bash

# $1 email
# $2 is node port
# $3 is www-domain
# $4 is no-www-domain

set -e

echo "--------------------------------"
echo "Email is: $1"
echo "Node's port is: $2"
echo "www-domain is: $3"
echo "no-www-domain is: $4"
echo "..."
read -p "Continue with those values (y/n)?" CONT
if [ "$CONT" = "y" ]; then
  echo "Let's go then";
else
  echo "Aborting!";
  exit 1
fi
echo "--------------------------------"

echo "Creating a directory for $3"
cd ./client
mkdir $3
cp -r node/* $3
sed -e "s/<PORT>/$2/g" $3/generic_index.js > $3/index.js
rm -rf $3/generic_index.js
cp -r $3 /var/www

echo "Starting the node application"
cd /var/www/$3
npm install
pm2 start index.js
cd -

echo "Setting a dummy Nginx config for Letsencrypt ACME challenge"
cd ../nginx
sed -e "s/SERVERNAMES/$3 $4/g" -e "s/WEBSITE_DIRECTORY/$3/g" -e "s/PORT/$2/g" node-template > $3.conf
cp $3.conf /etc/nginx/sites-available
ln -s /etc/nginx/sites-available/$3.conf /etc/nginx/sites-enabled/

echo "Reloading Nginx"
sudo systemctl reload nginx

echo "Starting Letsencrypt ACME challenge"
cd ../client

if [ -z "$4" ]; then
sudo certbot certonly \
    --webroot \
    --webroot-path=/var/www/$3/public \
    --agree-tos \
    --no-eff-email \
    --email $1 \
    -d $3
else
  sudo certbot certonly \
      --webroot \
      --webroot-path=/var/www/$3/public \
      --agree-tos \
      --no-eff-email \
      --email $1 \
      -d $3 \
      -d $4
fi

echo "Setting the real Nginx config"
cd ../nginx
sed -e "s/SERVERNAMES/$3 $4/g" -e "s/WEBSITE_DIRECTORY/$3/g" -e "s/NOWWWSERVERNAME/$4/g" -e "s/WWWSERVERNAME/$3/g" -e "s/PORT/$2/g" node-ssl-template > $3.conf
rm -rf /etc/nginx/sites-enabled/$3.conf
rm -rf /etc/nginx/sites-available/$3.conf
cp $3.conf /etc/nginx/sites-available
ln -s /etc/nginx/sites-available/$3.conf /etc/nginx/sites-enabled/

echo "Reloading Nginx"
sudo systemctl reload nginx

echo "Checking auto-renewal"
/usr/bin/certbot renew --dry-run

echo "Create a crontab or display it if it exists"
crontab -l

echo "Enabling auto renewal"
crontab -l | grep -q 'certbot'  && echo 'Auto Renewal is already in place' || (crontab -l 2>/dev/null; echo '15 3 * * * /usr/bin/certbot renew --quiet --renew-hook "docker restart static-nginx') | crontab -
