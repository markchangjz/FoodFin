//
//  RestaurantTableViewCell.m
//  FoodPin
//
//  Created by MarkChang on 2017/3/17.
//  Copyright © 2017年 MarkChang. All rights reserved.
//

#import "RestaurantTableViewCell.h"

@implementation RestaurantTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

	// 圓角處理
	self.thumbnailImageView.layer.cornerRadius = 30.0;
	self.thumbnailImageView.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
