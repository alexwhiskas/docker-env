#!/bin/bash

[ -z "$1" ] && echo "Define PUBLIC_KEY" && exit;
[ -z "$2" ] && echo "Define PRIVATE_KEY" && exit;

./bin/composer.sh config --global http-basic.repo.magento.com $1 $2
