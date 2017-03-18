//
//  RestaurantTableViewController.m
//  FoodPin
//
//  Created by MarkChang on 2017/3/17.
//  Copyright © 2017年 MarkChang. All rights reserved.
//

#import "RestaurantTableViewController.h"
#import "RestaurantDetailViewController.h"
#import "RestaurantTableViewCell.h"

@interface RestaurantTableViewController () {
	NSMutableArray *restaurantNames;
	NSMutableArray *restaurantImages;
	NSMutableArray *restaurantLocations;
	NSMutableArray *restaurantTypes;
	NSMutableArray *restaurantIsVisited;
}

@end

@implementation RestaurantTableViewController

- (void)loadView {
	[super loadView];

	restaurantNames = [NSMutableArray arrayWithArray:@[@"Cafe Deadend", @"Homei", @"Teakha", @"Cafe Loisl", @"Petite Oyster", @"For Kee Restaurant", @"Po's Atelier", @"Bourke Street Bakery", @"Haigh's Chocolate", @"Palomino Espresso", @"Upstate", @"Traif", @"Graham Avenue Meats", @"Waffle & Wolf", @"Five Leaves", @"Cafe Lore", @"Confessional", @"Barrafina", @"Donostia", @"Royal Oak", @"Thai Cafe"]];

	restaurantImages = [NSMutableArray arrayWithArray:@[@"cafedeadend.jpg", @"homei.jpg", @"teakha.jpg", @"cafeloisl.jpg", @"petiteoyster.jpg", @"forkeerestaurant.jpg", @"posatelier.jpg", @"bourkestreetbakery.jpg", @"haighschocolate.jpg", @"palominoespresso.jpg", @"upstate.jpg", @"traif.jpg", @"grahamavenuemeats.jpg", @"wafflewolf.jpg", @"fiveleaves.jpg", @"cafelore.jpg", @"confessional.jpg", @"barrafina.jpg", @"donostia.jpg", @"royaloak.jpg", @"thaicafe.jpg"]];

	restaurantLocations = [NSMutableArray arrayWithArray:@[@"Hong Kong", @"Hong Kong", @"Hong Kong", @"Hong Kong", @"Hong Kong", @"Hong Kong", @"Hong Kong", @"Sydney", @"Sydney", @"Sydney", @"New York", @"New York", @"New York", @"New York", @"New York", @"New York", @"New York", @"London", @"London", @"London", @"London"]];

	restaurantTypes = [NSMutableArray arrayWithArray:@[@"Coffee & Tea Shop", @"Cafe", @"Tea House", @"Austrian / Causual Drink", @"French", @"Bakery", @"Bakery", @"Chocolate", @"Cafe", @"American / Seafood", @"American", @"American", @"Breakfast & Brunch", @"Coffee & Tea", @"Coffee & Tea", @"Latin American", @"Spanish", @"Spanish", @"Spanish", @"British", @"Thai"]];

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

// 有實作 tableView:editActionsForRowAtIndexPath: 此方法將失效，且不會自動產生 Delete 按鈕
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	if (editingStyle == UITableViewCellEditingStyleDelete) {
		[restaurantNames removeObjectAtIndex:indexPath.row];
		[restaurantImages removeObjectAtIndex:indexPath.row];
		[restaurantLocations removeObjectAtIndex:indexPath.row];
		[restaurantTypes removeObjectAtIndex:indexPath.row];
		[restaurantIsVisited removeObjectAtIndex:indexPath.row];

		[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
	}
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
	// 分享
	UITableViewRowAction *shareAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"Share" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
		NSString *defaultText = [NSString stringWithFormat:@"Just checking in at %@", restaurantNames[indexPath.row]];
		UIImage *imageToShare = [UIImage imageNamed:restaurantImages[indexPath.row]];
		UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:@[defaultText, imageToShare] applicationActivities:nil];
		[self presentViewController:activityViewController animated:YES completion:nil];
	}];
	shareAction.backgroundColor = [UIColor colorWithRed:28.0/255.0 green:165.0/255.0 blue:253.0/255.0 alpha:1.0];

	// 刪除
	UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"Delete" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
		[restaurantNames removeObjectAtIndex:indexPath.row];
		[restaurantImages removeObjectAtIndex:indexPath.row];
		[restaurantLocations removeObjectAtIndex:indexPath.row];
		[restaurantTypes removeObjectAtIndex:indexPath.row];
		[restaurantIsVisited removeObjectAtIndex:indexPath.row];

		[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
	}];
	deleteAction.backgroundColor = [UIColor colorWithRed:202.0/255.0 green:202.0/255.0 blue:203.0/255.0 alpha:1.0];

	return @[deleteAction, shareAction];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	// 取消 Cell 被選取
//	[tableView deselectRowAtIndexPath:indexPath animated:YES];
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	if ([segue.identifier isEqualToString:@"showRestaurantDetail"]) {
		NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
		RestaurantDetailViewController *destinationViewController = segue.destinationViewController;
		destinationViewController.restaurantImage = restaurantImages[indexPath.row];
	}
}

@end
