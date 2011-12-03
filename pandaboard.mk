# The pandaboard product that is specialized for pandaboard.
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base.mk)
$(call inherit-product, device/linaro/common/common.mk)
$(call inherit-product, device/linaro/pandaboard/device.mk)

PRODUCT_BRAND := pandaboard
PRODUCT_DEVICE := pandaboard
PRODUCT_NAME := pandaboard
