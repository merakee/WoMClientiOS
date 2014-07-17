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

@synthesize userId;
@synthesize userTypeId;
@synthesize email;
@synthesize authenticationToken;
@synthesize signedIn;

#pragma mark - Init Methods
- (ApiUser *)initWithUserId:(NSNumber *)userId_
                 userTypeId:(NSNumber *)userTypeId_
                      email:(NSString *)email_
        authenticationToken:(NSString *)authenticationToken_
                   signedIn:(NSNumber *)signedIn_{
    if (self = [super init]) {
        // initialization code
        self.userId = userId_;
        self.userTypeId = userTypeId_;
        self.email=email_;
        self.authenticationToken = authenticationToken_;
        self.signedIn=signedIn_;
    }
    return self;
}

#pragma mark - Utility Methods
+(BOOL)isValidUser:(ApiUser *)user{
    return (user.userId&&(user.userId.intValue>0)
            &&user.userTypeId&&(user.userTypeId.intValue>=1)&&(user.userTypeId.intValue<=2)
            &&user.email&&user.authenticationToken);
}
+(void)printApiUser:(ApiUser  *)user{
    DBLog(@"Api User:--------------------");
    DBLog(@"User_Id: %d",[user.userId intValue]);
    DBLog(@"User_Type_Id: %d",[user.userTypeId intValue]);
    DBLog(@"Email: %@",user.email);
    DBLog(@"Authentication token: %@",user.authenticationToken);
    DBLog(@"signed in: %d",[user.signedIn boolValue]);
}

@end
