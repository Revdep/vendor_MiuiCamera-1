#!/system/bin/sh
anx=/sdcard/.ANXCamera
device=$(getprop ro.product.device)
devices="
raphael
polaris
perseus
whyred
gemini
sirius
davinci"

case $devices in
    *${device}*)
        setprop ro.miui.notch 0
        ;;
    *)
        setprop ro.miui.notch 1
        ;;
esac

while true; do; [ -w "/sdcard" ] && break || sleep 1; done

if [ ! -f "$anx/.ANXCamera/.initialized" ]; then
    rm -rf $anx

    mkdir -p $anx/cheatcodes
    mkdir -p $anx/cheatcodes_reference
    mkdir -p $anx/features
    mkdir -p $anx/features_reference

    cp -af /system/etc/ANXCamera/cheatcodes/. $anx/cheatcodes/
    cp -af /system/etc/ANXCamera/cheatcodes/. $anx/cheatcodes_reference/
    cp -af /system/etc/device_features/. $anx/features/
    cp -af /system/etc/device_features/. $anx/features_reference/

    touch $anx/.initialized

    chown -hR $(stat -c "%U:%G" /sdcard/.) $anx
    chmod -R 666 $anx
fi
