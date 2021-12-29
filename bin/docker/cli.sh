#!/bin/bash

if [ "$1" == "--no-tty" ]; then
  NO_TTY="-T"
  SERVICE=$2
  COMMAND=${@:3}
else
  NO_TTY=
  SERVICE=$1
  COMMAND=${@:2}
fi

# uncomment lines below to check if service name command will be passed correctly
#echo "Service: $SERVICE";
#echo "Command: $COMMAND";
#exit;

[ -z "$SERVICE" ] && echo "Define service name (ex. list of available services:)" \
  && docker-compose ps --services \
  && exit;

[ -z "$COMMAND" ] && echo "Define CLI command (ex. ls)" && exit;

docker-compose exec $NO_TTY $SERVICE $COMMAND;
