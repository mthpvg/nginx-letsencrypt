#!/bin/bash

set -e

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
if [ -e "$opt" ]; then
  rm -rf $pwd/trash/client/$opt
  mv $opt $pwd/trash/client
fi

echo "Going back to:"
cd -

cd nginx
echo "Cleaning $(pwd)"
if [ -e "$opt.conf" ]; then
  rm -rf $pwd/trash/nginx/$opt.conf
  mv $opt.conf $pwd/trash/nginx
fi

echo "Going back to:"
cd -

cd /var/www
echo "Cleaning $(pwd)"
if [ -e "$opt" ]; then
  rm -rf $pwd/trash/var-www/$opt
  mv $opt $pwd/trash/var-www
fi

echo "Going back to:"
cd -

cd /etc/nginx/sites-available
echo "Cleaning $(pwd)"
if [ -e "$opt.conf" ]; then
  rm -rf $pwd/trash/etc-nginx-available/$opt.conf
  mv $opt.conf $pwd/trash/etc-nginx-available
fi

echo "Going back to:"
cd -

cd /etc/nginx/sites-enabled
echo "Cleaning $(pwd)"
if [ -e "$opt.conf" ]; then
  rm -rf $pwd/trash/etc-nginx-enabled/$opt.conf
  mv $opt.conf $pwd/trash/etc-nginx-enabled
fi

echo "Going back to:"
cd -

cd /etc/letsencrypt/archive
echo "Cleaning $(pwd)"
if [ -e "$opt" ]; then
  rm -rf $pwd/trash/etc-letsencrypt-archive/$opt
  mv $opt $pwd/trash/etc-letsencrypt-archive
fi

echo "Going back to:"
cd -

cd /etc/letsencrypt/live
echo "Cleaning $(pwd)"
if [ -e "$opt" ]; then
  rm -rf $pwd/trash/etc-letsencrypt-live/$opt
  mv $opt $pwd/trash/etc-letsencrypt-live
fi

echo "Going back to:"
cd -

cd /etc/letsencrypt/renewal
echo "Cleaning $(pwd)"
if [ -e "$opt.conf" ]; then
  rm -rf $pwd/trash/etc-letsencrypt-renewal/$opt.conf
  mv $opt.conf $pwd/trash/etc-letsencrypt-renewal
fi

echo -e '\e[34You might want to stop the pm2 process if it exists\e[39m'
echo 'pm2 stop $opt'
echo 'delete $opt'
