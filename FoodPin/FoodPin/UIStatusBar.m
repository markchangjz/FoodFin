//
//  UIStatusBar.m
//  FoodPin
//
//  Created by MarkChang on 2017/4/8.
//  Copyright © 2017年 MarkChang. All rights reserved.
//

/*
 ios7 - How to change the status bar background color and text color on iOS 7_ - Stack Overflow
 http://stackoverflow.com/questions/19063365/how-to-change-the-status-bar-background-color-and-text-color-on-ios-7
 */

#import "UIStatusBar.h"

@implementation UIStatusBar

+ (UIStatusBar *)appearance {
	static UIStatusBar *instance = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		instance = [[UIStatusBar alloc] init];
	});
	return instance;
}

- (void)setStatusBarBackgroundColor:(UIColor *)color {
	UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];

	if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
		statusBar.backgroundColor = color;
	}
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
	[self setStatusBarBackgroundColor:backgroundColor];
	_backgroundColor = backgroundColor;
}

@end
