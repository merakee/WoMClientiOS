//
//  ApiManager.m
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 11/9/13.
//  Copyright (c) 2013 Bijit Halder. All rights reserved.
//

#import "ApiManager.h"

@implementation ApiManager

static ApiManager *apiManager=nil;
static ApiUser *currentUser=nil;

#pragma mark -  Init Methods
- (id)init {
    NSURL *baseURL = [NSURL URLWithString:kAMApiURL relativeToURL:[NSURL URLWithString:kAMBaseURL]];

    if (self = [super initWithBaseURL:baseURL]) {
        // set up ApiSession
        
        // request and response serialier
        // defaults  AFHTTPSerializer (Req) and AFJSONResponseSerializer (Res)
        
        // rechability monitoring
        [apiManager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            switch (status) {
                case AFNetworkReachabilityStatusReachableViaWWAN:
                case AFNetworkReachabilityStatusReachableViaWiFi:
                    //[operationQueue setSuspended:NO];
                    break;
                case AFNetworkReachabilityStatusNotReachable:
                default:
                    //[operationQueue setSuspended:YES];
                    break;
            }
        }];
        
        // set current user
        [self setCurrentUser];
    }
    return self;
}

#pragma mark -  Singleton method
+ (ApiManager *) sharedApiManager {
    if (apiManager == nil) {
        apiManager= [[ApiManager alloc] init];
    }
    
    return apiManager;
}


#pragma mark -   HTTP CURD methods

#pragma mark -  Utility Methods
+ (NSString *)getStringForPath:(NSString *)pathString{
    return [[kAMBaseURL stringByAppendingPathComponent:kAMApiURL] stringByAppendingPathComponent:pathString];
}

+ (ApiUser *)currentUser{
    return currentUser;
}

+ (BOOL)isUserLoggedIn{
    return NO;
}

- (void)setCurrentUser{
    if(currentUser == nil){
        currentUser = [[ApiUser alloc] initWithId:0
                                             name:@""
                                            email:@""];
    }
    currentUser.userId=0;
    currentUser.name=@"";
    currentUser.email=@"";
}
@end
