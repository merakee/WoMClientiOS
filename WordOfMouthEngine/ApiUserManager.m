//
//  ApiUserManager.m
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 7/5/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import "ApiUserManager.h"

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
    if(self.currentUser == nil){
        // set as anonymous user
        self.currentUser = [[ApiUser alloc] initWithTypeId:@1
                                                     email:@""
                                       authenticationToken:@""
                                                  signedIn:@NO];
    }
}

#pragma mark - Utility Methods
- (BOOL) isUsersignedIn{
    return !(self.currentUser == nil);
}
- (void)SignInAsGuest{
    //    self.currentUser =[self defaultUser];
    //    [self SignInUserWithId:currentUser.userName andPassword:nil];
}
- (void)SignInUserWithId:(NSString *)userid andPassword:(NSString *)password{
    //    // reset current user
    //    self.currentUser = nil;
    //
    //
    //    // check user credential
    //    if([self  isValidUserId:userid andPassword:password]){
    //        self.currentUser = [[UserInfo alloc] init];
    //        self.currentUser.userName = userid;
    //        // notify delegate
    //        if ([self.delegateSignIn respondsToSelector:@selector(signedInSuccessfullyWithUser:)]) {
    //            [self.delegateSignIn signedInSuccessfullyWithUser:self.currentUser];
    //        }
    //    }
    //    else{
    //        // log in error
    //        NSError *error =[CommonUtility getErrorWithDomain:kAppErrorDomainSession
    //                                                     code:kSessionErrorInvalidSignIn
    //                                              description:@"Invalid id/password"
    //                                                   reason:@"User id password not found"
    //                                               suggestion:@"Please entry valid id and password"];
    //        // notify delegate
    //        if ([self.delegateSignIn respondsToSelector:@selector(signedInFailedWithErrors:)]) {
    //            [self.delegateSignIn signedInFailedWithErrors:error];
    //        }
    //    }
    
}
- (void)signOut{
    //    // reset current user
    //    self.currentUser = nil;
    //
    //    // notify delegate
    //    if ([self.delegateSignOut respondsToSelector:@selector(signedOutSuccessfully)]) {
    //        [self.delegateSignOut signedOutSuccessfully];
    //    }
}


@end
