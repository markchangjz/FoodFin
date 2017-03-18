//
//  RestaurantTableViewController.m
//  FoodPin
//
//  Created by MarkChang on 2017/3/17.
//  Copyright © 2017年 MarkChang. All rights reserved.
//

#import "RestaurantTableViewController.h"
#import "RestaurantTableViewCell.h"

@interface RestaurantTableViewController () {
	NSArray *restaurantNames;
	NSArray *restaurantImages;
	NSArray *restaurantLocations;
	NSArray *restaurantTypes;
	NSMutableArray *restaurantIsVisited;
}

@end

@implementation RestaurantTableViewController

- (void)loadView {
	[super loadView];

	restaurantNames = @[@"Cafe Deadend", @"Homei", @"Teakha", @"Cafe Loisl", @"Petite Oyster", @"For Kee Restaurant", @"Po's Atelier", @"Bourke Street Bakery", @"Haigh's Chocolate", @"Palomino Espresso", @"Upstate", @"Traif", @"Graham Avenue Meats", @"Waffle & Wolf", @"Five Leaves", @"Cafe Lore", @"Confessional", @"Barrafina", @"Donostia", @"Royal Oak", @"Thai Cafe"];

	restaurantImages = @[@"cafedeadend.jpg", @"homei.jpg", @"teakha.jpg", @"cafeloisl.jpg", @"petiteoyster.jpg", @"forkeerestaurant.jpg", @"posatelier.jpg", @"bourkestreetbakery.jpg", @"haighschocolate.jpg", @"palominoespresso.jpg", @"upstate.jpg", @"traif.jpg", @"grahamavenuemeats.jpg", @"wafflewolf.jpg", @"fiveleaves.jpg", @"cafelore.jpg", @"confessional.jpg", @"barrafina.jpg", @"donostia.jpg", @"royaloak.jpg", @"thaicafe.jpg"];

	restaurantLocations = @[@"Hong Kong", @"Hong Kong", @"Hong Kong", @"Hong Kong", @"Hong Kong", @"Hong Kong", @"Hong Kong", @"Sydney", @"Sydney", @"Sydney", @"New York", @"New York", @"New York", @"New York", @"New York", @"New York", @"New York", @"London", @"London", @"London", @"London"];

	restaurantTypes = @[@"Coffee & Tea Shop", @"Cafe", @"Tea House", @"Austrian / Causual Drink", @"French", @"Bakery", @"Bakery", @"Chocolate", @"Cafe", @"American / Seafood", @"American", @"American", @"Breakfast & Brunch", @"Coffee & Tea", @"Coffee & Tea", @"Latin American", @"Spanish", @"Spanish", @"Spanish", @"British", @"Thai"];

	restaurantIsVisited = [[NSMutableArray alloc] init];
	for (int i = 1; i <= 21; i++) {
		[restaurantIsVisited addObject:@NO];
	}
}

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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return restaurantNames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSString *cellIdentifier = @"Cell";
	RestaurantTableViewCell *cell = (RestaurantTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
	cell.nameLabel.text = restaurantNames[indexPath.row];
	cell.locationLabel.text = restaurantLocations[indexPath.row];
	cell.typeLabel.text = restaurantTypes[indexPath.row];
	cell.thumbnailImageView.image = [UIImage imageNamed:restaurantImages[indexPath.row]];
	cell.accessoryType = [restaurantIsVisited[indexPath.row] boolValue] ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;

    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	UIAlertController *optionMenu = [UIAlertController alertControllerWithTitle:nil message:@"What do you want to do?" preferredStyle:UIAlertControllerStyleActionSheet];

	// 取消選項
	UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
	[optionMenu addAction:cancelAction];

	// 撥電話選項
	void (^callActionHandler)(UIAlertAction *) = ^(UIAlertAction *alertAction) {
		UIAlertController *alertMessage = [UIAlertController alertControllerWithTitle:@"Service Unavailable" message:@"Sorry, the call feature is not available yet. Please retry later." preferredStyle:UIAlertControllerStyleAlert];
		[alertMessage addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
		[self presentViewController:alertMessage animated:YES completion:nil];
	};
	UIAlertAction *callAction = [UIAlertAction actionWithTitle:[NSString stringWithFormat:@"Call 123-000-%ld", (long)indexPath.row] style:UIAlertActionStyleDefault handler:callActionHandler];
	[optionMenu addAction:callAction];

	// 已來過選項
	UIAlertAction *isVisitedAction = [UIAlertAction actionWithTitle:@"I've been here" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
		UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
		cell.accessoryType = UITableViewCellAccessoryCheckmark;
	}];
	[optionMenu addAction:isVisitedAction];

	[self presentViewController:optionMenu animated:YES completion:nil];

	// 取消 Cell 被選取
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

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

@end
