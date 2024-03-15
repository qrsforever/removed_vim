#!/bin/bash

direction=$1

if [[ $XDG_SESSION_TYPE != x11 ]]
then
    echo "window: $XDG_SESSION_TYPE" > /tmp/a.txt
    exit 0
fi

getwindowat() {
    # move mouse to coordinates provided, get window id beneath it, move mouse back
    eval `xdotool mousemove $1 $2 getmouselocation --shell mousemove restore`
    echo $WINDOW
}

# get active app
active=`xdotool getactivewindow`
# get coordinates of an active app
xdotool getwindowgeometry --shell $active
eval `xdotool getwindowgeometry --shell $active`

# if left border of an app is less than display width
# (e.g. one display is 1920px wide, app has x = 200 - means it's 200px to the right from the left border of left monitor
# if it has x = 1920 or more, it's on the right window), it's on screen 0, and we need to focus to screen 1, otherwise to screen 0

if [[ x$direction == x'lr' ]]
then
    (( $X >= $WIDTH )) && focustoscreen=0 || focustoscreen=1;
else
    (( $Y >= $HEIGHT )) && focustoscreen=0 || focustoscreen=1;
fi

# get coordinates of the middle of the screen we want to switch
if [[ x$direction == x'lr' ]]
then
    searchx=$[ ($WIDTH / 2) + $focustoscreen * $WIDTH ]
    searchy=$[ $HEIGHT / 2 ]
else
    searchx=$[ $WIDTH / 2 ]
    searchy=$[ ($HEIGHT / 2) + $focustoscreen * $HEIGHT ]
fi

# get window in that position
window=`getwindowat $searchx $searchy`
# activate it
echo a=${active} $searchx $searchy $window x=${X} y=${Y}

xdotool windowactivate $window
