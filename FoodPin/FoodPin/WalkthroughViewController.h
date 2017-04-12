//
//  WalkthroughViewController.h
//  FoodPin
//
//  Created by MarkChang on 2017/4/6.
//  Copyright © 2017年 MarkChang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WalkthroughViewController;

@protocol WalkthroughDelegate <NSObject>

- (void)dismissWalkthroughView:(WalkthroughViewController *)sender;

@end

@interface WalkthroughViewController : UIViewController

@property (weak, nonatomic) id <WalkthroughDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;

@end
