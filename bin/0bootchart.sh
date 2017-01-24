#!/bin/bash

if (( $# < 1 ))
then
    echo "Use: 0bootchart.sh a.tgz"
    exit
fi

java -jar ~/.vim/project/android/tools/bootchart.jar $1
