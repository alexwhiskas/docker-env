FROM php:7.0-apache

#RUN apt-get update && apt-get install -y libapache2-mod-php7.0;

RUN a2enmod rewrite
RUN a2enmod php7
#RUN a2enmod security
RUN a2enmod deflate
RUN a2enmod ssl
RUN a2enmod expires
RUN a2enmod headers

# fix repo
# RUN printf "deb http://archive.debian.org/debian/ jessie main\ndeb-src http://archive.debian.org/debian/ jessie main\ndeb http://security.debian.org jessie/updates main\ndeb-src http://security.debian.org jessie/updates main" > /etc/apt/sources.list

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
    posix simplexml soap sockets zip mcrypt

RUN docker-php-ext-configure gd --with-gd \
    --with-jpeg-dir=/usr \
    --with-png-dir=/usr \
    --with-freetype-dir=/usr \
    --enable-gd-native-ttf \
    --enable-gd-jis-conv
RUN docker-php-ext-install gd

RUN docker-php-ext-install mbstring

RUN pecl install https://pecl.php.net/get/mongodb-1.7.5.tgz
RUN docker-php-ext-enable mongodb

RUN pecl install https://pecl.php.net/get/imagick-3.4.1.tgz \
	&& docker-php-ext-enable imagick

#RUN pecl install https://pecl.php.net/get/xdebug-2.5.5.tgz \
#    && docker-php-ext-enable xdebug

# Compile and install xdebug with the static property fix
RUN BEFORE_PWD=$(pwd) \
    && mkdir -p /opt/xdebug \
    && cd /opt/xdebug \
    && curl -k -L https://github.com/xdebug/xdebug/archive/XDEBUG_2_5_5.tar.gz | tar zx \
    && cd xdebug-XDEBUG_2_5_5 \
    && phpize \
    && ./configure --enable-xdebug \
    && make clean \
    && sed -i 's/-O2/-O0/g' Makefile \
    && make \
    # && make test \
    && make install \
    && cd "${BEFORE_PWD}" \
    && rm -r /opt/xdebug

RUN docker-php-ext-enable xdebug

RUN groupadd -g 1000 project
RUN useradd -u 1000 -g 1000 project


RUN ln -s /usr/local/bin/php /usr/bin/php

RUN pecl install -o -f redis \
&&  rm -rf /tmp/pear \
&&  docker-php-ext-enable redis
