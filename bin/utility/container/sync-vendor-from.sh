#!/bin/bash

[ -z "$1" ] && echo "Define path to magento sources" && exit

./bin/utility/container/copy-from.sh php-fpm /var/www/src/vendor $1/
