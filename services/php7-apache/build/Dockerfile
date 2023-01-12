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

RUN apt-get install -y libwebp-dev

RUN docker-php-ext-configure gd --with-gd \
    --with-jpeg-dir=/usr \
    --with-png-dir=/usr \
    --with-freetype-dir=/usr \
    --enable-gd-jis-conv \
    --with-webp-dir=/usr
RUN docker-php-ext-install gd

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

# mailhog support
RUN apt-get install --no-install-recommends --assume-yes --quiet ca-certificates curl git && \
    rm -rf /var/lib/apt/lists/*;
# x86
RUN curl -Lsf 'https://storage.googleapis.com/golang/go1.8.3.linux-amd64.tar.gz' | tar -C '/usr/local' -xvzf -
ENV PATH /usr/local/go/bin:$PATH
RUN go get github.com/mailhog/mhsendmail
RUN cp /root/go/bin/mhsendmail /usr/bin/mhsendmail
RUN echo 'sendmail_path = /usr/bin/mhsendmail --smtp-addr mailhog:1025' > /usr/local/etc/php/php.ini;
