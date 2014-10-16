ifneq ($(TARGET_BOARD_PLATFORM),)
WLAN_CHIPSET := bcm4339
WLAN_SELECT := CONFIG_BCMDHD=m CONFIG_BCMDHD_INSMOD_NO_FW_LOAD=y \
	CONFIG_BCM4339=y
ifeq ($(SEMC_CFG_WLAN_DISABLE_5G),true)
WLAN_SELECT += CONFIG_SEMC_WLAN_BAND=WLC_BAND_2G
endif
ifneq ($(SOMC_CFG_WLAN_BCN_TIMEOUT),)
WLAN_SELECT += CONFIG_SOMC_WLAN_BCN_TIMEOUT=$(SOMC_CFG_WLAN_BCN_TIMEOUT)
endif
ifneq ($(SOMC_CFG_WLAN_LISTEN_INTERVAL),)
WLAN_SELECT += CONFIG_SOMC_WLAN_LISTEN_INTERVAL=$(SOMC_CFG_WLAN_LISTEN_INTERVAL)
endif
WLAN_BLD_DIR := vendor/broadcom/wlan

LOCAL_PATH := $(call my-dir)

DLKM_DIR := $(TOP)/device/qcom/common/dlkm

###########################################################
KBUILD_OPTIONS := WLAN_ROOT=../$(WLAN_BLD_DIR)
KBUILD_OPTIONS += MODNAME=wlan
KBUILD_OPTIONS += BOARD_PLATFORM=$(TARGET_BOARD_PLATFORM)
KBUILD_OPTIONS += $(WLAN_SELECT)

include $(CLEAR_VARS)
LOCAL_MODULE              := $(WLAN_CHIPSET).ko
LOCAL_MODULE_KBUILD_NAME  := wlan.ko
LOCAL_MODULE_TAGS         := optional
LOCAL_MODULE_PATH         := $(TARGET_OUT)/lib/modules
include $(DLKM_DIR)/AndroidKernelModule.mk
###########################################################
endif
