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

+(LocationViewController *) sharedLocation
{
    static LocationViewController *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (id)init {
    self = [super init];
    if(self != nil) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers;
        
        // Distance filter if Standard Location, not Significant Location
 //       self.locationManager.distanceFilter = minimumDistance;
        self.locationManager.delegate = self;
    }
    return self;
}

#pragma mark - Location Manager

- (void)startSignificantUpdateLocation
{

    [[LocationViewController sharedLocation] requestWhenInUseAuthorization];
    
    // Create a locationManager if there isn't one already made
    if (!_locationManager)
    {
      //  [LocationViewController sharedLocation];
        [[LocationViewController sharedLocation] addObserver:self forKeyPath:@"currentLocation" options:NSKeyValueObservingOptionNew context:nil];
    }
}

- (void)stopSignificantUpdatingLocation
{
    [_locationManager stopMonitoringSignificantLocationChanges];
    
}
- (void)requestWhenInUseAuthorization
{
    // Set notification to see if user authorization. Need in iOS 8
    // Add to plist NSLocationWhenInUseUsageDescription/ NSLocationAlwaysUsageDescription
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
}
- (void)getLocation
{
    [[LocationViewController sharedLocation] requestWhenInUseAuthorization];
    
 //   if ([self.locationManager requestWhenInUseAuthorization])
    {
        [_locationManager startMonitoringSignificantLocationChanges];
    }
    // Pause location manager when location unlikely to change
    _locationManager.pausesLocationUpdatesAutomatically = YES;

    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object  change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualToString:@"currentLocation"]) {
        // do some stuff
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
  //  CLLocation *location = locations.lastObject;
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
   // What happens when failed to get location
    
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
