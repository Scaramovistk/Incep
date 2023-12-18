FROM debian:bullseye

EXPOSE 81

RUN apt-get update && apt-get -y install nginx \
openssl \
&& rm -rf /var/lib/apt/lists/*

COPY conf/nginx.conf /etc/nginx/conf.dh
COPY ./tools/nginx_start.sh /var/www

RUN chmod +x /var/www/nginx_start.sh

ENTRYPOINT [ "var/www/nginx_start.sh" ]

CMD ["nginx", "-g", "daemon off;"]
