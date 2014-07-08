ARCHS = armv7 armv7s arm64
TARGET = iphone:clang:latest:7.0

THEOS_BUILD_DIR = Packages

TWEAK_NAME = HS7IconTweak
HS7IconTweak_CFLAGS = -fobjc-arc
HS7IconTweak_FILES = Tweak.xm

APPLICATION_NAME = HS7IconApp
HS7IconApp_CFLAGS = -fobjc-arc
HS7IconApp_FILES = main.m AppDelegate.m
HS7IconApp_FRAMEWORKS = UIKit

include theos/makefiles/common.mk
include $(THEOS_MAKE_PATH)/tweak.mk
include $(THEOS_MAKE_PATH)/application.mk


after-install::
	install.exec "killall -9 SpringBoard"
