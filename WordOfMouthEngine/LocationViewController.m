//
//  LocationView.m
//  WordOfMouthEngine
//
//  Created by Kevin Moy on 10/3/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import "LocationViewController.h"

@interface LocationViewController () <CLLocationManagerDelegate>

//@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation LocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self startSignificantUpdateLocation];
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getLocation
{
    [_locationManager startMonitoringSignificantLocationChanges];
}

- (void)startSignificantUpdateLocation
{
    // Create a locationManager with a desired accuracy and
    if (!_locationManager)
    {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers;
        
        _locationManager.distanceFilter = minimumDistance;
        

    }
    // Set notification to see if user authorization. Need in iOS 8
    // Add to plist NSLocationWhenInUseUsageDescription/ NSLocationAlwaysUsageDescription
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    // Pause location manager when location unlikely to change
    _locationManager.pausesLocationUpdatesAutomatically = YES;

    [_locationManager startMonitoringSignificantLocationChanges];
}

- (void)stopSignificantUpdatingLocation
{
    [_locationManager stopMonitoringSignificantLocationChanges];

}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = locations.lastObject;
    CLLocationDegrees currentLatitude = location.coordinate.latitude;
    CLLocationDegrees currentLongitude = location.coordinate.longitude;
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
   // What happens when failed to get location
    
}
//+ (CLAuthorizationStatus)authorizationStatus
//{
//    
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
