#!/bin/bash

[ -z "$1" ] && echo "Define ip address (ex. 127.0.0.1)" && exit
[ -z "$2" ] && echo "Define domain name (ex. m2.local)" && exit

if ! [ "$3" == "--no-port" ]; then
  if [ -z "$3" ]; then
    echo -n "Do you need to add ports? (y/n)?";
    read useport;
    if [ "$useport" != "${useport#[Yy]}" ]; then
      echo -n "Enter port (ex. ::1)"
      read port
    fi
  fi
fi

echo "IP $1";
echo "DOMAIN $2";

DOMAIN="$1 $2"
if ! ["$port" == ""]; then
  echo "PORT $port";
  DOMAIN="$1 $port $2"
fi

echo "You will be requested for superuser password to add line: '$DOMAIN' to yours /etc/hosts file";
echo "$DOMAIN" | sudo tee -a /etc/hosts

echo -n "Do you need to configure domain name in magento? (y/n)?";
read confmagedomain;
if [ "$confmagedomain" != "${confmagedomain#[Yy]}" ]; then
  echo "Setting domain to magento configs (web/secure/base_url, web/unsecure/base_url)";

  PROTOCOL="http"
  echo -n "Do you want to use 'https'? (y/n)?";
  read usehttps;
  if [ "$usehttps" != "${usehttps#[Yy]}" ]; then
      PROTOCOL="https"
  fi

  echo "Value to set: '$PROTOCOL://$2/'"

  bin/magento/config-set.sh web/secure/base_url "$PROTOCOL://$2/"
  bin/magento/config-set.sh web/unsecure/base_url "$PROTOCOL://$2/"
fi
