#!/bin/bash

# adb disconnect; adb connect xxx:5555
# adb remount;

adb push Generic.kl /vendor/usr/keylayout/Generic.kl
adb push 50-lineage.sh /system/addon.d/50-lineage.sh
adb push sensor99.rc /system/etc/init/sensor99.rc
adb push sensor99.sh /system/etc/sensor99.sh
adb push distance_detect.sh /system/etc/distance_detect.sh
adb shell chmod 777 /system/etc/sensor99.sh
adb shell chmod 777 /system/etc/distance_detect.sh
adb shell sync
