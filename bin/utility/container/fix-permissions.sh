#!/bin/bash

./bin/docker/php.sh find var vendor pub/static pub/media app/etc \( -type f -or -type d \) -exec chmod u+w {} +;
./bin/docker/php.sh chmod u+x bin/magento
