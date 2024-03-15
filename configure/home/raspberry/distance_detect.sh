#!/system/bin/sh

cd /sys/class/gpio
echo "24" > export
cd gpio24
echo "in" > direction

__is_back_view()
{
    res=`dumpsys activity top | grep "ll_dialog_exit"`
    [ -z "$res" ] && echo 0 || echo 1
}

while true
do
    val=`cat value`
    if [ $val -eq 0 ]
    then
        input keyevent VOLUME_MUTE
        if [ $(__is_back_view) -eq 0 ]
        then
            input keyevent BACK
        fi
        i=0
        while true
        do
            val=`cat value`
            if [ $val -eq 1 ]
            then
                i=`expr $i + 1`
                if [ $i -gt 3 ]
                then
                    break
                fi
            else
                i=0
            fi
            sleep 1
        done
        if [ $(__is_back_view) -eq 1 ]
        then
            input keyevent BACK
        fi
        input keyevent VOLUME_MUTE
    fi
    sleep 3
done
