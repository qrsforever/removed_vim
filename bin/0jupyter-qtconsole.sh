#!/bin/bash

pidfile=/tmp/jupyter_qtconsole.pid

use_xvfb=0

if [[ x$1 != x ]]
then
    use_xvfb=$1
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

if [[ x$use_xvfb == x1 ]]
then
    xvfb-run -a -s "-screen 0 300x300x8" jupyter qtconsole --no-confirm-exit --no-banner >/dev/null 2>&1 &
else
    jupyter qtconsole \
        --no-confirm-exit --no-banner \
        --JupyterWidget.console_height=200 \
        --JupyterWidget.console_width=400 \
        --JupyterWidget.include_other_output=True >/dev/null 2>&1 &
fi

echo "$!" > $pidfile
