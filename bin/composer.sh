#!/bin/bash

COMMAND=$@

docker-compose exec php-fpm composer $COMMAND;
