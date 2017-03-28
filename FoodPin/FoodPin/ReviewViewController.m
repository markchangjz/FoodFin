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
@property (nonatomic) UITapGestureRecognizer *tapGestureRecognizer;

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

	// 加入點擊手勢
	self.tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedReviewView:)];
	[self.view addGestureRecognizer:self.tapGestureRecognizer];
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

#pragma mark - IBAction

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

- (void)tappedReviewView:(UITapGestureRecognizer *)gesture {
	// 點擊非畫面的元件，關閉 View
	if (gesture.state == UIGestureRecognizerStateEnded) {
		CGPoint tapPonit = [gesture locationInView:gesture.view];

		if (CGRectContainsPoint(self.closeButton.frame, tapPonit)) {
			return;
		}
		if (CGRectContainsPoint(self.ratingMessageLabel.frame, tapPonit)) {
			return;
		}
		if (CGRectContainsPoint(self.ratingStackView.frame, tapPonit)) {
			return;
		}

		[self performSegueWithIdentifier:@"unwindToDetailView" sender:gesture];
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
