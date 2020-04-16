#!/system/bin/sh

while [ ! -w "/sdcard" ]; do
    sleep 1
done

cam_appver=$(dumpsys package com.android.camera | grep versionName | cut -d= -f2)
cam_datadir="/sdcard/.ANXCamera"
cam_dataver=$(cat "$cam_datadir/.data-version")

# Check if data version is different from app version (maybe older)
if [ "$cam_appver" != "$cam_dataver" ]; then

    # Add (or renew) data version
    echo "$cam_appver" > $cam_datadir/.data-version

    # Transfer required files
    mkdir -p $cam_datadir/cheatcodes
    mkdir -p $cam_datadir/cheatcodes_reference
    mkdir -p $cam_datadir/features
    mkdir -p $cam_datadir/features_reference
    cp -af /system/etc/ANXCamera/cheatcodes/. $cam_datadir/cheatcodes/
    cp -af /system/etc/ANXCamera/cheatcodes/. $cam_datadir/cheatcodes_reference/
    cp -af /system/etc/device_features/. $cam_datadir/features/
    cp -af /system/etc/device_features/. $cam_datadir/features_reference/

fi

# shfmt -l -w -s -p -i 4 -sr
