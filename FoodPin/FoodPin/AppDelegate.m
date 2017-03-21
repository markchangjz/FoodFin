//
//  AppDelegate.m
//  FoodPin
//
//  Created by MarkChang on 2017/3/17.
//  Copyright © 2017年 MarkChang. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	// Override point for customization after application launch.

	// 設定 UINavigationBar 外觀
	[UINavigationBar appearance].barTintColor = [UIColor colorWithRed:242.0/255.0 green:116.0/255.0 blue:119.0/255.0 alpha:1.0];
	[UINavigationBar appearance].tintColor = [UIColor whiteColor];

	UIFont *font = [UIFont fontWithName:@"Avenir-Light" size:24.0];
	[UINavigationBar appearance].titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor], NSFontAttributeName: font};

	// 設定狀態列顏色請參考：http://stackoverflow.com/questions/32501305/uiapplication-sharedapplication-setstatusbarstyle-deprecated-in-ios-9

	return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
	// Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
