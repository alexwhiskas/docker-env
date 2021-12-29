#!/bin/bash

[ -z "$1" ] && echo "Define database name" && exit;
[ -z "$2" ] && echo "Define dump file path to create" && exit;

echo "$1 < $2"

./bin/docker/cli.sh --no-tty mysql mysql -uroot -proot $1 < $2;
