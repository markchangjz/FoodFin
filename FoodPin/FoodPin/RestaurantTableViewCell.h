//
//  RestaurantTableViewCell.h
//  FoodPin
//
//  Created by MarkChang on 2017/3/17.
//  Copyright © 2017年 MarkChang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RestaurantTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *thumbnailImageView;

@end
