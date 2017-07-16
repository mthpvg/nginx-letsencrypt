#!/bin/bash

#$1 is SERVERNAME
#$2 is WEBSITE_DIRECTORY

cd ./client

mkdir $1
cp index.html.template $1/index.html

cd ../nginx

sed -e "s/SERVERNAME/$1/g" -e "s/WEBSITE_DIRECTORY/$1/g" template > $1.conf
