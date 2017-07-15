# docker-static-nginx

## Build the image
```bash
docker build -t static-nginx .
```

### Run the image
```bash
docker run -p 80:80 static-nginx
```
Visit: http://localhost:80

### TODO
- Volume instead of copy to live edit static website?
- 80 port?
- server name
- logs
- nginx config
- letsencrypt
- test mode, prod mode two Dockerfile
