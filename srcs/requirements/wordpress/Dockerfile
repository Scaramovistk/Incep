FROM debian:bullseye

RUN apt-get update && apt-get -y install \
    wget \
    php7.4 \
    php-cgi \
    php-mysql \
    php-fpm \
    php-pdo \
    php-gd php-cli \
    php-mbstring \
    && rm -rf /var/lib/apt/lists/*

COPY ./conf/www.conf /var/www/html/

RUN mkdir /run/php

COPY ./tools/wordpress_start.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/wordpress_start.sh

ENTRYPOINT ["/usr/local/bin/wordpress_start.sh"]

WORKDIR /var/www/html/

EXPOSE 9000

CMD ["/usr/sbin/php-fpm7.4", "-F"]
