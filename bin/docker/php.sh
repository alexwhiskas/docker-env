#!/bin/bash


# uncomment line below to print and check your values
#echo "Command to run: $@"

docker-compose exec -u www-data php-fpm "$@"
