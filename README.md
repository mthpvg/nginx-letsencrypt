# nginx-letsencrypt

It serves multiple static websites with letsencrypt certificates.

## Prerequisites
- A DNS entry that links this **server**'s ip to f.e. `example.com`.

## Usage

### Start the service

```bash
# Setup
git clone https://github.com/mthpvg/nginx-letsencrypt.git
cd nginx-letsencrypt
# Start
./bin/start.sh
# Create a website
./bin/create_website.sh name@provider.com www.example.com example.com
# Or:
./bin/create_website.sh name@provider.com sub.example.com
```
Change the content of the website in the following directory: `client/example.com`. And check the result at http://example.com.

### Stop the service
```bash
./bin/stop.sh
```

## Debug

### Working locally
Edit your hosts:
```bash
sudo vi /etc/hosts
```
Add the following line to `/etc/hosts` file:
```bash
127.0.0.1 app1.dev;
```
Run:
```bash
./bin/create_website.sh app1.dev
```
Visit http://app1.dev

## TODO
- server name
- logs
- nginx config
- set -eu
