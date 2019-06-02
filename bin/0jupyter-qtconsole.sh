#!/bin/bash

pidfile=/tmp/jupyter_qtconsole.pid

use_xvfb=1

if [[ x$1 != x ]]
then
    use_xvfb=$1
fi

DISPLAY_ID=9

if [[ x$use_xvfb == 1 ]]
then
    pid=`ps a | grep "Xvfb" | grep ":$DISPLAY_ID" | cut -d\  -f2`

    if [[ x$pid == x ]]
    then
        Xvfb :$DISPLAY_ID -ac -screen 0 640x480x8 &
        sleep 1
    fi
fi

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

if [[ x$use_xvfb == 1 ]]
then
    DISPLAY=:$DISPLAY_ID jupyter qtconsole --no-confirm-exit --no-banner >/dev/null 2>&1 &
else
    jupyter qtconsole --no-confirm-exit --no-banner >/dev/null 2>&1 &
fi

echo "$!" > $pidfile
