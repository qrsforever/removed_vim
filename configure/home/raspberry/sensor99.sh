#!/system/bin/sh

IRDEV=/dev/input/event2

while true
do
    if [ -e ${IRDEV} ]
    then
        break
    fi
    sleep 3
done

am start com.dianshijia.newlive/.entry.SplashActivity

# /system/etc/distance_detect.sh &

while true
do
    if [ ! -e ${IRDEV} ]
    then
        sleep 3
    fi
    key=`getevent -c 1 ${IRDEV}` cut -d\  -f3`
    case "$key" in
        "0007003c")
            am start -n com.android.settings/com.android.settings.Settings
            ;;
        "0007003d")
            am start com.dianshijia.newlive/.entry.SplashActivity
            ;;
    esac
done
