#!/system/bin/sh

mount -o rw,remount /system
chmod 06755 su
su --daemon

echo "su daemon done."

__stop_apk()
{
    am force-stop $1
    pm disable $1
}
__stop_apk com.android.cts.priv.ctsshim
__stop_apk com.android.providers.telephony
__stop_apk com.android.mms.service
__stop_apk com.android.nfc
__stop_apk com.android.hotspot2
__stop_apk com.android.printspooler
__stop_apk com.android.server.telecom
__stop_apk com.android.printservice.recommendation
__stop_apk com.android.proxyhandler
__stop_apk com.android.cts.ctsshim
__stop_apk com.android.vpndialogs
__stop_apk com.android.phone
__stop_apk com.android.wallpaperbackup
# __stop_apk com.softwinner.miracastReceiver
__stop_apk com.softwinner.update
__stop_apk com.android.providers.contacts
__stop_apk com.android.captiveportallogin

# /system/etc/init/*.rc
# stop logd
stop awlog_system
stop awlog_main
stop awlog_crash
stop awlog_events
stop awlog_radio

run=`ps -f | grep "sensor99" | grep -v "grep"`
if [ -x /system/bin/sensor99.sh ] && [ -z "${run}" ]
then
    /system/bin/iremote.sh &
    /system/bin/sensor99.sh &
fi
