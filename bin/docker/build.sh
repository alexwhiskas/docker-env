#!/bin/bash

echo -n "Do you want remove containers before build? (y/n)"
read rundown
if [ "$rundown" != "${rundown#[Yy]}" ]; then
  docker-compose down
fi

docker-compose build "$@"
