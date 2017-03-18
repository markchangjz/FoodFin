//
//  RestaurantDetailViewController.m
//  FoodPin
//
//  Created by MarkChang on 2017/3/18.
//  Copyright © 2017年 MarkChang. All rights reserved.
//

#import "RestaurantDetailViewController.h"

@interface RestaurantDetailViewController ()

@end

@implementation RestaurantDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	self.restaurantImageView.image = [UIImage imageNamed:self.restaurantImage];
	self.restaurantImageView.clipsToBounds = YES; // 圖片太大張，避免返回上一頁動畫 lag
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
