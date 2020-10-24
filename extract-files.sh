#!/bin/bash
#
# Copyright (C) 2016 The CyanogenMod Project
# Copyright (C) 2017-2020 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

function blob_fixup() {
    case "${1}" in
    vendor/lib/hw/camera.msm8953.so)
        sed -i "s|service.bootanim.exit|service.bootanim.hold|g" "${2}"
        ;;

    vendor/lib/libmot_gpu_mapper.so | vendor/lib/libmmcamera_vstab_module.so | vendor/lib/libmmcamera_ppeiscore.so | vendor/lib/libmmcamera2_stats_modules.so)
        sed -i "s/libgui/libwui/" "${2}"
        ;;

    vendor/lib/libmmcamera2_stats_modules.so | vendor/lib/libmmcamera_vstab_module.so)
        patchelf --remove-needed libandroid.so "${2}"
        ;;

    vendor/lib/libmmcamera2_sensor_modules.so)
        sed -i "s|/system/etc/camera/|/vendor/etc/camera/|g" "${2}"
        ;;

    vendor/bin/hw/android.hardware.biometrics.fingerprint@2.1-fpcservice)
        sed -i 's|/firmware/image|/vendor/f/image|' "${2}"
        ;;
    esac
}

# If we're being sourced by the common script that we called,
# stop right here. No need to go down the rabbit hole.
if [ "${BASH_SOURCE[0]}" != "${0}" ]; then
    return
fi

set -e

export DEVICE=sanders
export DEVICE_COMMON=msm8953-common
export VENDOR=motorola

"./../../${VENDOR}/${DEVICE_COMMON}/extract-files.sh" "$@"
