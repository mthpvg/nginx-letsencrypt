# nginx-letsencrypt

It serves multiple static websites with letsencrypt certificates.

## Prerequisites
- A DNS entry that links this **server**'s ip to f.e. `www.example.com`.

## Usage

### Start the service

```bash
# Prerequisite
sudo apt-get install -y git
# Setup
git clone https://github.com/mthpvg/nginx-letsencrypt.git
cd nginx-letsencrypt
# Start
./bin/start.sh
# Create a static website
./bin/create_website.sh name@provider.com www.example.com example.com
# Or:
./bin/create_website.sh name@provider.com sub.example.com
# Create a node application
./bin/create_node_application.sh name@provider.com www.example.com example.com
# Or:
./bin/create_node_application.sh name@provider.com sub.example.com
```
Change the content of the website in the following directory: `/var/www/example.com`. And check the result at http://www.example.com.

### Reloading Nginx
```bash
sudo systemctl reload nginx
```

## TODO
- www and non-www redirections
- logs
- set -eu
