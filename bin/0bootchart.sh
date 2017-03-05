#!/bin/bash
# adb shell 'echo 120 > /data/bootchart-start'
# cd /data/bootchart
# busybox tar -czf bootchart.tgz *
if (( $# < 1 ))
then
    echo "Use: 0bootchart.sh a.tgz"
    exit
fi

java -jar ~/.vim/project/android/tools/bootchart.jar $1
