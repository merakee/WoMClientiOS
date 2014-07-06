//
//  ApiUserManager.h
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 7/5/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ApiUser.h"

@interface ApiUserManager : NSObject{
    
}

@property ApiUser      *currentUser;

#pragma mark - User Session methods
- (BOOL) isUsersignedIn;
- (void)SignInUserWithId:(NSString *)userid andPassword:(NSString *)password;
- (void)SignInAsGuest;
- (void)signOut;

#pragma mark -  Utility Methods


@end
