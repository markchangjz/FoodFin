//
//  WalkthroughContentViewController.h
//  FoodPin
//
//  Created by MarkChang on 2017/4/6.
//  Copyright © 2017年 MarkChang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WalkthroughContentViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *headingLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;

@property (nonatomic) NSInteger index;
@property (copy, nonatomic) NSString *heading;
@property (copy, nonatomic) NSString *content;
@property (copy, nonatomic) NSString *imageFile;

@end
