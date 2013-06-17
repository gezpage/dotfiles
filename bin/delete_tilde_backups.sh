#!/bin/sh

echo "recursively removing backup files from"
pwd
echo -e "Break now if you do not wish to proceed"
read

find ./ -name '*~' -exec rm '{}' \; -print -or -name ".*~" -exec rm {} \; -print
