FROM alpine:3.12
  
# Instalando o S6
ENV S6_OVERLAY_VERSION "2.1.0.2"
ENV PHP_VERSION=8.0.0-r0
ENV APCU_VERSION=5.1.19-r0
ENV PHP_REDIS_VERSION=5.3.2-r0
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
RUN echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \ 
	apk update && \
	apk add --no-cache \
	php8@testing=$PHP_VERSION \
	php8-common@testing=$PHP_VERSION \
 	php8-fpm@testing=$PHP_VERSION \
 	php8-xml@testing=$PHP_VERSION \
 	php8-pdo@testing=$PHP_VERSION \
 	php8-phar@testing=$PHP_VERSION \
 	php8-openssl@testing=$PHP_VERSION \
 	php8-pdo_mysql@testing=$PHP_VERSION \
 	php8-mysqli@testing=$PHP_VERSION \
 	php8-gd@testing=$PHP_VERSION \
 	php8-curl@testing=$PHP_VERSION \
 	php8-opcache@testing=$PHP_VERSION \
 	php8-ctype@testing=$PHP_VERSION \
 	php8-intl@testing=$PHP_VERSION \
 	php8-bcmath@testing=$PHP_VERSION \
 	php8-dom@testing=$PHP_VERSION \
 	php8-xmlreader@testing=$PHP_VERSION \
 	php8-pear@testing=$PHP_VERSION \
 	php8-mysqlnd@testing=$PHP_VERSION \
 	php8-pecl-apcu@testing=$APCU_VERSION \
 	php8-mbstring@testing=$PHP_VERSION \
 	php8-fileinfo@testing=$PHP_VERSION \
 	php8-session@testing=$PHP_VERSION \
 	php8-ldap@testing=$PHP_VERSION \
 	php8-iconv@testing=$PHP_VERSION \
 	php8-zip@testing=$PHP_VERSION \
	php8-pgsql@testing=$PHP_VERSION \
	php8-pdo_sqlite@testing=$PHP_VERSION \
	php8-pdo_pgsql@testing=$PHP_VERSION \
	php8-pecl-redis@testing=$PHP_REDIS_VERSION \
	php8-tokenizer@testing=$PHP_VERSION && \
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
RUN curl -sS https://getcomposer.org/installer | php8 -- --install-dir=/usr/bin --filename=composer

# Copiando arquivos de configuração
COPY rootfs/ /etc/
COPY conf/php-fpm.conf /etc/php8/php-fpm.conf
COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY conf/default.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

VOLUME ["/var/www/html"]

ENTRYPOINT ["/init"]