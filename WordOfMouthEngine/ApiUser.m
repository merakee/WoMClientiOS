//
//  ApiUser.m
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 11/10/13.
//  Copyright (c) 2013 Bijit Halder. All rights reserved.
//

#import "ApiUser.h"

@implementation ApiUser

@synthesize  userTypeId;
@synthesize  email;
@synthesize  authenticationToken;

#pragma mark - Init Methods
- (ApiUser *)initWithTypeId:(int)userTypeId_
                      email:(NSString *)email_
        authenticationToken:(NSString *)authenticationToken_ {
    if (self = [super init]) {
        // initialization code
        self.userTypeId = [NSNumber numberWithInt:userTypeId_];
        self.email=email_;
        self.authenticationToken = authenticationToken_;
    }
    return self;
}

#pragma mark - Utility methods

@end
