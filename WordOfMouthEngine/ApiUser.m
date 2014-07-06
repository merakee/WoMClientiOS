//
//  ApiUser.m
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 11/10/13.
//  Copyright (c) 2013 Bijit Halder. All rights reserved.
//

#import "ApiUser.h"
#import "LocalMacros.h"

@implementation ApiUser

@synthesize userTypeId;
@synthesize email;
@synthesize authenticationToken;
@synthesize signedIn;

#pragma mark - Init Methods
- (ApiUser *)initWithTypeId:(NSNumber *)userTypeId_
                      email:(NSString *)email_
        authenticationToken:(NSString *)authenticationToken_
                   signedIn:(NSNumber *)signedIn_{
    if (self = [super init]) {
        // initialization code
        self.userTypeId = userTypeId_;
        self.email=email_;
        self.authenticationToken = authenticationToken_;
        self.signedIn=signedIn_;
    }
    return self;
}

#pragma mark - Utility Methods
+(void)printApiUser:(ApiUser  *)user{
    DBLog(@"Api User:--------------------");
    DBLog(@"User_Type_Id: %d",[user.userTypeId intValue]);
    DBLog(@"Email: %@",user.email);
    DBLog(@"Authentication token: %@",user.authenticationToken);
    DBLog(@"signed in: %d",[user.signedIn boolValue]);
}

@end
