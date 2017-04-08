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
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return self.sectionContent[section].count;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
