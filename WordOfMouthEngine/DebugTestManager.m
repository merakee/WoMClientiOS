//
//  DebugTestManager.m
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 11/9/13.
//  Copyright (c) 2013 Bijit Halder. All rights reserved.
//

#import "DebugTestManager.h"


#import "ApiManager.h"
#import "ApiContentDatabase.h"
#import "ApiUserDatabase.h"
#import "ApiManager.h"

@implementation DebugTestManager


#pragma mark -  Public method
+ (void)runDebugTests{
    //[self testApiManager];
    //[self testLocalContentDatabase];
    //[self testApiUserDatabase];
    //[self testApiManager];
    //[self showAllFonts];
}


#pragma mark -  individual test methods
+ (void)testApiUserDatabase{
    [ApiUserDatabase test];
}

+ (void)testApiManager{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void){
        //code to be executed on the main queue after delay
        [ApiManager test];
    });
}

+ (void)testLocalContentDatabase{
    //[ApiContentDatabase test];
}

+ (void)showAllFonts{
    for (NSString* family in [UIFont familyNames])
        {
        NSLog(@"%@", family);
        
        for (NSString* name in [UIFont fontNamesForFamilyName: family])
            {
            NSLog(@"  %@", name);
            }
        }
}
@end
