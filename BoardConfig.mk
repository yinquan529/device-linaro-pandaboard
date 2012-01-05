# config.mk
# 
# Product-specific compile-time definitions.
#

TARGET_BOARD_PLATFORM := omap4
TARGET_NO_BOOTLOADER := true # Uses u-boot instead 
TARGET_NO_KERNEL := false
KERNEL_CONFIG := android_omap4_defconfig
TARGET_USE_UBOOT := true
UBOOT_CONFIG := omap4_panda_config
TARGET_USE_XLOADER := false
XLOADER_CONFIG := omap4430panda_config
TARGET_NO_RECOVERY := true
TARGET_NO_RADIOIMAGE := true
TARGET_PROVIDES_INIT_RC := true
BOARD_USES_GENERIC_AUDIO := false
#BOARD_USES_ALSA_AUDIO := false
BUILD_WITH_ALSA_UTILS := false
OMAP_ENHANCEMENT := true
HARDWARE_OMX := false
USE_CAMERA_STUB := true

BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_BCM := true

BOARD_WPA_SUPPLICANT_DRIVER      := WEXT
WPA_SUPPLICANT_VERSION           := VER_0_8_X
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := private_lib_driver_cmd
WIFI_DRIVER_MODULE_PATH          := "/system/modules/wl12xx_sdio.ko"
WIFI_DRIVER_MODULE_NAME          := "wl12xx_sdio"
WIFI_FIRMWARE_LOADER             := ""

TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_CPU_SMP := true

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
TARGET_ARCH_VARIANT := armv7-a-neon
ARCH_ARM_HAVE_TLS_REGISTER := true

EXTRA_PACKAGE_MANAGEMENT := false

TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_SPARSE_EXT_DISABLED := true

BOARD_EGL_CFG := device/ti/panda/egl.cfg

#BOARD_USES_HGL := true
#BOARD_USES_OVERLAY := true
USE_OPENGL_RENDERER := true

# PandaBoard uses an OMAP4 -- Cortex A9
TARGET_EXTRA_CFLAGS += $(call cc-option,"-march=armv7-a -mtune=cortex-a9",$(call cc-option,"-march=armv7-a -mtune=cortex-a8")) $(call cc-option,"-march=armv7-a -mcpu=cortex-a9",$(call cc-option,"-march=armv7-a -mcpu=cortex-a8"))

# ARMs gator (DS-5)
TARGET_USE_GATOR:= true
