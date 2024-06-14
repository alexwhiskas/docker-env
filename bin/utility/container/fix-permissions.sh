#!/bin/bash

source ./.env

sudo chmod -R 777 $LOCALHOST_PROJECT_PATH

#(cd ../universal-drugstore-magento && sudo find var vendor pub/static pub/media app/etc \( -type f -or -type d \) -exec chmod u+w {} +);
#./bin/docker/php.sh chmod u+x bin/magento
