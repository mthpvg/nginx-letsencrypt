FROM nginx:1.12.1

WORKDIR /www/data
RUN rm /etc/nginx/conf.d/default.conf
COPY ./nginx/*.conf /etc/nginx/conf.d/

EXPOSE 80 443
