//
//  ReviewViewController.m
//  FoodPin
//
//  Created by MarkChang on 2017/3/21.
//  Copyright © 2017年 MarkChang. All rights reserved.
//

#import "ReviewViewController.h"

@interface ReviewViewController ()

@property (nonatomic) UIVisualEffectView *blurEffectView;

@end

@implementation ReviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

	// 加入模糊效果
	UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
	self.blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
	[self.backgroundImageView addSubview:self.blurEffectView];

	self.ratingStackView.transform = CGAffineTransformMakeScale(0.0, 0.0);
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];

	[UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionTransitionNone animations:^{
		self.ratingStackView.transform = CGAffineTransformIdentity;

		// 設定半透明背景 http://stackoverflow.com/questions/11236367/display-clearcolor-uiviewcontroller-over-uiviewcontroller
		self.view.alpha = 0.95;
		self.view.backgroundColor = [UIColor clearColor];
		self.view.opaque = NO;
	} completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews {
	[super viewWillLayoutSubviews];

	self.blurEffectView.frame = self.view.frame;
}

- (IBAction)ratingSelected:(UIButton *)sender {
	switch (sender.tag) {
		case 100:
			self.rating = @"dislike";
			break;
		case 200:
			self.rating = @"good";
			break;
		case 300:
			self.rating = @"great";
			break;
		default:
			break;
	}

	[self performSegueWithIdentifier:@"unwindToDetailView" sender:sender];
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
