//
//  WalkthroughViewController.m
//  FoodPin
//
//  Created by MarkChang on 2017/4/6.
//  Copyright © 2017年 MarkChang. All rights reserved.
//

/*
 Using UIPageViewController With Custom UIPageControl
 http://samwize.com/2016/03/08/using-uipageviewcontroller-with-custom-uipagecontrol/
 */

#import "WalkthroughViewController.h"

@interface WalkthroughViewController () <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (nonatomic) UIPageViewController *pageContainer;
@property (copy, nonatomic) NSArray *pages;
@property (nonatomic) NSInteger currentIndex;
@property (nonatomic) NSInteger pendingIndex;

@end

@implementation WalkthroughViewController

- (void)viewDidLoad {
    [super viewDidLoad];

	UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Walkthrough" bundle:nil];
	UIViewController *page1 = [storyboard instantiateViewControllerWithIdentifier:@"page1"];
	UIViewController *page2 = [storyboard instantiateViewControllerWithIdentifier:@"page2"];
	UIViewController *page3 = [storyboard instantiateViewControllerWithIdentifier:@"page3"];
	self.pages = @[page1, page2, page3];

	// 設定 PageViewController
	self.pageContainer = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
	self.pageContainer.delegate = self;
	self.pageContainer.dataSource = self;
	[self.pageContainer setViewControllers:@[page1] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
	[self.view addSubview:self.pageContainer.view];

	// 把 nextButton 跟 pageControl 提到畫面最前方
	[self.view bringSubviewToFront:self.nextButton];
	[self.view bringSubviewToFront:self.pageControl];
	self.pageControl.numberOfPages = self.pages.count;
	self.pageControl.currentPage = 0;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
	// 設定只能顯示直向
	return UIInterfaceOrientationMaskPortrait;
}

#pragma mark - UIPageViewControllerDataSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
	NSInteger currentIndex = [self.pages indexOfObject:viewController];
	if (currentIndex == self.pages.count - 1) {
		return nil;
	}

	NSInteger nextIndex = currentIndex + 1;
	return self.pages[nextIndex];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
	NSInteger currentIndex = [self.pages indexOfObject:viewController];
	if (currentIndex == 0) {
		return nil;
	}

	NSInteger previousIndex = currentIndex - 1;
	return self.pages[previousIndex];
}

#pragma mark - UIPageViewControllerDelegate

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers {
	self.pendingIndex = [self.pages indexOfObject:pendingViewControllers.firstObject];
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
	if (completed) {
		self.currentIndex = self.pendingIndex;
		self.pageControl.currentPage = self.currentIndex;
	}

	[self handelNextButtonTitle];
}

#pragma mark - IBAction

- (IBAction)nextButtonTapped:(UIButton *)sender {
	if (self.pageControl.currentPage < self.pages.count - 1) {
		[self forward:self.pageControl.currentPage];
	}
	else {
		[self dismissViewControllerAnimated:YES completion:^{
			[[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"hasViewedWalkthrough"];
		}];
	}

	[self handelNextButtonTitle];
}

#pragma mark - Function

- (void)forward:(NSInteger)index {
	UIViewController *nextPageViewController = (UIViewController *)[self.pages objectAtIndex:index + 1];
	[self.pageContainer setViewControllers:@[nextPageViewController] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];

	self.pageControl.currentPage = index + 1;
}

- (void)handelNextButtonTitle {
	if (self.pageControl.currentPage == self.pageControl.numberOfPages - 1) {
		[self.nextButton setTitle:@"DONE" forState:UIControlStateNormal];
	}
	else {
		[self.nextButton setTitle:@"NEXT" forState:UIControlStateNormal];
	}
}

@end
