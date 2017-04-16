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
#import "WalkthroughPageViewController.h"
#import "WalkthroughViewController.h"
#import "UIStatusBar.h"
#import "RestaurantInfo.h"
@import UserNotifications;

typedef NS_ENUM(NSUInteger, SearchScope) {
	All, Name, Location
};

@interface RestaurantTableViewController () <UISearchResultsUpdating, UISearchControllerDelegate, UISearchBarDelegate, WalkthroughDelegate> {
	NSMutableArray<NSString *> *restaurantNames;
	NSMutableArray<NSString *> *restaurantImages;
	NSMutableArray<NSString *> *restaurantLocations;
	NSMutableArray<NSString *> *restaurantTypes;
	NSMutableArray<NSNumber *> *restaurantIsVisited;
}

@property (nonatomic) NSMutableArray<Restaurant *> *restaurants;
@property (copy, nonatomic) NSArray<Restaurant *> *searchResults;
@property (nonatomic) UISearchController *searchController;

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

    [RestaurantInfo sharedInstance].restaurants = self.restaurants;
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

	// 設定 search bar
	self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
	self.searchController.searchResultsUpdater = self;
	self.searchController.delegate = self;
	self.searchController.searchBar.delegate = self;
	self.searchController.dimsBackgroundDuringPresentation = NO;
	self.searchController.searchBar.placeholder = @"Search restaurants...";
	self.searchController.searchBar.tintColor = [UIColor blackColor];
	self.searchController.searchBar.scopeButtonTitles = @[@"All", @"Name", @"Location"];
	self.tableView.tableHeaderView = self.searchController.searchBar;
	self.definesPresentationContext = YES; // 避免點選搜尋結過後，push 到下一頁 search bar 仍顯示

	[self performSelector:@selector(showWalkthroughView) withObject:nil afterDelay:0.7];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTableView:) name:@"RestaurantHasBeenUpdated" object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];

	[UIStatusBar appearance].backgroundColor = [UIColor clearColor];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Function

- (void)filterContentForSearchText:(NSString *)searchText scope:(SearchScope)scope {
	// NSPredicate: http://www.cnblogs.com/MarsGG/articles/1949239.html
	NSPredicate *searchNamePredicate = [NSPredicate predicateWithFormat:@"SELF.name CONTAINS[c] %@", searchText];
	NSPredicate *searchLocationPredicate = [NSPredicate predicateWithFormat:@"SELF.location CONTAINS[c] %@", searchText];
	NSPredicate *searchAllPredicate = [NSCompoundPredicate orPredicateWithSubpredicates:@[searchNamePredicate, searchLocationPredicate]]; // http://stackoverflow.com/questions/25636007/nspredicate-with-multiple-conditions

	switch (scope) {
		case All:
			self.searchResults = [self.restaurants filteredArrayUsingPredicate:searchAllPredicate];
			break;
		case Name:
			self.searchResults = [self.restaurants filteredArrayUsingPredicate:searchNamePredicate];
			break;
		case Location:
			self.searchResults = [self.restaurants filteredArrayUsingPredicate:searchLocationPredicate];
			break;
		default:
			break;
	}
}

- (void)showWalkthroughView {
	if ([[NSUserDefaults standardUserDefaults] boolForKey:@"hasViewedWalkthrough"]) {
		return;
	}

//	// 顯示引導畫面
//	WalkthroughPageViewController *pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"WalkthroughPageViewController"];
//	[self presentViewController:pageViewController animated:YES completion:nil];

	// 顯示引導畫面 2
	UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Walkthrough" bundle:nil];
	WalkthroughViewController *pageViewController = [storyboard instantiateViewControllerWithIdentifier:@"WalkthroughViewController"];
    pageViewController.delegate = self;
	[self presentViewController:pageViewController animated:YES completion:nil];
}

- (void)showRemindActionSheetWithRestaurantIndex:(NSInteger)index {
    UIAlertController *remindActionSheet = [UIAlertController alertControllerWithTitle:@"Remind me within" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *oneSecAction = [UIAlertAction actionWithTitle:@"1 sec" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self remindMeWithRestaurant:self.restaurants[index] within:1];
    }];
    UIAlertAction *threeSecAction = [UIAlertAction actionWithTitle:@"3 sec" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self remindMeWithRestaurant:self.restaurants[index] within:3];
    }];
    UIAlertAction *fiveSecAction = [UIAlertAction actionWithTitle:@"5 sec" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self remindMeWithRestaurant:self.restaurants[index] within:5];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [remindActionSheet addAction:oneSecAction];
    [remindActionSheet addAction:threeSecAction];
    [remindActionSheet addAction:fiveSecAction];
    [remindActionSheet addAction:cancelAction];
    [self presentViewController:remindActionSheet animated:YES completion:nil];
}

- (void)remindMeWithRestaurant:(Restaurant *)restaurant within:(NSTimeInterval)sec {

    if ([[NSProcessInfo processInfo] operatingSystemVersion].majorVersion >= 10) {
        NSString *notificationIdentifier = @"FoodPinLocalNotification";
        NSString *categoryIdentifier = @"FoodPinNotificationCategory";
        NSString *attachmentIdentifier = @"FoodPinNotificationAttachment";

        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
        content.title = [NSString stringWithFormat:@"%@ (%.0f sec)", restaurant.name, sec];
        content.body = restaurant.location;
        content.userInfo = @{@"restaurant_index": [NSNumber numberWithInteger:[self.restaurants indexOfObject:restaurant]]};
        content.sound = [UNNotificationSound defaultSound];
        content.categoryIdentifier = categoryIdentifier;

        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *imageFilePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"image.png"];
        [UIImagePNGRepresentation(restaurant.image) writeToFile:imageFilePath atomically:YES];
        UNNotificationAttachment *attachment = [UNNotificationAttachment attachmentWithIdentifier:attachmentIdentifier URL:[NSURL fileURLWithPath:imageFilePath] options:nil error:nil];
        content.attachments = @[attachment];

        UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:sec repeats:NO];
        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:notificationIdentifier content:content trigger:trigger];

        UNNotificationAction *viewAction = [UNNotificationAction actionWithIdentifier:@"View" title:@"View" options:UNNotificationActionOptionNone];
        UNNotificationAction *closeAction = [UNNotificationAction actionWithIdentifier:@"Close" title:@"Close" options:UNNotificationActionOptionDestructive];
        UNNotificationCategory *category = [UNNotificationCategory categoryWithIdentifier:categoryIdentifier actions:@[viewAction, closeAction] intentIdentifiers:@[] options:UNNotificationCategoryOptionNone];
        NSSet *categories = [NSSet setWithObject:category];

        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        [center setNotificationCategories:categories];
        [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
            if (error != nil) {
                NSLog(@"Error: %@", error.localizedDescription);
            }
        }];
    }
    else {
        NSString *(^restaurantInfoString)(NSString *name, NSString *location) = ^(NSString *name, NSString *location) {
            return [NSString stringWithFormat:@"%@ @ %@", name, location];
        };
        UILocalNotification *localNotification = [[UILocalNotification alloc] init];
        localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:sec];
        localNotification.timeZone = [NSTimeZone defaultTimeZone];
        localNotification.repeatInterval = 0;
        localNotification.alertBody = restaurantInfoString(restaurant.name, restaurant.location);
        localNotification.userInfo = @{@"restaurant_index": [NSNumber numberWithInteger:[self.restaurants indexOfObject:restaurant]], @"name": restaurant.name, @"location": restaurant.location};
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

	// For testing
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:0];
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    localNotification.repeatInterval = 0;
    localNotification.alertBody = @"Test";
    localNotification.userInfo = @{@"restaurant_index": [NSNumber numberWithInteger:1], @"name": @"Name", @"location": @"Location"};
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}

- (void)refreshTableView:(NSNotification *)notification {
    NSIndexPath *reloadIndexPath = [NSIndexPath indexPathForRow:[notification.object integerValue] inSection:0];

    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadRowsAtIndexPaths:@[reloadIndexPath] withRowAnimation:UITableViewRowAnimationNone];
    });
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if (self.searchController.active) {
		return self.searchResults.count;
	}
	else {
		return self.restaurants.count;
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSString *cellIdentifier = @"Cell";
	RestaurantTableViewCell *cell = (RestaurantTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];

	Restaurant *restaurant = self.searchController.active ? self.searchResults[indexPath.row] : self.restaurants[indexPath.row];
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
	deleteAction.backgroundColor = [UIColor grayColor];
    
    // 提醒
    UITableViewRowAction *remindAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"Remind" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {

        if ([[NSProcessInfo processInfo] operatingSystemVersion].majorVersion >= 10) {
            UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
            [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
                if (settings.authorizationStatus != UNAuthorizationStatusAuthorized) {
                    // Notifications is not allowed
                    UIAlertController *notAuthorizeAlert = [UIAlertController alertControllerWithTitle:@"Notifications is not allowed" message:@"Please allow notifications in settings" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
                    [notAuthorizeAlert addAction:cancelAction];
                    [self presentViewController:notAuthorizeAlert animated:YES completion:nil];
                }
                else {
                    [self showRemindActionSheetWithRestaurantIndex:indexPath.row];
                }
            }];
        }
        else {
            [self showRemindActionSheetWithRestaurantIndex:indexPath.row];
        }
    }];
    remindAction.backgroundColor = [UIColor orangeColor];

	return @[deleteAction, remindAction, shareAction];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
	return !self.searchController.active;
}

#pragma mark - UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
	NSString *searchText = searchController.searchBar.text;
	if (![searchText isEqualToString:@""]) {
		if (searchController.searchBar.selectedScopeButtonIndex == 0) {
			[self filterContentForSearchText:searchText scope:All];
		}
		else if (searchController.searchBar.selectedScopeButtonIndex == 1) {
			[self filterContentForSearchText:searchText scope:Name];
		}
		else if (searchController.searchBar.selectedScopeButtonIndex == 2) {
			[self filterContentForSearchText:searchText scope:Location];
		}
	}

	[self.tableView reloadData];
}

#pragma mark - UISearchBarDelegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
	[UIStatusBar appearance].backgroundColor = [UIColor blackColor];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
	[UIStatusBar appearance].backgroundColor = [UIColor clearColor];
}

// 切換 scope 類型
- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope {
	NSString *searchText = searchBar.text;

	if (searchBar.selectedScopeButtonIndex == 0) {
		[self filterContentForSearchText:searchText scope:All];
	}
	else if (searchBar.selectedScopeButtonIndex == 1) {
		[self filterContentForSearchText:searchText scope:Name];
	}
	else if (searchBar.selectedScopeButtonIndex == 2) {
		[self filterContentForSearchText:searchText scope:Location];
	}

	[self.tableView reloadData];
}

#pragma mark - UISearchControllerDelegate

- (void)willPresentSearchController:(UISearchController *)searchController {
	self.searchResults = self.restaurants; // 讓一開始搜尋的資料為原本資料，避免一開始全空不好看
}

#pragma mark - Unwind

- (IBAction)unwindToHomeScreen:(UIStoryboardSegue *)segue {
	AddRestaurantTableViewController *addRestaurantTableViewController = segue.sourceViewController;
	if (addRestaurantTableViewController.restaurant) {
		[self.restaurants insertObject:addRestaurantTableViewController.restaurant atIndex:0];
		[self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationTop];
	}
}

#pragma mark - IBAction

- (IBAction)refresh:(UIBarButtonItem *)sender {
	[[NSUserDefaults standardUserDefaults] removeObjectForKey:@"hasViewedWalkthrough"];
    [self showWalkthroughView];
}

#pragma mark - WalkthroughDelegate

- (void)dismissWalkthroughView:(WalkthroughViewController *)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"hasViewedWalkthrough"];
    }];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	if ([segue.identifier isEqualToString:@"showRestaurantDetail"]) {
		NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
		RestaurantDetailViewController *destinationViewController = segue.destinationViewController;
		destinationViewController.hidesBottomBarWhenPushed = YES; // 隱藏 Tab Bar
		destinationViewController.restaurant = self.searchController.active ? self.searchResults[indexPath.row] : self.restaurants[indexPath.row];
	}
}

@end
