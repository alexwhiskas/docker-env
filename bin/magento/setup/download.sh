#!/bin/bash

[ -z "$1" ] && echo "Define edition" && exit;
[ -z "$2" ] && echo "Define version" && exit;
[ -z "$3" ] && echo "Define installation folder" && exit;

EDITION=$1
VERSION=$2
FOLDER=$3

if [ "$4" == "-v2" ]; then
  COMPOSER="composer-v2"
else
  COMPOSER="composer"
fi

./bin/docker/cli.sh --use-tty -u www-data php-fpm $COMPOSER create-project --repository=https://repo.magento.com/ magento/project-"${EDITION}"-edition="${VERSION}" ${FOLDER}
