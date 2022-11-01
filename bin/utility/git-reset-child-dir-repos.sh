#!/bin/bash

[ -z "$1" ] && echo "Define path to folder (with trailing slash, ex: ../src/vendor/)" && exit
[ -z "$2" ] && echo "Define dir in path to loop through children (with trailing slash, ex: magento/" && exit
[ -z "$3" ] && echo "Define main branch to use for packages" && exit

COMPOSER_BRANCH=$3

echo "Parsing composer.lock"
PACKAGES_REFERENCES=`php ./bin/utility/php-helper/parse-composer-lock.php --file-path=../universal-drugstore-magento/composer.lock --vendor-name=medisoft`
echo "DONE: Parsing composer.lock"

for CHILD_DIR in $1$2*; do
    if [[ -d "$CHILD_DIR" ]]; then
        echo "PACKAGE DIR: $CHILD_DIR"
        MODULE_NAME=$(basename $CHILD_DIR)
#        echo "Package: $MODULE_NAME"

        COMPOSER_LOCK_VERSION=$(jq '."'$2$MODULE_NAME'".version' <<< $PACKAGES_REFERENCES | tr -d '"')
#        COMPOSER_LOCK_INFO=$(jq '."'$2$MODULE_NAME'"' <<< $PACKAGES_REFERENCES | tr -d '"');
#        echo "COMPOSER_LOCK_INFO: $COMPOSER_LOCK_INFO";

#        echo "COMPOSER_LOCK_VERSION: $COMPOSER_LOCK_VERSION";
#        if [[ "$COMPOSER_LOCK_VERSION" != "dev-master" ]]; then
#          continue
#        fi;

        LOCAL_BRANCH_NAME=`(cd $CHILD_DIR && git rev-parse --abbrev-ref HEAD)`
        echo "Local branch is: $LOCAL_BRANCH_NAME"
        if [[ "$COMPOSER_BRANCH" != "$LOCAL_BRANCH_NAME" ]]; then
            echo -n "Change branch to $COMPOSER_BRANCH? (y/n)"
            read changebranch
            if [ "$changebranch" != "${changebranch#[Yy]}" ]; then
#               reset branch to composer.lock version
              (cd $CHILD_DIR && git checkout $COMPOSER_BRANCH)
              echo "Branch changed to: $COMPOSER_BRANCH"
            else
              echo "Terminated..."
              exit
            fi
        fi;

        COMPOSER_LOCK_REFERENCE=$(jq '."'$2$MODULE_NAME'".reference' <<< $PACKAGES_REFERENCES | tr -d '"')
        echo "COMPOSER_LOCK_REFERENCE: $COMPOSER_LOCK_REFERENCE"
        LOCAL_REFERENCE=`(cd $CHILD_DIR && git rev-parse HEAD)`
        echo "Composer reference is: $COMPOSER_LOCK_REFERENCE";
        echo "Local reference is: $LOCAL_REFERENCE";

        if [[ "$LOCAL_REFERENCE" != "$COMPOSER_LOCK_REFERENCE" ]]; then
            echo -n "Change pointing commit to $COMPOSER_LOCK_REFERENCE? (y/n)"

            read changecommit
            if [ "$changecommit" != "${changecommit#[Yy]}" ]; then
#               reset commit to composer.lock reference
                (cd $CHILD_DIR && git reset --hard $COMPOSER_LOCK_REFERENCE)
                echo "Commit changed to: $COMPOSER_LOCK_REFERENCE";
            else
              echo "Terminated..."
#              exit;
            fi

            echo "Fetching remote...";
            (cd $CHILD_DIR && git fetch)
        fi;
    fi;
done;
