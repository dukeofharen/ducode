#!/bin/bash
DIR="$(dirname "$0")"
cd $DIR

HASH_PATH=/tmp/ducode_hash

# Do a git pull and check if a new commit is available
git pull
git submodule update --remote

OLD_HASH=""
CURRENT_HASH=$(git rev-parse --short HEAD)

if [ -f "$HASH_PATH" ]; then
    OLD_HASH=$(cat $HASH_PATH)
fi

if [ "$OLD_HASH" != "$CURRENT_HASH" ]; then
    echo "Old hash is '$OLD_HASH' and current hash is '$CURRENT_HASH'. Rebuilding site."
    echo $CURRENT_HASH > $HASH_PATH
else
    echo "Old hash '$OLD_HASH' and current hash '$CURRENT_HASH' are the same. Not rebuilding site."
    exit 0
fi

export HUGO_ENV=production
cd ..
hugo

WWW_FOLDER=/var/www/ducode.org
rm -rf $WWW_FOLDER/*
cp -R "./public/." "$WWW_FOLDER"
