#!/bin/bash

[ -z "$1" ] && echo "Define service name to copy from" && exit
[ -z "$2" ] && echo "Define path to copy from service container" && exit
[ -z "$3" ] && echo "Define path to copy to localhost" && exit

SERVICE_NAME=$1
DIR_FROM=$2
DIR_TO=$3

docker cp "$(docker-compose ps -q $SERVICE_NAME)":$DIR_FROM $DIR_TO;
