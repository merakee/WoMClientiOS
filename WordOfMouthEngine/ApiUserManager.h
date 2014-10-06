//
//  ApiUserManager.h
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 7/5/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ApiUser.h"
#import "ApiUserDatabase.h"

@interface ApiUserManager : NSObject{
    
}

@property ApiUser      *currentUser;

#pragma mark - User Session methods
- (BOOL) isUserSignedIn;
- (BOOL) signInUser:(ApiUser *)user;
- (BOOL) signInAnonymousUser;
- (BOOL) signOutUser;
- (void) resetAnonymousUser;

#pragma mark -  Utility Methods
- (BOOL)signInAndSaveUserInfo:(ApiUser*)user;
@end
