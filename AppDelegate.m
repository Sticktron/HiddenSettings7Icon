//
//  AppDelegate.m
//  HiddenSettings7 Icon
//
//  Created by Sticktron on 2014-04-03.
//  Copyright (c) 2014 Sticktron. All rights reserved.
//

#import "AppDelegate.h"


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



@interface UIColor (UIColorSystemColorsPrivate)
+ (id)_webContentBackgroundColor;
+ (id)_systemSelectedColor;
+ (id)_grayColorForFontSize:(double)arg1;
+ (id)_dimmingViewColor;
+ (id)_translucentPaperTextureColor;
+ (id)noContentDarkGradientBackgroundColor;
+ (id)noContentLightGradientBackgroundColor;
+ (id)_systemMidGrayTintColor;
+ (id)_barStyleBlackHairlineShadowColor;
+ (id)_barHairlineShadowColor;
+ (id)_alternateSystemInteractionTintColor;
+ (id)_systemDestructiveTintColor;
+ (id)_systemInteractionTintColor;
@end






@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
	
	UIViewController *viewController = [[UIViewController alloc] init];
	self.window.rootViewController = viewController;
	
    self.window.backgroundColor = [UIColor noContentDarkGradientBackgroundColor];
    [self.window makeKeyAndVisible];
	
    return YES;
}

/*
- (void)applicationWillResignActive:(UIApplication *)application
{
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}
*/

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	// Restart any tasks that were paused (or not yet started) while the application was inactive.
	// If the application was previously in the background, optionally refresh the user interface.
		
//	if ($SBPrototypeController) {
//		[[$SBPrototypeController sharedInstance] showOrHide];
//	}

	
	CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(),
										 CFSTR("com.sticktron.hs7icon.ShowHiddenSettings"),
										 NULL,
										 NULL,
										 kCFNotificationDeliverImmediately);
	
	DebugLog(@"Notification sent to SpringBoard");
	
}

/*
- (void)applicationWillTerminate:(UIApplication *)application
{
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
*/

@end

