# docker-static-nginx

## Purpose
Serves static files from a nginx Docker's container.

## Usage

### Start
```bash
git clone https://github.com/mthpvg/docker-static-nginx.git
cd docker-static-nginx/
docker build -t static-nginx .
docker run -d -p 80:80 --name=static-nginx static-nginx
```

### Stop

```bash
docker stop static-nginx
docker rm static-nginx
```

### Interactive session
```bash
docker exec -it static-nginx bash
```

### TODO
- Volume instead of copy to live edit static website?
- server name
- logs
- nginx config
- letsencrypt
- test mode, prod mode two Dockerfile
