//
//  AboutTableViewController.m
//  FoodPin
//
//  Created by MarkChang on 2017/4/8.
//  Copyright © 2017年 MarkChang. All rights reserved.
//

#import "AboutTableViewController.h"

@interface AboutTableViewController ()

@property (copy, nonatomic) NSArray<NSString *> *sectionTitles;
@property (copy, nonatomic) NSArray<NSArray<NSString *> *> *sectionContent;
@property (copy, nonatomic) NSArray<NSString *> *links;

@end

@implementation AboutTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
	self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero]; // 移除多餘的分隔線
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return self.sectionContent[section].count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return self.sectionTitles[section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
	cell.textLabel.text = self.sectionContent[indexPath.section][indexPath.row];

    return cell;
}

#pragma Init variable

- (NSArray<NSString *> *)sectionTitles {
	if (!_sectionTitles) {
		_sectionTitles = @[@"Leave Feedback", @"Follow Us"];
	}
	return _sectionTitles;
}

-(NSArray<NSArray<NSString *> *> *)sectionContent {
	if (!_sectionContent) {
		_sectionContent = @[@[@"Rate us on App Store", @"Tell us your feedback"],
							@[@"Twitter", @"Facebook", @"Pinterest"]];
	}
	return _sectionContent;
}

- (NSArray<NSString *> *)links {
	if (!_links) {
		_links = @[@"https://twitter.com/appcodamobile", @"https://facebook.com/appcodamobile", @"https://www.pinterest.com/appcoda/"];
	}
	return _links;
}

@end
