//
//  MapViewController.m
//  FoodPin
//
//  Created by MarkChang on 2017/3/28.
//  Copyright © 2017年 MarkChang. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>

@interface MapViewController () <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];

	self.title = self.restaurant.name;
	self.mapView.delegate = self;
	self.mapView.showsCompass = YES; // 顯示指南針
	self.mapView.showsScale = YES; // 顯示比例
	self.mapView.showsTraffic = YES; // 顯示交通流量

	CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
	[geoCoder geocodeAddressString:self.restaurant.location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
		if (error != nil) {
			NSLog(@"Error: %@", error.localizedDescription);
			return;
		}

		if (placemarks != nil) {
			// 取得第一個座標
			CLPlacemark *placemark = placemarks[0];

			// 加上標記
			MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
			annotation.title = self.restaurant.name;
			annotation.subtitle = self.restaurant.type;

			if (placemark.location != nil) {
				annotation.coordinate = placemark.location.coordinate;
				[self.mapView showAnnotations:@[annotation] animated:YES];
				[self.mapView selectAnnotation:annotation animated:YES];
			}
		}
	}];
}

#pragma mark - MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
	NSString *identifier = @"MyPin";

	if (self.mapView.userLocation == annotation) {
		return nil;
	}

	MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
	if (annotationView == nil) {
		annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
		annotationView.canShowCallout = YES;
	}

	// 加上圖片
	UIImageView *leftIconView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 53.0, 53.0)];
	leftIconView.image = self.restaurant.image;
	annotationView.leftCalloutAccessoryView = leftIconView;

	annotationView.pinTintColor = [UIColor orangeColor]; // 自訂大頭針顏色

	return annotationView;
}

@end
