FROM php:8.2-fpm

RUN apt-get update \
  && apt-get upgrade -y \
  && apt-get install -y --no-install-recommends \
  apt-utils \
  sendmail-bin \
  sendmail \
  sudo \
  iproute2 \
  git \
  libbz2-dev \
  libjpeg62-turbo-dev \
  libpng-dev \
  libfreetype6-dev \
  libgmp-dev \
  libgpgme11-dev \
  libicu-dev \
  libldap2-dev \
  libpcre3-dev \
  libpspell-dev \
  libtidy-dev \
  libxslt1-dev \
  libyaml-dev \
  libzip-dev \
  zip \
  libmagickwand-dev \
  ca-certificates \
  curl \
  git \
  && rm -rf /var/lib/apt/lists/*

RUN pecl install -o -f \
  gnupg \
  mailparse \
  msgpack \
  oauth \
  pcov \
  raphf \
  redis \
  xmlrpc-1.0.0RC3 \
  yaml \
  imagick \
  xdebug

RUN docker-php-ext-enable xdebug
RUN docker-php-ext-configure gd --with-freetype=/usr/include/ --with-jpeg=/usr/include/

RUN docker-php-ext-install -j$(nproc) \
  bcmath \
  bz2 \
  calendar \
  exif \
  gd \
  gettext \
  gmp \
  intl \
  ldap \
  mysqli \
  opcache \
  pdo_mysql \
  pspell \
  shmop \
  soap \
  sockets \
  sysvmsg \
  sysvsem \
  sysvshm \
  tidy \
  xsl \
  zip \
  pcntl

# mailhog support start
RUN curl -Lsf 'https://golang.org/dl/go1.17.1.linux-arm64.tar.gz' | tar -C '/usr/local' -xvzf - # arm, mainly for apple silicon support

ENV PATH /usr/local/go/bin:$PATH
RUN go get github.com/mailhog/mhsendmail
RUN cp /root/go/bin/mhsendmail /usr/bin/mhsendmail
RUN echo 'sendmail_path = /usr/bin/mhsendmail --smtp-addr mailhog:1025' > /usr/local/etc/php/php.ini
# mailhog support end

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer;
