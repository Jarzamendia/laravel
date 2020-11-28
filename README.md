# Laravel 

Imagem base para aplicações desenvolvidas em Laravel.

# S6 Overlay

Os processos filhos do Nginx e PHP são gerenciadas pelo S6 Overlay.

# Processos filhos

Você pode utilizar as seguintes variáveis de ambiente para controlar o número de processos filhos do PHP e Nginx. O ideal é utilizar 1 processo do Nginx por CPU disponível. 

    - ENV MAX_PHP_PROCESS=50
    - ENV NGINX_PROCESS=1

# Dependencias do PHP
    - php8
    - php8-fpm
	- php8-common
 	- php8-xml
 	- php8-pdo
 	- php8-phar
 	- php8-openssl
 	- php8-pdo_mysql
 	- php8-mysqli
    - php8-pgsql
	- php8-pdo_sqlite
	- php8-pdo_pgsql
	- php8-pecl-redis
 	- php8-gd
 	- php8-curl
 	- php8-opcache
 	- php8-ctype
 	- php8-intl
 	- php8-bcmath
 	- php8-dom
 	- php8-xmlreader
 	- php8-pear
 	- php8-mysqlnd
 	- php8-pecl-apcu
 	- php8-mbstring
 	- php8-fileinfo
 	- php8-session
 	- php8-ldap
 	- php8-iconv
 	- php8-zip
	- php8-tokenizer

# Como usar

docker run -it -v ./app:/var/www/html -p 80:80 laravel

# TODO

Atualizar versão do PHP8-ZIP, ela tem um bug na versão atual do PHP.