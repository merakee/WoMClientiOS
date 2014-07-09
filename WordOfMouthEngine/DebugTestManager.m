//
//  DebugTestManager.m
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 11/9/13.
//  Copyright (c) 2013 Bijit Halder. All rights reserved.
//

#import "DebugTestManager.h"


#import "ApiManager.h"
#import "LocalContentDatabase.h"
#import "UserInfoDatabase.h"
#import "ApiManager.h"

@implementation DebugTestManager


#pragma mark -  Public method
+ (void)runDebugTests{
    //[self testApiManager];
    //[self testLocalContentDatabase];
    //[self testUserInfoDatabase];
    [self testApiManager];
}


#pragma mark -  individual test methods
+ (void)testUserInfoDatabase{
    [UserInfoDatabase test];
}

+ (void)testApiManager{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void){
        //code to be executed on the main queue after delay
        [ApiManager test];
    });
}

+ (void)testLocalContentDatabase{
    [LocalContentDatabase test];
}
@end
