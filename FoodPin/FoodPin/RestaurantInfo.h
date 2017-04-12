//
//  RestaurantInfo.h
//  FoodPin
//
//  Created by esunbank on 2017/4/12.
//  Copyright © 2017年 MarkChang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Restaurant.h"

@interface RestaurantInfo : NSObject

+ (RestaurantInfo *)sharedInstance;

@property (nonatomic) NSMutableArray<Restaurant *> *restaurants;

@end
