//
//  ApiUserManager.m
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 7/5/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import "ApiUserManager.h"
#import "CommonUtility.h"

@implementation ApiUserManager
@synthesize currentUser;

#pragma mark - init
- (id)init{
    if(self = [super init]) {
        // initialization code
        [self setAllDefaults];
        
    }
    return self;
}

- (void)setAllDefaults{
    [self setCurrentUser];
    
}

- (void)setCurrentUser{
    self.currentUser = [[ApiUser alloc] init];
    self.currentUser = [[[UserInfoDatabase alloc] init] getUser];
}
#pragma mark - Utility Methods
- (BOOL) isUserSignedIn{
    if(self.currentUser==nil){
        [self setCurrentUser];
    }
    
    return (self.currentUser.signedIn && self.currentUser.signedIn.boolValue == TRUE) &&
    (![CommonUtility isEmptyString:self.currentUser.email]) &&
    (![CommonUtility isEmptyString:self.currentUser.authenticationToken]);
}

- (BOOL) signInAnonymousUser{
    ApiUser *user =[[[UserInfoDatabase alloc] init] getAnonymousUser];
    if(user){
        self.currentUser=user;
        return true;
    }
    return false;
}

- (BOOL) signInUser:(ApiUser *)user{
    if([[[UserInfoDatabase alloc] init] saveUserInfo:user]){
        self.currentUser=user;
        return true;
    }
    return false;
}

- (BOOL)signOutUser{
    if(self.currentUser && self.currentUser.userTypeId.integerValue==1){
        return false;
    }
    if([[[UserInfoDatabase alloc] init] deleteUserInfo]){
        self.currentUser=nil;
        return true;
    }
    return false;
}
- (void) resetAnonymousUser{
    if(self.currentUser.userTypeId.integerValue==1){
        self.currentUser=nil;
    }
}

#pragma mark -  Utility Methods
- (BOOL)signInAndSaveUserInfo:(ApiUser*)user{
    BOOL didSave = false;
    if(user.userTypeId.intValue ==1){
        didSave = [[[UserInfoDatabase alloc] init] saveAnonymousUserInfo:user];
    }
    else if (user.userTypeId.intValue ==2){
        didSave = [[[UserInfoDatabase alloc] init] saveUserInfo:user];
    }
    
    self.currentUser=user;
    return didSave;
}
@end
