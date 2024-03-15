#!/bin/bash

adb disconnect ; adb connect 172.19.76.116:5555
adb push suproce.sh /system/bin/
adb push iremote.sh /system/bin/
adb push sunxi-ir.kl /system/usr/keylayout/
adb push sensor99.sh /system/bin/
adb shell chmod 777 /system/bin/iremote.sh
adb shell chmod 777 /system/bin/sensor99.sh
adb shell sync
