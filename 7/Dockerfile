FROM alpine:3.12
  
# Instalando o S6
ENV S6_OVERLAY_VERSION "2.1.0.2"
ENV PHP_VERSION=7.3.26-r0
ENV APCU_VERSION=5.1.19-r0
ENV PHP_REDIS_VERSION=5.2.2-r1
ENV MAX_PHP_PROCESS=50
ENV NGINX_PROCESS=1

# Instalando dependencias
RUN apk add --no-cache nginx wget ca-certificates mysql-client msmtp \
					libssh2 curl libpng freetype libgcc libjpeg-turbo \ 
					libxml2 libstdc++ icu-libs libltdl libmcrypt libzip

# Instalando o S6 Overlay
RUN cd /tmp && \
	wget https://github.com/just-containers/s6-overlay/releases/download/v$S6_OVERLAY_VERSION/s6-overlay-amd64.tar.gz && \
	tar xzf s6-overlay-amd64.tar.gz -C / && \
	rm s6-overlay-amd64.tar.gz;

# Instalando o PHP-FPM e componentes
RUN apk update && \
	apk add --no-cache \
	php7=$PHP_VERSION \
	php7-common=$PHP_VERSION \
 	php7-fpm=$PHP_VERSION \
 	php7-xml=$PHP_VERSION \
 	php7-pdo=$PHP_VERSION \
 	php7-phar=$PHP_VERSION \
 	php7-openssl=$PHP_VERSION \
 	php7-pdo_mysql=$PHP_VERSION \
 	php7-mysqli=$PHP_VERSION \
 	php7-gd=$PHP_VERSION \
 	php7-curl=$PHP_VERSION \
 	php7-opcache=$PHP_VERSION \
 	php7-ctype=$PHP_VERSION \
 	php7-intl=$PHP_VERSION \
 	php7-bcmath=$PHP_VERSION \
 	php7-dom=$PHP_VERSION \
 	php7-xmlreader=$PHP_VERSION \
 	php7-pear=$PHP_VERSION \
 	php7-mysqlnd=$PHP_VERSION \
 	php7-pecl-apcu=$APCU_VERSION \
 	php7-mbstring=$PHP_VERSION \
 	php7-fileinfo=$PHP_VERSION \
 	php7-session=$PHP_VERSION \
 	php7-ldap=$PHP_VERSION \
 	php7-iconv=$PHP_VERSION \
 	php7-zip=$PHP_VERSION \
	php7-pgsql=$PHP_VERSION \
	php7-pdo_sqlite=$PHP_VERSION \
	php7-pdo_pgsql=$PHP_VERSION \
	php7-pecl-redis=$PHP_REDIS_VERSION \
	php7-tokenizer=$PHP_VERSION && \
    ln -sf /dev/stdout /var/log/php-fpm-access.log && \
	ln -sf /dev/stderr /var/log/php-fpm.log && \
	ln -sf /dev/stdout /var/log/nginx/access.log && \
	ln -sf /dev/stderr /var/log/nginx/error.log

# Criando usuário www-data
RUN set -x ; \
	addgroup -g 82 -S www-data ; \
	adduser -u 82 -D -S -G www-data www-data; \
	mkdir -p /var/www/html; \
	chown -R www-data:www-data /var/www/html

# Instalando o composer
RUN curl -sS https://getcomposer.org/installer | php7 -- --install-dir=/usr/bin --filename=composer

# Copiando arquivos de configuração
COPY rootfs/ /etc/
COPY conf/php-fpm.conf /etc/php7/php-fpm.conf
COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY conf/default.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

VOLUME ["/var/www/html"]

ENTRYPOINT ["/init"]