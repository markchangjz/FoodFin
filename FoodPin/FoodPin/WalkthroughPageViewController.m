//
//  WalkthroughPageViewController.m
//  FoodPin
//
//  Created by MarkChang on 2017/4/6.
//  Copyright © 2017年 MarkChang. All rights reserved.
//

#import "WalkthroughPageViewController.h"
#import "WalkthroughContentViewController.h"

@interface WalkthroughPageViewController () <UIPageViewControllerDataSource>

@property (copy, nonatomic) NSArray *pageHeadings;
@property (copy, nonatomic) NSArray *pageImages;
@property (copy, nonatomic) NSArray *pageContent;

@end

@implementation WalkthroughPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	self.dataSource = self;

	WalkthroughContentViewController *staringViewController = [self viewControllerAtIndex:0];
	[self setViewControllers:@[staringViewController] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIPageViewControllerDataSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
	WalkthroughContentViewController *walkthroughContentViewController = (WalkthroughContentViewController *)viewController;
	NSInteger index = walkthroughContentViewController.index;
	index++;

	return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
	WalkthroughContentViewController *walkthroughContentViewController = (WalkthroughContentViewController *)viewController;
	NSInteger index = walkthroughContentViewController.index;
	index--;

	return [self viewControllerAtIndex:index];
}

#pragma mark - Function

- (WalkthroughContentViewController *)viewControllerAtIndex:(NSInteger)index {
	if (index == NSNotFound || index < 0 || index >= self.pageHeadings.count) {
		return nil;
	}

	WalkthroughContentViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"WalkthroughContentViewController"];

	if (pageContentViewController) {
		pageContentViewController.imageFile = self.pageImages[index];
		pageContentViewController.heading = self.pageHeadings[index];
		pageContentViewController.content = self.pageContent[index];
		pageContentViewController.index = index;

		return pageContentViewController;
	}

	return nil;
}

#pragma mark - Init variable

- (NSArray *)pageHeadings {
	if (!_pageHeadings) {
		_pageHeadings = @[@"Personalize", @"Locate", @"Discover"];
	}
	return _pageHeadings;
}

- (NSArray *)pageImages {
	if (!_pageImages) {
		_pageImages = @[@"foodpin-intro-1", @"foodpin-intro-2", @"foodpin-intro-3"];
	}
	return _pageImages;
}

- (NSArray *)pageContent {
	if (!_pageContent) {
		_pageContent = @[@"Pin your favorite restaurants and create your own food guide", @"Search and locate your favourite restaurant on Maps", @"Find restaurants pinned by your friends and other foodies around the world"];
	}
	return _pageContent;
}

@end
