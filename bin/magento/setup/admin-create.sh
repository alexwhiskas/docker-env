#!/bin/bash

[ -z "$1" ] && echo "Define username" && exit
[ -z "$2" ] && echo "Define email address" && exit

./bin/magento.sh admin:user:create --admin-user $1 --admin-password=magent0 --admin-email=$2 --admin-firstname=admin --admin-lastname=magento

echo "Your password is 'magent0'";
