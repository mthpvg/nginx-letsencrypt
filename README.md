# docker-static-nginx

## Purpose
Serves static files from a nginx Docker's container.

## Prerequisites
- A server with:
  - docker
  - git
- A DNS entry that links your server's ip to `sub.domain.tld`.

## Usage

### Quick start

```bash
# Setup
git clone https://github.com/mthpvg/docker-static-nginx.git
cd docker-static-nginx/
# Create a website
./bin/create_website.sh sub.domain.tld
# Start
./bin/start.sh
```
Change the content of the website in the following directory: `client/sub.domain.tld`.

### Reload
```bash
./bin/reload.sh
```

### Stop
```bash
./bin/stop.sh
```

## Debug

### Interactive session
```bash
docker exec -it static-nginx bash
```

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
- Volume instead of copy to live edit static website?
- server name
- logs
- nginx config
- letsencrypt
- test mode, prod mode two Dockerfile
