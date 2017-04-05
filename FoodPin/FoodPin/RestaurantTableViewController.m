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
#import "Restaurant.h"
#import "AddRestaurantTableViewController.h"

@interface RestaurantTableViewController () {
	NSMutableArray *restaurantNames;
	NSMutableArray *restaurantImages;
	NSMutableArray *restaurantLocations;
	NSMutableArray *restaurantTypes;
	NSMutableArray *restaurantIsVisited;
}

@property (nonatomic) NSMutableArray *restaurants;

@end

@implementation RestaurantTableViewController

- (void)loadView {
	[super loadView];

	restaurantNames = [NSMutableArray arrayWithArray:@[@"Cafe Deadend", @"Homei", @"Teakha", @"Cafe Loisl", @"Petite Oyster", @"For Kee Restaurant", @"Po's Atelier", @"Bourke Street Bakery", @"Haigh's Chocolate", @"Palomino Espresso", @"Upstate", @"Traif", @"Graham Avenue Meats", @"Waffle & Wolf", @"Five Leaves", @"Cafe Lore", @"Confessional", @"Barrafina", @"Donostia", @"Royal Oak", @"Thai Cafe"]];

	restaurantImages = [NSMutableArray arrayWithArray:@[@"cafedeadend.jpg", @"homei.jpg", @"teakha.jpg", @"cafeloisl.jpg", @"petiteoyster.jpg", @"forkeerestaurant.jpg", @"posatelier.jpg", @"bourkestreetbakery.jpg", @"haighschocolate.jpg", @"palominoespresso.jpg", @"upstate.jpg", @"traif.jpg", @"grahamavenuemeats.jpg", @"wafflewolf.jpg", @"fiveleaves.jpg", @"cafelore.jpg", @"confessional.jpg", @"barrafina.jpg", @"donostia.jpg", @"royaloak.jpg", @"thaicafe.jpg"]];

	restaurantLocations = [NSMutableArray arrayWithArray:@[@"G/F, 72 Po Hing Fong, Sheung Wan, Hong Kong", @"Shop B, G/F, 22-24A Tai Ping San Street SOHO, Sheung Wan, Hong Kong", @"Shop B, 18 Tai Ping Shan Road SOHO, Sheung Wan, Hong Kong", @"Shop B, 20 Tai Ping Shan Road SOHO, Sheung Wan, Hong Kong", @"24 Tai Ping Shan Road SOHO, Sheung Wan, Hong Kong", @"Shop J-K., 200 Hollywood Road, SOHO, Sheung Wan, Hong Kong", @"G/F, 62 Po Hing Fong, Sheung Wan, Hong Kong", @"633 Bourke St Sydney New South Wales 2010 Surry Hills", @"412-414 George St Sydney New South Wales", @"Shop 1 61 York St Sydney New South Wales", @"95 1st Ave New York, NY 10003", @"229 S 4th St Brooklyn, NY 11211", @"445 Graham Ave Brooklyn, NY 11211", @"413 Graham Ave Brooklyn, NY 11211", @"18 Bedford Ave Brooklyn, NY 11222", @"Sunset Park 4601 4th Ave Brooklyn, NY 11220", @"308 E 6th St New York, NY 10003", @"54 Frith Street London W1D 4SL United Kingdom", @"10 Seymour Place London W1H 7ND United Kingdom", @"2 Regency Street London SW1P 4BZ United Kingdom", @"22 Charlwood Street London SW1V 2DY Pimlico"]];

	restaurantTypes = [NSMutableArray arrayWithArray:@[@"Coffee & Tea Shop", @"Cafe", @"Tea House", @"Austrian / Causual Drink", @"French", @"Bakery", @"Bakery", @"Chocolate", @"Cafe", @"American / Seafood", @"American", @"American", @"Breakfast & Brunch", @"Coffee & Tea", @"Coffee & Tea", @"Latin American", @"Spanish", @"Spanish", @"Spanish", @"British", @"Thai"]];

	restaurantIsVisited = [[NSMutableArray alloc] init];
	for (int i = 1; i <= 21; i++) {
		[restaurantIsVisited addObject:@NO];
	}

	self.restaurants = [[NSMutableArray alloc] init];
	for (int i = 0; i < restaurantNames.count; i++) {
		[self.restaurants addObject:[[Restaurant alloc] initWithName:restaurantNames[i] type:restaurantTypes[i] location:restaurantLocations[i] rating:nil image:[UIImage imageNamed:restaurantImages[i]] isVisited:[restaurantIsVisited[i] boolValue]]];
	}
}

- (void)viewDidLoad {
    [super viewDidLoad];

	// 將返回按鈕標題清空
	self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
//	self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];

	// 滑動隱藏 Navigation Bar
//	self.navigationController.hidesBarsOnSwipe = YES;

	// 動態調整 Cell 高度
	self.tableView.estimatedRowHeight = 80.0;
	self.tableView.rowHeight = UITableViewAutomaticDimension;

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
    return self.restaurants.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSString *cellIdentifier = @"Cell";
	RestaurantTableViewCell *cell = (RestaurantTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];

	Restaurant *restaurant = self.restaurants[indexPath.row];
	cell.nameLabel.text = restaurant.name;
	cell.locationLabel.text = restaurant.location;
	cell.typeLabel.text = restaurant.type;
	cell.thumbnailImageView.image = restaurant.image;
	cell.accessoryType = restaurant.isVisited ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;

    return cell;
}

// 有實作 tableView:editActionsForRowAtIndexPath: 此方法將失效，且不會自動產生 Delete 按鈕
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	if (editingStyle == UITableViewCellEditingStyleDelete) {
		[self.restaurants removeObjectAtIndex:indexPath.row];

		[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
	}
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
	// 分享
	UITableViewRowAction *shareAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"Share" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
		Restaurant *restaurant = self.restaurants[indexPath.row];
		NSString *defaultText = [NSString stringWithFormat:@"Just checking in at %@", restaurant.name];
		UIImage *imageToShare = restaurant.image;
		UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:@[defaultText, imageToShare] applicationActivities:nil];
		[self presentViewController:activityViewController animated:YES completion:nil];
	}];
	shareAction.backgroundColor = [UIColor colorWithRed:28.0/255.0 green:165.0/255.0 blue:253.0/255.0 alpha:1.0];

	// 刪除
	UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"Delete" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
		[self.restaurants removeObjectAtIndex:indexPath.row];

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

#pragma mark - Unwind

- (IBAction)unwindToHomeScreen:(UIStoryboardSegue *)segue {
	AddRestaurantTableViewController *addRestaurantTableViewController = segue.sourceViewController;
	if (addRestaurantTableViewController.restaurant) {
		[self.restaurants insertObject:addRestaurantTableViewController.restaurant atIndex:0];
		[self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationTop];
	}
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	if ([segue.identifier isEqualToString:@"showRestaurantDetail"]) {
		NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
		RestaurantDetailViewController *destinationViewController = segue.destinationViewController;
		destinationViewController.restaurant = self.restaurants[indexPath.row];
	}
}

@end
