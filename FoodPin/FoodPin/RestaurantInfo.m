//
//  RestaurantInfo.m
//  FoodPin
//
//  Created by esunbank on 2017/4/12.
//  Copyright © 2017年 MarkChang. All rights reserved.
//

#import "RestaurantInfo.h"

@implementation RestaurantInfo

+ (RestaurantInfo *)sharedInstance {
    static RestaurantInfo *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[RestaurantInfo alloc] init];
    });
    return instance;
}

@end
