//
//  AppDelegate+HandleOpenURL.m
//  FoodPin
//
//  Created by esunbank on 2017/4/11.
//  Copyright © 2017年 MarkChang. All rights reserved.
//

#import "AppDelegate+HandleOpenURL.h"
#import "RestaurantDetailViewController.h"
#import "Restaurant.h"
#import "RestaurantInfo.h"

@implementation AppDelegate (HandleOpenURL)

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {

    if ([[url absoluteString] hasPrefix:@"foodpin://restaurant_index"]) {

        // 設定 Restaurant Detail View
        NSInteger restaurantIndex = [[[[url absoluteString] componentsSeparatedByString:@"="] lastObject] integerValue];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        RestaurantDetailViewController *restaurantDetailViewController = [storyboard instantiateViewControllerWithIdentifier:@"RestaurantDetailViewController"];
        restaurantDetailViewController.restaurant = [RestaurantInfo sharedInstance].restaurants[restaurantIndex];

        // 關閉所有 Alert
        UIViewController *topMostViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
        while ([topMostViewController.presentedViewController isKindOfClass:[UIAlertController class]]) {
            [topMostViewController dismissViewControllerAnimated:NO completion:nil];
            topMostViewController = topMostViewController.presentedViewController;
        }

        // 顯示 Restaurant Detail View
        UITabBarController *rootViewController = (UITabBarController *)UIApplication.sharedApplication.keyWindow.rootViewController;
        rootViewController.selectedIndex = 0; // 切到第一個 Tab
        UINavigationController *navigationController = (UINavigationController *)rootViewController.selectedViewController;
        [navigationController dismissViewControllerAnimated:NO completion:nil]; // 關閉所有 View
        NSMutableArray *allnavigationViews = [NSMutableArray arrayWithArray:navigationController.viewControllers];
        [navigationController setViewControllers:@[allnavigationViews.firstObject, restaurantDetailViewController] animated:YES]; // 置換 navigation 畫面堆疊

        return YES;
    }

    return NO;
}

@end
