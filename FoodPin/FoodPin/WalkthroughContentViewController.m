//
//  WalkthroughContentViewController.m
//  FoodPin
//
//  Created by MarkChang on 2017/4/6.
//  Copyright © 2017年 MarkChang. All rights reserved.
//

#import "WalkthroughContentViewController.h"

@interface WalkthroughContentViewController ()

@end

@implementation WalkthroughContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

	self.headingLabel.text = self.heading;
	self.contentLabel.text = self.content;
	self.contentImageView.image = [UIImage imageNamed:self.imageFile];

	self.pageControl.currentPage = self.index;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
