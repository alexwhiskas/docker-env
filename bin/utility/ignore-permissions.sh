#!/bin/bash

[ -z "$1" ] && echo "Define path to folder to set 'git config core.fileMode false' in children directories" && exit;

for FILE in $1*; do
    if [[ -d "$FILE" ]]; then
        echo "DIR: $FILE";
        (cd $FILE && git config core.fileMode false);
    fi;
done;
