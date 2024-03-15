#!/bin/bash

IFS=$'\n'

for srcpath in `find "$PWD" -not -path "*/\.*"`
do
    if [ -f "$srcpath" ]
    then
        dstpath=$(echo "$srcpath" | sed 's# #_#g')
        if [[ "$srcpath" != $dstpath ]]
        then
            dir=`dirname $dstpath`
            if [ ! -d $dir ]
            then
                mkdir -p $dir
            fi
            mv "$srcpath" $dstpath
        fi
    fi
done
