//
//  WalkthroughContentViewController.m
//  FoodPin
//
//  Created by MarkChang on 2017/4/6.
//  Copyright © 2017年 MarkChang. All rights reserved.
//

#import "WalkthroughContentViewController.h"
#import "WalkthroughPageViewController.h"

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
	switch (self.index) {
		case 0:
		case 1:
			[self.forwardButton setTitle:@"NEXT" forState:UIControlStateNormal];
			break;
		case 2:
			[self.forwardButton setTitle:@"DONE" forState:UIControlStateNormal];
			break;
		default:
			break;
	}
}

#pragma IBAction

- (IBAction)nextButtonTapped:(UIButton *)sender {
	switch (self.index) {
		case 0:
		case 1:
		{
			WalkthroughPageViewController *pageViewController = (WalkthroughPageViewController *)self.parentViewController;
			[pageViewController forward:self.index];
		}
			break;
		case 2:
			[[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"hasViewedWalkthrough"];
			[self dismissViewControllerAnimated:YES completion:nil];
			break;
		default:
			break;
	}
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
