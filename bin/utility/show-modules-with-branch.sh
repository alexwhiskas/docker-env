#!/bin/bash

[ -z "$1" ] && echo "Define path to folder (with trailing slash, ex: ../src/vendor/)" && exit
[ -z "$2" ] && echo "Define dir in path to loop through children (with trailing slash, ex: magento/" && exit
[ -z "$3" ] && echo "Define main branch to use for packages" && exit

COMPOSER_BRANCH=$3

for CHILD_DIR in $1$2*; do
    if [[ -d "$CHILD_DIR" ]]; then
        LOCAL_BRANCH_NAME=`(cd $CHILD_DIR && git rev-parse --abbrev-ref HEAD)`
        if [[ "$COMPOSER_BRANCH" == "$LOCAL_BRANCH_NAME" ]]; then
          echo "PACKAGE DIR: $CHILD_DIR"
        fi;
    fi;
done;
