//
//  RestaurantDetailViewController.m
//  FoodPin
//
//  Created by MarkChang on 2017/3/18.
//  Copyright © 2017年 MarkChang. All rights reserved.
//

#import "RestaurantDetailViewController.h"
#import "RestaurantDetailTableViewCell.h"

@interface RestaurantDetailViewController () <UITableViewDataSource, UITabBarDelegate>

@end

@implementation RestaurantDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	self.restaurantImageView.image = [UIImage imageNamed:self.restaurant.image];
	self.restaurantImageView.clipsToBounds = YES; // 圖片太大張，避免返回上一頁動畫 lag
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
