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

@implementation DebugTestManager


#pragma mark -  Public method
+ (void)runDebugTests{
    //[self testApiManager];
    //[self testLocalContentDatabase];
}


#pragma mark -  individual test methods
+ (void)testApiManager{
    ApiManager  *apiManager=[ApiManager sharedApiManager];
    
    NSLog(@"%@",[ApiManager getStringForPath:@"rumors/"]);
    // get list of rumors
    [apiManager GET:[ApiManager getStringForPath:@"rumors/"]
         parameters:nil
            success:^(NSURLSessionDataTask *task, id responseObject){
                // NSLog(@"%@",responseObject);
                //NSLog(@"%@",[responseObject class]);
                for(NSDictionary *rumor in responseObject){
                    NSLog(@"%@",rumor[@"text"]);
                }
            }
            failure:^(NSURLSessionDataTask *task, NSError *error){
                NSLog(@"%@",error);
            }];
    
}

+ (void)testLocalContentDatabase{
    [LocalContentDatabase test];
}
@end
