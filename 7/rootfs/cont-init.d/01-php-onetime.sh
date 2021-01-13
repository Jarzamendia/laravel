#!/usr/bin/with-contenv sh

touch /var/log/php-fpm.log
touch /var/log/php-fpm-access.log

sed -i "s|50|$MAX_PHP_PROCESS|" /etc/php7/php-fpm.conf
