//
//  SessionManager.m
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 2/13/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import "SessionManager.h"

@implementation SessionManager

@synthesize currentUser;


#pragma mark - Init Methods
- (id)init{
    if(self = [super init]) {
        // initialization code
        self.currentUser = [self setUser];
        
    }
    return self;
}

- (UserInfo *)setUser{
    if (false){
        
    }else{
        return [self defaultUser];
    }

}

- (UserInfo *)defaultUser{
    return [ [UserInfo alloc]
            initWithId: 0
            name: @"User Name"
            email:@"user@online.com"];
    
}


#pragma mark - User Session methods
+ (BOOL) isUserLoggedIn{
    return YES;
}
+ (UserInfo *) currentUser{
    return [[SessionManager alloc] init].currentUser;
}
@end
