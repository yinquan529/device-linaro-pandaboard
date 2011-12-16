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
	device/linaro/common/init.rc:root/init.rc \
	device/linaro/pandaboard/vold.fstab:system/etc/vold.fstab \
	device/linaro/pandaboard/init.omap4pandaboard.rc:root/init.omap4pandaboard.rc \
	device/linaro/pandaboard/init.omap4pandaboard.usb.rc:root/init.omap4pandaboard.usb.rc \
	device/linaro/pandaboard/ueventd.omap4pandaboard.rc:root/ueventd.omap4pandaboard.rc \
	device/linaro/pandaboard/wpa_supplicant.conf:system/etc/wifi/wpa_supplicant.conf \
	device/linaro/pandaboard/media_profiles.xml:system/etc/media_profiles.xml \
	frameworks/base/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
	frameworks/base/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
	device/linaro/common/wallpaper_info.xml:data/system/wallpaper_info.xml

PRODUCT_PACKAGES := \
        make_ext4fs \
        com.android.future.usb.accessory

PRODUCT_PROPERTY_OVERRIDES := \
        hwui.render_dirty_regions=false

PRODUCT_CHARACTERISTICS := tablet,nosdcard

DEVICE_PACKAGE_OVERLAYS := \
    device/ti/panda/overlay

PRODUCT_TAGS += dalvik.gc.type-precise

$(call inherit-product, frameworks/base/build/tablet-dalvik-heap.mk)

# Filesystem management tools
PRODUCT_PACKAGES += \
        make_ext4fs

PRODUCT_PROPERTY_OVERRIDES += \
        ro.nohardwaregfx=true

