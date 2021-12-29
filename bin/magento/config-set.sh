#!/bin/bash

[ -z "$1" ] && echo "Define config path" && exit
[ -z "$2" ] && echo "Define config value" && exit

bin/magento.sh config:set $@
