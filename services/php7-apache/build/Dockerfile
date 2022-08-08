FROM php:7.2.24-apache

RUN a2enmod rewrite
RUN a2enmod php7
RUN a2enmod deflate
RUN a2enmod ssl
RUN a2enmod expires
RUN a2enmod headers

RUN apt-get update && apt-get install -y \
    zlib1g-dev \
    libzip-dev \
    libcurl4-openssl-dev \
    libonig-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libssl-dev \
    libxml2-dev \
    libmcrypt-dev        \
    libmagickwand-dev --no-install-recommends

RUN docker-php-ext-install curl iconv json mbstring mysqli pdo pdo_mysql \
    posix simplexml soap sockets zip

RUN docker-php-ext-configure gd --with-gd \
    --with-jpeg-dir=/usr \
    --with-png-dir=/usr \
    --with-freetype-dir=/usr \
    --enable-gd-native-ttf \
    --enable-gd-jis-conv
RUN docker-php-ext-install gd

RUN docker-php-ext-install mbstring

RUN pecl install xdebug-2.7.0 \
    && docker-php-ext-enable xdebug

RUN groupadd -g 1000 project
RUN useradd -u 1000 -g 1000 project

RUN ln -s /usr/local/bin/php /usr/bin/php

RUN pecl install mcrypt-1.0.1 \
    && docker-php-ext-enable mcrypt

RUN pecl install -o -f redis \
&&  rm -rf /tmp/pear \
&&  docker-php-ext-enable redis
