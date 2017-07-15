FROM nginx:1.12.1

WORKDIR /www/data
COPY ./client/* /www/data
COPY ./nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80 443
