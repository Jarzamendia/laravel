#!/usr/bin/with-contenv sh

sed -i "s|worker_processes 1|worker_processes $NGINX_PROCESS|" /etc/nginx/nginx.conf
sed -i "s|fastcgi_pass php:9000|fastcgi_pass $PHP_HOST|" /etc/nginx/conf.d/default.conf