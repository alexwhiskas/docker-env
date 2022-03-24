#!/bin/bash

[ -z "$1" ] && echo "Define path to magento sources" && exit

./bin/utility/container/copy-to.sh php-fpm $1/vendor /var/www/src
