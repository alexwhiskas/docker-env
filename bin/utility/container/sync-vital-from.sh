#!/bin/bash

[ -z "$1" ] && echo "Define path to magento sources" && exit

# auth.json, compose.json, composer.lock, config.php, env.php

./bin/utility/container/copy-from.sh php-fpm /var/www/src/auth.json $1
./bin/utility/container/copy-from.sh php-fpm /var/www/src/composer.json $1/app
./bin/utility/container/copy-from.sh php-fpm /var/www/src/composer.lock $1/app
./bin/utility/container/copy-from.sh php-fpm /var/www/src/app/etc/config.php $1/app/etc
./bin/utility/container/copy-from.sh php-fpm /var/www/src/app/etc/env.php $1/app/etc
