#!/bin/bash
set -e
set -u

export HUGO_ENV=production
cd ..
hugo

WWW_FOLDER=/var/www/ducode.org
rm -rf $WWW_FOLDER/*
cp -R "./public/." "$WWW_FOLDER"
