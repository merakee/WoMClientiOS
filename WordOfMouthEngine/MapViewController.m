//
//  ViewController.m
//  mapView
//
//  Created by Kevin Moy on 10/9/14.
//  Copyright (c) 2014 Kevin Moy. All rights reserved.
//

#import "MapViewController.h"
#import "CommonUtility.h"
#import "AppUIManager.h"


@interface MapViewController ()

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Custom code
    
    // Check to see user allowed Authorization

    [self setView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)goBack:(id)sender {
    // go back
    [self.navigationController popViewControllerAnimated:NO];
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
    
    float MapW = [CommonUtility getScreenWidth];
    float MapH = [CommonUtility getScreenHeight];
   

    MKMapView *mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, MapW, MapH)];
    
    mapView.mapType = MKMapTypeStandard;
    
     mapView.delegate = self;
    //  [MKMapView setVisibleMapRect:mapView];
    
    
    // Zoom enabled
      mapView.zoomEnabled = YES;
       mapView.scrollEnabled = YES;
    
    
    // To track user information, use addObserver
   // [[LocationViewController sharedLocation] addObserver:self forKeyPath:@"currentLocation" options:NSKeyValueObservingOptionNew context:nil];
  
    mapView.showsUserLocation = YES;
    
    // Get user location and show Authorization message
    [[LocationViewController sharedLocation] getLocation];
    
   
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
    
    // Add MapView object as a subview of a view
    [self.view addSubview:mapView];
   //  NSLog(@"hello");
    
    // Navigation Bar for Map
     UINavigationBar *navbar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, MapW, 50)];
    
    [self.view addSubview:navbar];
    
    //    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelEdit:)];
    
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(goBack:)];
    
    UINavigationItem *navItem = [[UINavigationItem alloc] initWithTitle:nil];
    navItem.leftBarButtonItem = cancelItem;
    
    [navbar pushNavigationItem:navItem animated:NO];

}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    // Get coordinates of user
    CLLocationCoordinate2D mylocation = [userLocation coordinate];
    
    // Define a zoom region
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(mylocation, zoomLatitudeMeters, zoomLongtitudeMeters);
    
    // Show location
    [mapView setRegion:region animated:YES];
    
}

//-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
//{
//    
//}
- (void)setNavigationBar {
    
    NSLog(@"nav bar");
//    mapViewController =[[MapViewController alloc] init];
//    
//    mapViewNavigationController = [[UINavigationController alloc]
//                                   initWithRootViewController:mapViewController];
//    
//    mapViewNavigationController.tabBarItem = [[UITabBarItem alloc]
//                                              initWithTitle:@"Map"
//                                              image:nil//[UIImage imageNamed:kAUCCoreFunctionTabbarImageCompose]
//                                              tag:0];//kCFVTabbarIndexCompose];
//    
//    [AppUIManager setNavbar:mapViewController.navigationController.navigationBar];
//    self.navigationItem.titleView = [AppUIManager getAppLogoViewForNavTitle];
//  
//    self.navigationItem.leftBarButtonItem =  [[UIBarButtonItem alloc]
//                                              initWithBarButtonSystemItem:UIBarButtonSystemItemStop
//                                              target:self
//                                              action:@selector(goBack:)];
}

@end
