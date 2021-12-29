#!/bin/bash

if [ -z "$1" ]; then
  ./bin/docker/cli.sh --no-tty php-fpm chown -R www-data:www-data /var/www/src
else
  ./bin/docker/cli.sh --no-tty php-fpm chown -R www-data:www-data $1
fi
