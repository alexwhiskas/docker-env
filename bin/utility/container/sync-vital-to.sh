#!/bin/bash

[ -z "$1" ] && echo "Define path to magento sources" && exit

# auth.json, compose.json, composer.lock, config.php, env.php

./bin/utility/container/copy-to.sh php-fpm $1/auth.json /var/www/src/app
./bin/utility/container/copy-to.sh php-fpm $1/composer.json /var/www/src
./bin/utility/container/copy-to.sh php-fpm $1/composer.lock /var/www/src
./bin/utility/container/copy-to.sh php-fpm $1/app/etc/config.php /var/www/src/app/etc
./bin/utility/container/copy-to.sh php-fpm $1/app/etc/env.php /var/www/src/app/etc
