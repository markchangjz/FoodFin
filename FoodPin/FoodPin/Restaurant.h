//
//  Restaurant.h
//  FoodPin
//
//  Created by MarkChang on 2017/3/18.
//  Copyright © 2017年 MarkChang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Restaurant : NSObject

@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *type;
@property (copy, nonatomic) NSString *location;
@property (copy, nonatomic) NSString *rating;
@property (nonatomic) UIImage *image;
@property (nonatomic) BOOL isVisited;

- (instancetype)initWithName:(NSString *)name type:(NSString *)type location:(NSString *)location rating:(NSString *)rating image:(UIImage *)image isVisited:(BOOL)isVisited;

@end
