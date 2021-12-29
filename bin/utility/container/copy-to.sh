#!/bin/bash

[ -z "$1" ] && echo "Define service name to copy from" && exit
[ -z "$2" ] && echo "Define directory to copy from service container" && exit
[ -z "$3" ] && echo "Define directory to copy to localhost" && exit

SERVICE_NAME=$1
DIR_FROM=$2
DIR_TO=$3

docker cp $DIR_FROM "$(docker-compose ps -q $SERVICE_NAME)":$DIR_TO;
