#!/bin/bash

if [ "$1" == "-v2" ]; then
  COMPOSER="composer-v2"
  COMMAND="${@:2}"
else
  COMPOSER="composer"
  COMMAND=$@
fi

./bin/docker/cli.sh -u www-data php-fpm $COMPOSER $COMMAND
