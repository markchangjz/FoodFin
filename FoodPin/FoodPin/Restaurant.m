//
//  Restaurant.m
//  FoodPin
//
//  Created by MarkChang on 2017/3/18.
//  Copyright © 2017年 MarkChang. All rights reserved.
//

#import "Restaurant.h"

@implementation Restaurant

- (instancetype)initWithName:(NSString *)name type:(NSString *)type location:(NSString *)location image:(UIImage *)image isVisited:(BOOL)isVisited {
	self = [super init];
	if (self) {
		_name = name;
		_type = type;
		_location = location;
		_image = image;
		_isVisited = isVisited;
	}
	return self;
}

@end
