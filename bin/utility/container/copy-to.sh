#!/bin/bash

[ -z "$1" ] && echo "Define service name to copy to" && exit
[ -z "$2" ] && echo "Define path to copy from localhost" && exit
[ -z "$3" ] && echo "Define path to copy to service container" && exit

SERVICE_NAME=$1
DIR_FROM=$2
DIR_TO=$3

docker cp $DIR_FROM "$(docker-compose ps -q $SERVICE_NAME)":$DIR_TO;
