#!/bin/bash

[ -z "$1" ] && echo "Define a domain name" && exit
[ -z "$2" ] && echo "Define ip address" && exit
[ -z "$3" ] && echo "Define locale" && exit
[ -z "$4" ] && echo "Define currency" && exit
[ -z "$5" ] && echo "Define timezone" && exit
[ -z "$6" ] && echo "Define amqp user" && exit
[ -z "$7" ] && echo "Define amqp password" && exit
[ -z "$8" ] && echo "Define execution directory" && exit

DOMAIN=$1
DEFAULT_IP=$2
MAGENTO_LOCALE=$3
MAGENTO_CURRENCY=$4
MAGENTO_TIMEZONE=$5
AMQP_USER=$6
AMQP_PASSWORD=$7
MAGENTO_DIRECTORY=$8

# uncomment line below to print and check your values
#echo $DOMAIN $DEFAULT_IP $MAGENTO_LOCALE $MAGENTO_CURRENCY $MAGENTO_TIMEZONE $AMQP_USER $AMQP_PASSWORD $MAGENTO_DIRECTORY;

./bin/docker/php.sh /bin/sh -c "(cd $MAGENTO_DIRECTORY && bin/magento setup:install \
  --db-host=\"mysql\" \
  --db-name=\"magento\" \
  --db-user=\"root\" \
  --db-password=\"root\" \
  --base-url=\"https://$DOMAIN/\" \
  --base-url-secure=\"https://$DOMAIN/\" \
  --backend-frontname=\"admin\" \
  --admin-firstname=\"admin\" \
  --admin-lastname=\"magento\" \
  --admin-email=\"admin@magento.com\" \
  --admin-user=\"admin\" \
  --admin-password=\"magent0\" \
  --language=\"$MAGENTO_LOCALE\" \
  --currency=\"$MAGENTO_CURRENCY\" \
  --timezone=\"$MAGENTO_TIMEZONE\" \
  --amqp-host=\"rabbitmq\" \
  --amqp-port=5672 \
  --amqp-user=\"$AMQP_USER\" \
  --amqp-password=\"$AMQP_PASSWORD\" \
  --amqp-virtualhost=/ \
  --cache-backend=\"redis\" \
  --cache-backend-redis-server=\"redis\" \
  --cache-backend-redis-db=0 \
  --page-cache=\"redis\" \
  --page-cache-redis-server=\"redis\" \
  --page-cache-redis-db=1 \
  --session-save=\"redis\" \
  --session-save-redis-host=\"redis\" \
  --session-save-redis-log-level=4 \
  --session-save-redis-db=2 \
  --use-rewrites=1)";
