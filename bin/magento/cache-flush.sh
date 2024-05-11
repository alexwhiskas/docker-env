#!/bin/bash

source ./.env

if [ "$1" == "--hard" ]; then
  echo "Flushing Redis"
  ./bin/docker/redis-flush.sh
  echo "Removing all generated and cached files"
  (cd $LOCALHOST_PROJECT_PATH && sudo rm -rf generated/* pub/static/* var/cache/* var/view_preprocessed/*);
  echo "Flushing magento cache"
  ./bin/magento.sh cache:flush
  echo "Removing all generated and cached files"
  (cd $LOCALHOST_PROJECT_PATH && sudo rm -rf generated/* pub/static/* var/cache/* var/view_preprocessed/*);
else
./bin/magento.sh cache:flush "$@"
fi
