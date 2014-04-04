//
//  Tweak.xm
//  HiddenSettings7 Icon
//
//  Created by Sticktron on 2014-04-03.
//  Copyright (c) 2014 Sticktron. All rights reserved.
//


//--------------------------------------------------------------------------------------------------
//#define __DEBUG_ON__
//
#ifdef __DEBUG_ON__
#define DebugLog(s, ...) \
NSLog(@" [HS7 Icon] %@", [NSString stringWithFormat:(s), ##__VA_ARGS__])
#else
#define DebugLog(s, ...)
#endif
//--------------------------------------------------------------------------------------------------


@interface SpringBoard : UIApplication
- (void)applicationDidFinishLaunching:(UIApplication*) application;
@end

@interface SBPrototypeController : NSObject
+ (instancetype)sharedInstance;
- (void)showOrHide;
- (void)_showSettings;
@end


static Class $SBPrototypeController = nil;

NS_INLINE void ShowHiddenSettings(CFNotificationCenterRef center, void *observer, CFStringRef name,
						const void *object, CFDictionaryRef userInfo) {
	DebugLog(@"Received Notification");

	[[$SBPrototypeController sharedInstance] showOrHide];
}



//--------------------------------------------------------------------------------------------------
%hook SpringBoard
//--------------------------------------------------------------------------------------------------
- (void)applicationDidFinishLaunching:(UIApplication*) application
{
	$SBPrototypeController = NSClassFromString(@"SBPrototypeController");
	DebugLog(@"SBPrototypeController = %@", $SBPrototypeController);
	
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(),
									NULL,
									(CFNotificationCallback)ShowHiddenSettings,
									CFSTR("com.sticktron.hs7icon.ShowHiddenSettings"),
									NULL,
									CFNotificationSuspensionBehaviorDeliverImmediately);
	
	DebugLog(@"Observer Added");

	%orig;
}

%end