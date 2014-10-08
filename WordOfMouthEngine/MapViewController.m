//
//  MapViewController.m
//  WordOfMouthEngine
//
//  Created by Kevin Moy on 10/7/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import "MapViewController.h"


@interface MapViewController ()

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Custom code
    [self setView];
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

- (void)setView{
    MKMapView *mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    
    mapView.mapType = MKMapTypeStandard;
    
   // mapView.delegate = self;
    //  [MKMapView setVisibleMapRect:mapView];
    
    
    // Zoom enabled
    mapView.zoomEnabled = NO;
    mapView.scrollEnabled = YES;
    mapView.showsUserLocation = YES;
    
    // Add MapView object as a subview of a view
    [self.view addSubview:mapView];
    
    //    region = {
    //        center = {
    //            latitude = 0
    //            longitutde = 180;
    //        }
    //        span = {
    //            latitudeDelta = 115
    //            longitudeDelta = 115
    //        }
    //    }
//    [self.view setRegion:region];
//    [self.view setDelegate:self];

}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    // Get coordinates of user
    CLLocationCoordinate2D mylocation = [userLocation coordinate];
    
    // Define a zoom region
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(mylocation, 2500, 2500);
    
    // Show location
    [mapView setRegion:region animated:YES];

}


@end
