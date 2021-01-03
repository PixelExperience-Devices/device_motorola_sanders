#
# vendor props for sanders
#

# Audio
PRODUCT_PROPERTY_OVERRIDES += \
    persist.vendor.audio.calfile1=/vendor/etc/acdbdata/Bluetooth_cal.acdb \
    persist.vendor.audio.calfile0=/vendor/etc/acdbdata/Global_cal.acdb \
    persist.vendor.audio.calfile2=/vendor/etc/acdbdata/General_cal.acdb \
    persist.vendor.audio.calfile4=/vendor/etc/acdbdata/Hdmi_cal.acdb \
    persist.vendor.audio.calfile5=/vendor/etc/acdbdata/Headset_cal.acdb \
    persist.vendor.audio.calfile6=/vendor/etc/acdbdata/Handset_cal.acdb \
    persist.vendor.audio.calfile3=/vendor/etc/acdbdata/Speaker_cal.acdb

# Camera
PRODUCT_PROPERTY_OVERRIDES += \
    persist.camera.HAL3.enabled=1 \
    persist.camera.eis.enable=1

# Sensors
PRODUCT_PROPERTY_OVERRIDES += \
    ro.hardware.sensors=sanders
