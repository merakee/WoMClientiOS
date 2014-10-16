//
//  ViewController.h
//  mapView
//
//  Created by Kevin Moy on 10/9/14.
//  Copyright (c) 2014 Kevin Moy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "LocationViewController.h"

static const int zoomLatitudeMeters = 1500000;
static const int zoomLongtitudeMeters = 1500000;

@interface MapViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate>
{
MapViewController               *mapViewController;
UINavigationController          *mapViewNavigationController;
}
@end

