#!/bin/bash

[ -z "$1" ] && echo "Define path to folder to loop through children dirs" && exit;
[ -z "$2" ] && echo "Define command to run in each child dir" && exit;

for CHILD_DIR in $1*; do
    if [[ -d "$CHILD_DIR" ]]; then
        echo "DIR: $CHILD_DIR";

#        if [[ $CHILD_DIR != *"magento2-import"* ]]; then
#          if [[ $CHILD_DIR != *"magento2-rewards"* ]]; then
            (cd $CHILD_DIR && ${@:2});
#          fi;
#        fi;
    fi;
done;
