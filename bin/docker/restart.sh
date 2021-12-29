#!/bin/bash

if [ "$1" == "--hard" ]; then
  docker-compose down
  docker-compose up -d
else
  docker-compose restart
fi
