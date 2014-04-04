ARCHS = armv7 armv7s arm64

TARGET = iphone:clang:latest:7.0

THEOS_BUILD_DIR = Packages

include theos/makefiles/common.mk

TWEAK_NAME = HS7IconTweak
HS7IconTweak_CFLAGS = -fobjc-arc
HS7IconTweak_FILES = Tweak.xm

APPLICATION_NAME = HiddenSettings7Icon
HiddenSettings7Icon_CFLAGS = -fobjc-arc
HiddenSettings7Icon_FILES = main.m AppDelegate.m
HiddenSettings7Icon_FRAMEWORKS = UIKit

include $(THEOS_MAKE_PATH)/tweak.mk
include $(THEOS_MAKE_PATH)/application.mk
