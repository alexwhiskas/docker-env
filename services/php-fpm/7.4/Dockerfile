FROM php:7.4-fpm

RUN apt-get update && apt-get install -y \
    libonig-dev \
    libpq-dev \
    zlib1g-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libmcrypt-dev \
    curl \
    libxml2-dev \
    libxslt-dev \
    libmagickwand-dev \
    libxslt-dev \
    gzip \
    libzip-dev \
    zip \
    unzip;

RUN docker-php-ext-install opcache xml intl mbstring bcmath json iconv soap sockets xsl mysqli pdo_mysql zip iconv;
RUN docker-php-ext-configure gd --with-jpeg=/usr/include/ --with-freetype=/usr/include/
RUN docker-php-ext-install gd;

# mailhog support
RUN apt-get install --no-install-recommends --assume-yes --quiet ca-certificates curl git && \
    rm -rf /var/lib/apt/lists/*;
# x86
RUN curl -Lsf 'https://storage.googleapis.com/golang/go1.8.3.linux-amd64.tar.gz' | tar -C '/usr/local' -xvzf -
# arm, mainly for apple silicon support
#RUN curl -Lsf 'https://golang.org/dl/go1.17.1.linux-arm64.tar.gz' | tar -C '/usr/local' -xvzf -
ENV PATH /usr/local/go/bin:$PATH
RUN go get github.com/mailhog/mhsendmail
RUN cp /root/go/bin/mhsendmail /usr/bin/mhsendmail
RUN echo 'sendmail_path = /usr/bin/mhsendmail --smtp-addr mailhog:1025' > /usr/local/etc/php/php.ini;

# ioncube loader support, uncomment for preferred CPU architecture (need to place your files into 'etc' folder first)
# x86
#COPY ./etc/ioncube/ioncube_loader_lin_7.4.so /usr/local/lib/php/extensions/no-debug-non-zts-20190902/ioncube_loader_lin_7.4
# arm, mainly for apple silicon support
#COPY ./etc/ioncube-arm/ioncube_loader_lin_7.4.so /usr/local/lib/php/extensions/no-debug-non-zts-20190902/ioncube_loader_lin_7.4
#RUN docker-php-ext-enable ioncube_loader_lin_7.4;

RUN pecl install mcrypt-1.0.4 imagick &&  docker-php-ext-enable mcrypt imagick;
# use 'xdebug-2.9.8' or 'xdebug' to install preferred version
RUN pecl install xdebug;
RUN docker-php-ext-enable xdebug;

RUN mkdir -p /var/www/src /var/www/.composer;
RUN chown -R www-data:www-data /var/www/src /var/www/.composer;

RUN curl -sS https://getcomposer.org/installer | php -- --1 --install-dir=/usr/local/bin --filename=composer;
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer-v2;
