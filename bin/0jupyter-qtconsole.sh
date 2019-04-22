#!/bin/bash

pidfile=/tmp/jupyter_qtconsole_pid

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

jupyter qtconsole --no-confirm-exit --no-banner >/dev/null 2>&1 &
echo "$!" > /tmp/jupyter_qtconsole_pid
