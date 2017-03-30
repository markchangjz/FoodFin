//
//  AddRestaurantTableViewController.m
//  FoodPin
//
//  Created by MarkChang on 2017/3/30.
//  Copyright © 2017年 MarkChang. All rights reserved.
//

#import "AddRestaurantTableViewController.h"

@interface AddRestaurantTableViewController ()

@end

@implementation AddRestaurantTableViewController

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

#pragma mark - Table view

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.row == 0) {
		// 確認是否有權限 https://medium.com/@apppeterpan/ios-10%E5%AD%98%E5%8F%96%E4%BD%BF%E7%94%A8%E8%80%85%E7%A7%81%E5%AF%86%E8%B3%87%E6%96%99%E9%83%BD%E8%A6%81%E5%8A%A0%E4%B8%8Ausage-description-a01715e56491
		if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
			UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
			imagePicker.allowsEditing = YES;
			imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;

			[self presentViewController:imagePicker animated:YES completion:nil];
		}

		[tableView deselectRowAtIndexPath:indexPath animated:YES];
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
