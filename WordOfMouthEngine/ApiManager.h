//
//  ApiManager.h
//  WordOfMotuhEngine
//
//  Created by Bijit Halder on 11/9/13.
//  Copyright (c) 2013 Bijit Halder. All rights reserved.
//

#import "AFHTTPSessionManager.h"
#import "ApiUser.h"

#define kAMBaseURL    @"http://localhost:3000/"
#define kAMApiURL    @"api/v0/"

@interface ApiManager : AFHTTPSessionManager{
    
}

#pragma mark -  Singleton method
+ (ApiManager *) sharedApiManager;

#pragma mark -  HTTP CURD methods

#pragma mark -  Utility Methods
+ (NSString *)getStringForPath:(NSString *)pathString;
+ (ApiUser *)currentUser;
+ (BOOL)isUserLoggedIn;
- (void)setCurrentUser;

@end
