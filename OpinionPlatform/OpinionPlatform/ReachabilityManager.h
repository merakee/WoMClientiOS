//
//  ReachabilityManager.h
//  FBStatusUpdate
//
//  Created by Bijit Halder on 3/27/12.
//  Copyright (c) 2012 Indriam Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReachabilityManager : NSObject


#pragma mark -  Network Reachability Methods
+(BOOL)isConntectedToInternet;
+(BOOL)isConntectedToInternetShowDefaultAlarmWithText:(NSString *)text;

@end
