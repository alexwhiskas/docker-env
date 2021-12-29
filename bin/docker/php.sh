#!/bin/bash

echo "Command to run: $@"

docker-compose exec -u www-data php-fpm "$@"
