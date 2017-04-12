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
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    UNAuthorizationOptions options = UNAuthorizationOptionAlert + UNAuthorizationOptionSound;
    [center requestAuthorizationWithOptions:options
                          completionHandler:^(BOOL granted, NSError * _Nullable error) {
                              if (error != nil) {
                                  NSLog(@"Error: %@", error.localizedDescription);
                              }
                          }];

    self.notificationDelegate = [[FoodPinNotificationDelegate alloc] init];
    center.delegate = self.notificationDelegate;
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
