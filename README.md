# docker-static-nginx

It serves multiple static websites from a single nginx Docker's container.

## Prerequisites
- A **server** with Docker and Git.
- A DNS entry that links this **server**'s ip to f.e. `example.com`.

## Usage

### Start the service

```bash
# Setup
git clone https://github.com/mthpvg/docker-static-nginx.git
cd docker-static-nginx/
# Start
./bin/start.sh
# Create a website
./bin/create_website.sh name@provider.com example.com
```
Change the content of the website in the following directory: `client/example.com`. And check the result at http://example.com.

### Restart Nginx
```bash
docker restart static-nginx
```

### Stop the service
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
- set -eu
