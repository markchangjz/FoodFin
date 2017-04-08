//
//  WebViewController.m
//  FoodPin
//
//  Created by MarkChang on 2017/4/8.
//  Copyright © 2017年 MarkChang. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];

	NSURL *url = [NSURL URLWithString:@"http://www.appcoda.com/contact"];
	NSURLRequest *request = [NSURLRequest requestWithURL:url];
	[self.webView loadRequest:request];
}

@end
