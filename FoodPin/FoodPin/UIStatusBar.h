//
//  UIStatusBar.h
//  FoodPin
//
//  Created by MarkChang on 2017/4/8.
//  Copyright © 2017年 MarkChang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIStatusBar : NSObject

+ (UIStatusBar *)appearance;

@property (nonatomic) UIColor *backgroundColor;

@end
