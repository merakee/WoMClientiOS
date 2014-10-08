//
//  LocationView.h
//  WordOfMouthEngine
//
//  Created by Kevin Moy on 10/3/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

//extern const CLLocationAccuracy kCLLocationAccuracyBestForNavigation;
//extern const CLLocationAccuracy kCLLocationAccuracyBest;
//extern const CLLocationAccuracy kCLLocationAccuracyNearestTenMeters;
//extern const CLLocationAccuracy kCLLocationAccuracyHundredMeters;
//extern const CLLocationAccuracy kCLLocationAccuracyKilometer;
//extern const CLLocationAccuracy kCLLocationAccuracyThreeKilometers;

//locationAccuracy = kCLLocationAccuracyThreeKilometers;
static const int minimumDistance = 1000;

@interface LocationViewController : UIViewController <CLLocationManagerDelegate>
@property (assign, nonatomic) CLLocationDistance *distanceFilter;
@property (assign, nonatomic) CLLocationAccuracy *desiredAccuracy;
@property (nonatomic, strong) CLLocationManager *locationManager;

@end
