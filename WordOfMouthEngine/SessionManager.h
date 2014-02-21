//
//  SessionManager.h
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 2/13/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfo.h"

#define kAppErrorDomainSession  @"SessionErrorDomain"

typedef enum {
    kSessionErrorNone=0,
    kSessionErrorInvalidSignIn,
    kSessionErrorInvalidId,
    kSessionErrorInvalidPassword,
} kSessionErrorCode;


@protocol SessionManagerDelegate <NSObject>
@required

@optional
- (void)loggedInFailedWithErrors:(NSError *)error;
- (void)loggedInSuccessfullyWithUser:(UserInfo *)user;
- (void)loggedOutSuccessfully;
@end


@interface SessionManager : NSObject{
    
}

@property (assign, nonatomic) id <SessionManagerDelegate>  delegate;

@property UserInfo      *currentUser;


#pragma mark -  Singleton method
+ (SessionManager *) sharedSessionManager;

#pragma mark - User Session methods
+ (UserInfo *)currentUser;
- (BOOL) isUserLoggedIn;
- (void)SignInUserWithId:(NSString *)userid andPassword:(NSString *)password;
- (void)SignInAsGuest;
- (void)logOut;

@end
