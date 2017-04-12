//
//  RestaurantDetailViewController.m
//  FoodPin
//
//  Created by MarkChang on 2017/3/18.
//  Copyright © 2017年 MarkChang. All rights reserved.
//

#import "RestaurantDetailViewController.h"
#import "RestaurantDetailTableViewCell.h"
#import "ReviewViewController.h"
#import "MapViewController.h"
#import "RestaurantInfo.h"

@interface RestaurantDetailViewController () <UITableViewDataSource, UITableViewDelegate, UITabBarDelegate>

@end

@implementation RestaurantDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

	self.title = self.restaurant.name;

	self.restaurantImageView.image = self.restaurant.image;
	self.restaurantImageView.clipsToBounds = YES; // 圖片太大張，避免返回上一頁動畫 lag
	self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero]; // 移除多餘的分隔線

	// 動態調整 Cell 高度
	self.tableView.estimatedRowHeight = 36.0;
	self.tableView.rowHeight = UITableViewAutomaticDimension;

	// 將返回按鈕標題清空
	self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];

	// 設定評分圖示
	if (self.restaurant.rating) {
		[self.ratingButton setImage:[UIImage imageNamed:self.restaurant.rating] forState:UIControlStateNormal];
	}
}

#pragma mark - Table View

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSString *cellIdentifier = @"Cell";
	RestaurantDetailTableViewCell *cell = (RestaurantDetailTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];

	switch (indexPath.row) {
		case 0:
			cell.fieldLabel.text = @"Name";
			cell.valueLabel.text = self.restaurant.name;
			break;
		case 1:
			cell.fieldLabel.text = @"Type";
			cell.valueLabel.text = self.restaurant.type;
			break;
		case 2:
			cell.fieldLabel.text = @"Location";
			cell.valueLabel.text = self.restaurant.location;
			break;
		case 3:
			cell.fieldLabel.text = @"Been here";
			cell.valueLabel.text = self.restaurant.isVisited ? @"Yes, I've been here before" : @"No";
			break;
		default:
			cell.fieldLabel.text = @"";
			cell.valueLabel.text = @"";
			break;
	}

	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row == 0) {
        RestaurantDetailTableViewCell *editCell = [tableView cellForRowAtIndexPath:indexPath];

        UIAlertController *editAlertController = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"Edit %@", editCell.fieldLabel.text] message:nil preferredStyle:UIAlertControllerStyleAlert];
        [editAlertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = editCell.fieldLabel.text;
            textField.text = editCell.valueLabel.text;
            textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        }];

        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *saveAction = [UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UITextField *editTextField = editAlertController.textFields.firstObject;
            if (![editTextField.text isEqualToString:@""]) {
                // 刷新 Restaurant Table View 的資料
                NSInteger reloadCellIndex = [[RestaurantInfo sharedInstance].restaurants indexOfObject:self.restaurant];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"RestaurantHasBeenUpdated" object:[NSNumber numberWithInteger:reloadCellIndex]];

                // 刷新 Restaurant Detail View 的資料
                self.restaurant.name = editTextField.text;
                self.title = editTextField.text;
                [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            }
        }];

        [editAlertController addAction:cancelAction];
        [editAlertController addAction:saveAction];
        [self presentViewController:editAlertController animated:YES completion:nil];
    }

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Unwind

- (IBAction)close:(UIStoryboardSegue *)segue {
	ReviewViewController *reviewViewController = segue.sourceViewController;
	NSString *rating = reviewViewController.rating;
	if (rating) {
		self.restaurant.rating = rating;
		[self.ratingButton setImage:[UIImage imageNamed:rating] forState:UIControlStateNormal];
	}
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	if ([segue.identifier isEqualToString:@"showMap"]) {
		MapViewController *mapViewController = segue.destinationViewController;
		mapViewController.restaurant = self.restaurant;
	}
}

@end
