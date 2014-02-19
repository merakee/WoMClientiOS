//
//  UserInfo.m
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 2/15/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import "UserInfo.h"
#import "LocalMacros.h"

@implementation UserInfo

@synthesize userId;
@synthesize userName;
@synthesize userEmail;

#pragma mark - Init Methods
- (id)initWithId:(NSInteger)userId_
            name:(NSString *)userName_
           email:(NSString *)userEmail_{
    if(self = [super init]) {
        // initialization code
        self.userId = userId_;
        self.userName = userName_;
        self.userEmail = userEmail_;

    }
    return self;
}

#pragma mark - Utility Methods
+(void)printRewardInfo:(UserInfo *)ui {
    DBLog(@"User info:--------------------");
    DBLog(@"Id: %d",(int)ui.userId);
    DBLog(@"Name: %@",ui.userName);
    DBLog(@"Email: %@",ui.userEmail);
}

@end
