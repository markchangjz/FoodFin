//
//  FoodPinNotificationDelegate.m
//  FoodPin
//
//  Created by esunbank on 2017/4/11.
//  Copyright © 2017年 MarkChang. All rights reserved.
//

#import "FoodPinNotificationDelegate.h"
@import UIKit;

@implementation FoodPinNotificationDelegate

- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    completionHandler(UNNotificationPresentationOptionAlert | UNNotificationPresentationOptionSound);
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {

    NSString *restaurantIndex = [NSString stringWithFormat:@"%@", response.notification.request.content.userInfo[@"restaurant_index"]];
    [[UIApplication sharedApplication] openURL:[[NSURL alloc] initWithString:[NSString stringWithFormat:@"foodpin://restaurant_index=%@", restaurantIndex]] options:@{} completionHandler:nil];

    if ([response.actionIdentifier isEqualToString:@"View"]) {
        // View button has been clicked
    }
    else if ([response.actionIdentifier isEqualToString:@"Close"]) {
        // Close button has been clicked
    }
}

@end
