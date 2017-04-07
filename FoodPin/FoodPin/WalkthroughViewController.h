//
//  WalkthroughViewController.h
//  FoodPin
//
//  Created by MarkChang on 2017/4/6.
//  Copyright © 2017年 MarkChang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WalkthroughViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;

- (void)forward:(NSInteger)index;

@end
