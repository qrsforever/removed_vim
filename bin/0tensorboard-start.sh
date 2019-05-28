#!/bin/bash

pidfile=/tmp/0tensorboard_start.pid

if [ ! -f $pidfile ]
then
    touch $pidfile
fi

pid=`cat $pidfile`

if [[ x$pid != x ]]
then
    ret=`ps -p $pid | tail -n 1 | grep qt`
    if [[ x$ret != x ]]
    then
        kill -9 $pid
    fi
fi

tensorboard --logdir=/tmp/tf >/dev/null 2>&1 &

# sleep 5

# xdg-open http://localhost:6006

echo "$!" > $pidfile
