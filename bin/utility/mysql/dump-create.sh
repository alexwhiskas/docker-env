#!/bin/bash

[ -z "$1" ] && echo "Define database name" && exit;
[ -z "$2" ] && echo "Define dump file path to create" && exit;
[ -z "$3" ] && echo "Define dump file name to create" && exit;

./bin/docker/cli.sh mysql mysqldump -uroot -proot \
  --no-tablespaces --single-transaction --skip-opt --add-drop-table --create-options --extended-insert --quick --set-charset -y \
  $1 | tail -n +2 > $2`date +$USER.$3.%Y_%m_%d_%H_%M_%S.sql`;
