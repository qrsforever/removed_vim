#!/system/bin/sh
# adb command: https://zhuanlan.zhihu.com/p/604237058
# settings put system screen_brightness 200
sleep 25
am force-stop com.dianshijia.newlive
sleep 3
media volume --show --stream 3 --set 0
am start com.shenyaocn.android.usbcamera/.MainActivity
sleep 6
# 勾选USB授权
input tap 512 555
# sleep 0.5
# 确定勾选
input tap 1380 666
# sleep 0.5
# 点击右下角菜单
input tap 1845 1000
# sleep 0.5
# 选择IPCAM服务
input tap 1845 700
# sleep 0.5
# 勾选RTMP
input tap 699 1038
# sleep 1
# 点击右上角菜单
input tap 1868 62
# sleep 0.5
# 点击进入后台运行
input tap 1648 558
# sleep 0.5
# 确定
input tap 1382 633
# sleep 1
am start com.dianshijia.newlive/.entry.SplashActivity

cd /sys/class/gpio
echo "75" > export
cd gpio75
echo "in" > direction

__is_back_view()
{
    res=`dumpsys activity top | grep "ll_dialog_exit"`
    [ -z "$res" ] && echo 0 || echo 1
}

media volume --show --stream 3 --set 14
sleep 5
while true
do
    val=`cat value`
    if [ $val -eq 0 ]
    then
        media volume --show --stream 3 --set 0
        if [ $(__is_back_view) -eq 0 ]
        then
            input keyevent 4
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
            input keyevent 4
        fi
        media volume --show --stream 3 --set 14
    fi
    sleep 3
done
