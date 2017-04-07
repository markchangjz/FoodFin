//
//  AddRestaurantTableViewController.m
//  FoodPin
//
//  Created by MarkChang on 2017/3/30.
//  Copyright © 2017年 MarkChang. All rights reserved.
//

#import "AddRestaurantTableViewController.h"

@interface AddRestaurantTableViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *typeTextField;
@property (weak, nonatomic) IBOutlet UITextField *locationTextField;
@property (weak, nonatomic) IBOutlet UIButton *yesButton;
@property (weak, nonatomic) IBOutlet UIButton *noButton;
@property (nonatomic) BOOL isVisited;

@end

@implementation AddRestaurantTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

	self.isVisited = YES;

	// 設定鍵盤上 return 上顯示的字串
	self.nameTextField.returnKeyType = UIReturnKeyNext;
	self.typeTextField.returnKeyType = UIReturnKeyNext;
	self.locationTextField.returnKeyType = UIReturnKeyDone;

	self.nameTextField.delegate = self;
	self.typeTextField.delegate = self;
	self.locationTextField.delegate = self;

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - Table view

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.row == 0) {
		// 確認是否有權限 https://medium.com/@apppeterpan/ios-10%E5%AD%98%E5%8F%96%E4%BD%BF%E7%94%A8%E8%80%85%E7%A7%81%E5%AF%86%E8%B3%87%E6%96%99%E9%83%BD%E8%A6%81%E5%8A%A0%E4%B8%8Ausage-description-a01715e56491
		if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
			UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
			imagePicker.delegate = self;
			imagePicker.allowsEditing = YES;
			imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;

			[self presentViewController:imagePicker animated:YES completion:nil];
		}
	}
	else if (indexPath.row >= 1 && indexPath.row <= 3) {
		UITextField *textField = (UITextField *)[self.view viewWithTag:indexPath.row];
		[textField becomeFirstResponder];
	}

	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
	self.imageView.image = info[UIImagePickerControllerOriginalImage];
	self.imageView.contentMode = UIViewContentModeScaleAspectFill;
	self.imageView.clipsToBounds = YES;

	NSLayoutConstraint *leadingConstraint = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.imageView.superview attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
	leadingConstraint.active = YES;

	NSLayoutConstraint *trailingConstraint = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.imageView.superview attribute:NSLayoutAttributeTrailing multiplier:1 constant:0];
	trailingConstraint.active = YES;

	NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.imageView.superview attribute:NSLayoutAttributeTop multiplier:1 constant:0];
	topConstraint.active = YES;

	NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:self.imageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.imageView.superview attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
	bottomConstraint.active = YES;

	// VFL
//	self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
//
//	NSDictionary *viewDictionary = @{@"imageView": self.imageView};
//
//	NSArray *hConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[imageView]-0-|" options:0 metrics:nil views:viewDictionary];
//	NSArray *vConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[imageView]-0-|" options:0 metrics:nil views:viewDictionary];
//	[self.view addConstraints:hConstraint];
//	[self.view addConstraints:vConstraint];

	[self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - IBAction

- (IBAction)saveRestaurant:(UIBarButtonItem *)sender {
	[self.view endEditing:YES]; // 關閉鍵盤

	if ([self.nameTextField.text isEqualToString:@""] || [self.typeTextField.text isEqualToString:@""] || [self.locationTextField.text isEqualToString:@""]) {
		UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Oops" message:@"One of the field is blank" preferredStyle:UIAlertControllerStyleAlert];
		[alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
		[self presentViewController:alertController animated:YES completion:nil];

		return;
	}

	self.restaurant = [[Restaurant alloc] initWithName:self.nameTextField.text type:self.typeTextField.text location:self.locationTextField.text rating:nil image:self.imageView.image isVisited:self.isVisited];
	[self performSegueWithIdentifier:@"unwindToHomeScreen" sender:self];
}

- (IBAction)toggleBeenHereButton:(UIButton *)sender {
	[self.view endEditing:YES]; // 關閉鍵盤

	if (sender == self.yesButton) {
		self.isVisited = YES;
		self.yesButton.backgroundColor = [UIColor redColor];
		self.noButton.backgroundColor = [UIColor lightGrayColor];
	}
	else if (sender == self.noButton) {
		self.isVisited = NO;
		self.yesButton.backgroundColor = [UIColor lightGrayColor];
		self.noButton.backgroundColor = [UIColor redColor];
	}
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	if (textField.returnKeyType == UIReturnKeyNext) {
		UITextField *nextTextField = (UITextField *)[self.view viewWithTag:textField.tag + 1];
		[nextTextField becomeFirstResponder];
	}
	else if (textField.returnKeyType == UIReturnKeyDone) {
		[textField resignFirstResponder];
	}

	return YES;
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
