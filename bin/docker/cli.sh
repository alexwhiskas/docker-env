#!/bin/bash


if [ "$1" == "--use-tty" ]; then
  TTY_PARAM="-T "
  SERVICE=$2
  COMMAND=${@:3}
else
  TTY_PARAM=
  SERVICE=$1
  COMMAND=${@:2}
fi

#TTY_PARAM="-T "

# uncomment lines below to check if service name command will be passed correctly
#echo "Service: $SERVICE";
#echo "Command: $COMMAND";
#exit;

[ -z "$SERVICE" ] && echo "Define service name (ex. list of available services:)" \
  && docker-compose ps --services \
  && exit;

[ -z "$COMMAND" ] && echo "Define CLI command (ex. ls)" && exit;

docker-compose exec $TTY_PARAM$SERVICE $COMMAND;
