#!/bin/bash

pwd=$(pwd)

cd client

prompt="Please select a file, to remove type its number:"
PS3="$prompt "

options=( $(ls) )

select opt in "${options[@]}" "ABORT" ; do
    if (( REPLY == 1 + ${#options[@]} )) ; then
        exit

    elif (( REPLY > 0 && REPLY <= ${#options[@]} )) ; then
        echo  "You picked $opt which is file $REPLY"
        break

    else
        echo "Invalid option. Try another one."
    fi
done

echo "Cleaning $(pwd)"
mv $opt $pwd/trash/client

echo "Going back to:"
cd -

cd nginx
echo "Cleaning $(pwd)"
mv $opt.conf $pwd/trash/nginx

echo "Going back to:"
cd -

cd /var/www
echo "Cleaning $(pwd)"
mv $opt $pwd/trash/var-www

echo "Going back to:"
cd -

cd /etc/nginx/sites-available
echo "Cleaning $(pwd)"
mv $opt.conf $pwd/trash/etc-nginx-available

echo "Going back to:"
cd -

cd /etc/nginx/sites-enabled
echo "Cleaning $(pwd)"
mv $opt.conf $pwd/trash/etc-nginx-enabled

echo "Going back to:"
cd -

cd /etc/letsencrypt/archive
echo "Cleaning $(pwd)"
mv $opt $pwd/trash/etc-letsencrypt-archive

echo "Going back to:"
cd -

cd /etc/letsencrypt/live
echo "Cleaning $(pwd)"
mv $opt $pwd/trash/etc-letsencrypt-live

echo "Going back to:"
cd -

cd /etc/letsencrypt/renewal
echo "Cleaning $(pwd)"
mv $opt.conf $pwd/trash/etc-letsencrypt-renewal

pm2 status

echo "! Don't forget to STOP and DELETE the pm2 process if it was a node app. !"
