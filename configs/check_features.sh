#!/sbin/sh

remove_dtv() {
    rm /system/system/etc/permissions/com.motorola.hardware.dtv.xml
    rm /system/system/etc/permissions/mot_dtv_permissions.xml
    rm /system/system/lib*/libdtvtuner.so
    rm /system/system/lib*/libdtvhal.so
    rm /vendor/lib/modules/isdbt.ko
    rm -r /system/system/priv-app/DTVPlayer
    rm -r /system/system/priv-app/DTVService
}

if [ $(getprop ro.boot.hardware.sku) != "XT1802" ]; then
    remove_dtv
fi
