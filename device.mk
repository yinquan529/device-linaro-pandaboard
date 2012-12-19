# Copyright (C) 2011 Linaro Limited
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

PRODUCT_COPY_FILES := \
	device/linaro/common/fstab.partitions:root/fstab.omap4pandaboard \
	device/linaro/pandaboard/init.omap4pandaboard.rc:root/init.omap4pandaboard.rc \
	device/linaro/pandaboard/init.omap4pandaboard.usb.rc:root/init.omap4pandaboard.usb.rc \
	device/linaro/pandaboard/ueventd.omap4pandaboard.rc:root/ueventd.omap4pandaboard.rc \
	device/linaro/common/wpa_supplicant.conf:system/etc/wifi/wpa_supplicant.conf \
	device/linaro/pandaboard/media_profiles.xml:system/etc/media_profiles.xml \
	frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
	frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
	frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
        device/ti/proprietary-open/wifi/omap4/LICENCE.ti-connectivity:root/LICENCE.ti-connectivity \
	device/linaro/common/android.hardware.bluetooth.xml:system/etc/permissions/android.hardware.bluetooth.xml \
	hardware/linaro/tinyhal/pandaboard.xml:system/etc/sound/pandaboard.xml

PRODUCT_PACKAGES := \
        make_ext4fs \
        com.android.future.usb.accessory \
        audio.primary.omap4 \
        uim \
        camera.omap4

PRODUCT_PROPERTY_OVERRIDES := \
        hwui.render_dirty_regions=false

PRODUCT_CHARACTERISTICS := tablet,nosdcard

DEVICE_PACKAGE_OVERLAYS := \
    device/linaro/pandaboard/overlay

PRODUCT_TAGS += dalvik.gc.type-precise

$(call inherit-product, frameworks/native/build/tablet-dalvik-heap.mk)
$(call inherit-product-if-exists, device/ti/proprietary-open/install-binaries.mk)

PRODUCT_PROPERTY_OVERRIDES += \
        ro.opengles.version=131072

# 3.4 kernel doesn't have hardware acceleration. We are enabling the
# support for software graphics by checking if the kernel config is
# set for 3.4 kernel .TODO: Revisit when 3.4+ kernel supports SGX
ifneq ($(wildcard $(TOP)/kernel/arch/arm/configs/omap4plus_defconfig),)
PRODUCT_COPY_FILES += \
	device/linaro/pandaboard/vold.fstab_tracking:system/etc/vold.fstab
TARGET_NO_HARDWAREGFX=1
else
PRODUCT_COPY_FILES += \
	device/linaro/pandaboard/vold.fstab:system/etc/vold.fstab
    $(call inherit-product, hardware/ti/omap4xxx/omap4.mk)
endif

ifeq ($(TARGET_NO_HARDWAREGFX),1)
PRODUCT_PROPERTY_OVERRIDES += \
        ro.nohardwaregfx=true
else
PRODUCT_PACKAGES += \
        hwcomposer.omap4
endif

PRODUCT_PROPERTY_OVERRIDES += \
        debug.sf.no_hw_vsync=1 \
        ro.sf.lcd_density=160
