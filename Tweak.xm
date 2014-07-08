//
//  Tweak.xm
//  HiddenSettings7 Icon
//
//  Created by Sticktron on 2014-04-03.
//  Copyright (c) 2014 Sticktron. All rights reserved.
//
//

#ifdef DEBUG
	#define DebugLog(s, ...) \
		NSLog(@"[HS7 Icon] %@", [NSString stringWithFormat:(s), ##__VA_ARGS__])
#else
	#define DebugLog(s, ...)
#endif





//------------------------------------------------------------------------------
// Private Interfaces
//------------------------------------------------------------------------------


@interface SpringBoard : UIApplication
- (void)applicationDidFinishLaunching:(UIApplication*) application;
- (void)quitTopApplication:(struct __GSEvent *)arg1;
@end


@interface SBPrototypeController : NSObject
+ (instancetype)sharedInstance;
- (void)showOrHide;
- (void)_showSettings;
- (void)_tearDownSettingsWindow;
- (void)_hideSettings;
@end





//------------------------------------------------------------------------------
// Notification Handler
//------------------------------------------------------------------------------


NS_INLINE void ShowHiddenSettings(CFNotificationCenterRef center, void *observer, CFStringRef name,
						const void *object, CFDictionaryRef userInfo) {
	DebugLog(@"Received Notification, showing settings...");

	[[%c(SBPrototypeController) sharedInstance] showOrHide];
}





//------------------------------------------------------------------------------
// Hooks
//------------------------------------------------------------------------------


%hook SBPrototypeController

- (void)_tearDownSettingsWindow {
	%log;
	%orig;
}

- (void)_hideSettings {
	%orig;
	DebugLog(@"time to close the app");
	[(SpringBoard *)[%c(SpringBoard) sharedApplication] quitTopApplication:nil];
}

%end


//------------------------------------------------------------------------------


%hook SpringBoard

- (void)applicationDidFinishLaunching:(UIApplication*) application {
	
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


//------------------------------------------------------------------------------





//------------------------------------------------------------------------------
// Constructor
//------------------------------------------------------------------------------
%ctor {
	@autoreleasepool {
		NSLog(@" HS7IconTweak init'd.");
		%init;
	}
}

