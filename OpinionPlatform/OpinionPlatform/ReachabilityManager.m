//
//  ReachabilityManager.m
//  FBStatusUpdate
//
//  Created by Bijit Halder on 3/27/12.
//  Copyright (c) 2012 Indriam Inc. All rights reserved.
//

#import "ReachabilityManager.h"
#import "Reachability.h"
#import "CommonUtility.h"

@implementation ReachabilityManager



#pragma mark -  Network Reachability Methods
+(BOOL)isConntectedToInternet {
    return ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] != NotReachable);
}
+(BOOL)isConntectedToInternetShowDefaultAlarmWithText:(NSString *)text {

    if([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == NotReachable) {
        // show alaram
        [CommonUtility displayAlertWithTitle:@"No Internet Connection"
         message:(text==nil) ? @"Please try again later.":text
         delegate:nil];

        return NO;
    }

    return YES;
}

@end
