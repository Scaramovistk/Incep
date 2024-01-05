#!/bin/bash

WP_URL=gscarama.42.fr
WP_TITLE=Inception
WP_ADMIN_USER=root1
WP_ADMIN_PASSWORD=qwerty@12
WP_ADMIN_EMAIL=root1@123.com
WP_USER=user1
WP_PASSWORD=qwerty@12
WP_EMAIL=user1@123.com
WP_ROLE=editor

chown -R www-data:www-data /var/www/wordpress/

if [-f "/var/www/wordpress/wp-config.php" ]; then
   mv /tmp/wp-config.php /var/www/wordpress/
fi

sleep 10

wp --allow-root --path="/var/www/wordpress/" core download || true

if ! wp --allow-root --path="/var/www/wordpress/" core is-installed;
then
    wp  --allow-root --path="/var/www/wordpress/" core install \
        --url=$WP_URL \
        --title=$WP_TITLE \
        --admin_user=$WP_ADMIN_USER \
        --admin_password=$WP_ADMIN_PASSWORD \
        --admin_email=$WP_ADMIN_EMAIL
fi;

if ! wp --allow-root --path="/var/www/wordpress/" user get $WP_USER;
then
    wp  --allow-root --path="/var/www/wordpress/" user create \
        $WP_USER \
        $WP_EMAIL \
        --user_pass=$WP_PASSWORD \
        --role=$WP_ROLE
fi;

wp --allow-root --path="/var/www/wordpress/" theme install writee --activate 

exec $@
