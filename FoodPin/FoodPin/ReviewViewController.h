//
//  ReviewViewController.h
//  FoodPin
//
//  Created by MarkChang on 2017/3/21.
//  Copyright © 2017年 MarkChang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReviewViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIStackView *ratingStackView;
@property (copy, nonatomic) NSString *rating;

@end
