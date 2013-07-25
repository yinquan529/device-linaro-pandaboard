# config.mk
# 
# Product-specific compile-time definitions.
#

TARGET_BOARD_PLATFORM := omap4
TARGET_NO_BOOTLOADER := true # Uses u-boot instead 
TARGET_NO_KERNEL := false
TARGET_HWPACK_CONFIG := device/linaro/pandaboard/config
DEVICE_TREES := omap4-panda:board.dtb
ifneq ($(wildcard $(TOP)/kernel/linaro/pandaboard/arch/arm/configs/android_omap4_defconfig),)
BOARD_EGL_CFG := device/linaro/pandaboard/egl.cfg
KERNEL_CONFIG := android_omap4_defconfig
else
BOARD_EGL_CFG := device/linaro/pandaboard/softwaregfx/egl.cfg
KERNEL_CONFIG := omap4plus_defconfig
endif
TARGET_USE_UBOOT := true
UBOOT_CONFIG := omap4_panda_config
TARGET_USE_XLOADER := false
XLOADER_CONFIG := omap4430panda_config
TARGET_NO_RECOVERY := true
TARGET_NO_RADIOIMAGE := true
BOARD_USES_GENERIC_AUDIO := false
#BOARD_USES_ALSA_AUDIO := false
BUILD_WITH_ALSA_UTILS := false
BOARD_USES_TINY_AUDIO_HW := true
OMAP_ENHANCEMENT := true
#HARDWARE_OMX := false
USE_CAMERA_STUB := true
INCLUDE_PERF := 0

TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_CPU_SMP := true
TARGET_CPU_VARIANT := cortex-a9

ifdef HARDWARE_OMX
OMX_VENDOR := ti
OMX_VENDOR_INCLUDES := \
   hardware/ti/omx/system/src/openmax_il/omx_core/inc \
   hardware/ti/omx/image/src/openmax_il/jpeg_enc/inc
OMX_VENDOR_WRAPPER := TI_OMX_Wrapper
BOARD_OPENCORE_LIBRARIES := libOMX_Core
BOARD_OPENCORE_FLAGS := -DHARDWARE_OMX=1
endif

ifdef OMAP_ENHANCEMENT
COMMON_GLOBAL_CFLAGS += -DOMAP_ENHANCEMENT -DTARGET_OMAP4
endif

# Enable NEON feature
TARGET_ARCH := arm
TARGET_ARCH_VARIANT := armv7-a-neon
ARCH_ARM_HAVE_TLS_REGISTER := true

EXTRA_PACKAGE_MANAGEMENT := false

TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_SPARSE_EXT_DISABLED := true

#BOARD_USES_HGL := true
#BOARD_USES_OVERLAY := true
USE_OPENGL_RENDERER := true

# PandaBoard uses an OMAP4 -- Cortex A9
TARGET_EXTRA_CFLAGS += $(call cc-ifversion, -ge, 46, $(call cc-option,-mtune=cortex-a9,$(call cc-option,-mtune=cortex-a8)) $(call cc-option,-mcpu=cortex-a9,$(call cc-option,-mcpu=cortex-a8)))

# ARMs gator (DS-5)
TARGET_USE_GATOR:= true

# Build uImage and uInitrd instead of kernel and ramdisk.img
TARGET_BOOTLOADER_TYPE := uboot
