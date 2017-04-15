//
//  AppDelegate+UserNotifications.m
//  FoodPin
//
//  Created by esunbank on 2017/4/11.
//  Copyright © 2017年 MarkChang. All rights reserved.
//

#import "AppDelegate+UserNotifications.h"
#import "FoodPinNotificationDelegate.h"
#import <objc/runtime.h>
@import UserNotifications;

@interface AppDelegate()

@property (strong, nonatomic) FoodPinNotificationDelegate *notificationDelegate;

@end

@implementation AppDelegate (UserNotifications)

// Local Notifications https://useyourloaf.com/blog/local-notifications-with-ios-10/
- (void)registerUserNotifications {
    if ([[NSProcessInfo processInfo] operatingSystemVersion].majorVersion >= 10) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        UNAuthorizationOptions options = UNAuthorizationOptionAlert|UNAuthorizationOptionSound;
        [center requestAuthorizationWithOptions:options
                              completionHandler:^(BOOL granted, NSError * _Nullable error) {
                                  if (error != nil) {
                                      NSLog(@"Error: %@", error.localizedDescription);
                                  }
                              }];

        self.notificationDelegate = [[FoodPinNotificationDelegate alloc] init];
        center.delegate = self.notificationDelegate;
    }
    else {
        if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)]) {
            [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeSound categories:nil]];
        }
    }
}

#pragma mark - UIApplicationDelegate

// For iOS 9 Local Notification
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {

    if ([application applicationState] == UIApplicationStateInactive) {
        // App 在背景
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *restaurantIndex = [NSString stringWithFormat:@"%@", notification.userInfo[@"restaurant_index"]];
            [application openURL:[[NSURL alloc] initWithString:[NSString stringWithFormat:@"foodpin://restaurant_index=%@", restaurantIndex]]];
        });
    } else {
        // App 在前景
        UIAlertController *notificationAlertController = [UIAlertController alertControllerWithTitle:notification.userInfo[@"name"] message:notification.userInfo[@"location"] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *showAction = [UIAlertAction actionWithTitle:@"Show" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString *restaurantIndex = [NSString stringWithFormat:@"%@", notification.userInfo[@"restaurant_index"]];
                [application openURL:[[NSURL alloc] initWithString:[NSString stringWithFormat:@"foodpin://restaurant_index=%@", restaurantIndex]]];
            });
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];

        [notificationAlertController addAction:cancelAction];
        [notificationAlertController addAction:showAction];

        // http://stackoverflow.com/questions/6131205/iphone-how-to-find-topmost-view-controller
        UIViewController *topMostViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
        while (topMostViewController.presentedViewController) {
            topMostViewController = topMostViewController.presentedViewController;
        }

        [topMostViewController presentViewController:notificationAlertController animated:YES completion:nil];
    }
}

#pragma mark - Accessor
// Add property variable in category http://stackoverflow.com/questions/8733104/objective-c-property-instance-variable-in-category

- (FoodPinNotificationDelegate *)notificationDelegate {
    return objc_getAssociatedObject(self, @selector(notificationDelegate));
}

- (void)setNotificationDelegate:(FoodPinNotificationDelegate *)notificationDelegate {
    objc_setAssociatedObject(self, @selector(notificationDelegate), notificationDelegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
