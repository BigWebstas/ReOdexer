@echo off
@title Odexer
mode con:cols=88 lines=60
color 0A
adb kill-server
adb root
sleep 5
adb shell busybox mount -o remount,rw /system
adb remount
adb push dexopt-wrapper /system/bin/dexopt-wrapper
adb shell chmod 4755 /system/bin/dexopt-wrapper
adb push zip /system/bin/zip
adb shell chmod 4755 /system/bin/zip
adb push zipalign /system/bin/zipalign
adb shell chmod 4755 /system/bin/zipalign
adb push appodex.sh /data/local/tmp/appodex.sh
adb shell chmod 4755 /data/local/tmp/appodex.sh
adb push fwodex.sh /data/local/tmp/fwodex.sh
adb shell chmod 4755 /data/local/tmp/fwodex.sh
adb push fix_permissions.sh /data/local/tmp/fix_permissions.sh
adb shell chmod 4755 /data/local/tmp/fix_permissions.sh
echo Tools and scripts copied you ready for this?
pause
color 71
adb shell sh /data/local/tmp/fwodex.sh
adb shell sh /data/local/tmp/appodex.sh
adb chmod 666 /system/framework/services*
adb chmod 666 /system/framework/android.policy*
adb shell sh /data/local/tmp/fix_permissions.sh
Echo Check results rebooting
adb reboot
sleep 10




