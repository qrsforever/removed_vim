adb connect ip:5555
adb remount


am force-stop com.android.smspush
am force-stop com.android.phone

/system/bin/suproce.sh

screencap -p /system/a.png
adb pull /system/a.png

input tap x y


am start com.shenyaocn.android.usbcamera/.MainActivity
sleep 5
input tap 512 555
input tap 1380 666
input tap 1845 1000
sleep 0.5
input tap 1845 700
sleep 0.5

input tap 699 1038
sleep 1
input tap 1868 62
sleep 2

input tap 1666 477
sleep 1
