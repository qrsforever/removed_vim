#!/bin/bash

if (( $# < 1 ))
then
    echo "Use: 0chkbugreport.sh bugreport.txt"
    exit
fi

java -jar ~/.vim/project/android/tools/chkbugreport.jar $1
