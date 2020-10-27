#!/bin/bash
#
# Copyright (C) 2017-2019 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# If we're being sourced by the common script that we called,
# stop right here. No need to go down the rabbit hole.

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

if [ "${BASH_SOURCE[0]}" != "${0}" ]; then
    return
fi

set -e

# Required!
export DEVICE=sanders
export DEVICE_COMMON=msm8953-common
export VENDOR=motorola

export DEVICE_BRINGUP_YEAR=2020

"./../../${VENDOR}/${DEVICE_COMMON}/extract-files.sh" "$@"
