//
//  ApiUserResponse.m
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 11/10/13.
//  Copyright (c) 2013 Bijit Halder. All rights reserved.
//

#import "ApiUserResponse.h"
#import "LocalMacros.h"

@implementation ApiUserResponse

@synthesize userId;
@synthesize contentId;
@synthesize userResponse;

#pragma mark - Init Methods
- (ApiUserResponse *)initWithUserId:(NSNumber *)userId_
                          contentId:(NSNumber *)contentId_
                       userResponse:(NSNumber *)userResponse_{
    if (self = [super init]) {
        // initialization code
        self.userId = userId_;
        self.contentId = contentId_;
        self.userResponse = userResponse_;
    }
    return self;
}

#pragma mark - Utility Methods
+(BOOL)isValidUserResponse:(ApiUserResponse *)userResponse{
    return (userResponse.userId&&(userResponse.userId.intValue>0)
            &&userResponse.contentId&&(userResponse.contentId.intValue>0) );
}
+(void)printApiUserResponse:(ApiUserResponse  *)userResponse{
    NSLog(@"Api User Response:--------------------");
    NSLog(@"User Id: %d",[userResponse.userId intValue]);
    NSLog(@"Content Id: %d",[userResponse.contentId intValue]);
    NSLog(@"User Response: %d",[userResponse.userResponse intValue]);
}

@end
