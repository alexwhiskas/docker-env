#!/bin/bash

echo -n "Do you want remove containers before start? (y/n)"
read rundown
if [ "$rundown" != "${rundown#[Yy]}" ]; then
  docker-compose down
fi

echo -n "Fixing elastic search memory issue"
./bin/utility/fix-elastic-memory-issue.sh
docker-compose up "$@"
