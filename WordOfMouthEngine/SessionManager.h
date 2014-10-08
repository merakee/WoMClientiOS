////
////  SessionManager.h
////  WordOfMouthEngine
////
////  Created by Bijit Halder on 2/13/14.
////  Copyright (c) 2014 Bijit Halder. All rights reserved.
////
//
//#import <Foundation/Foundation.h>
//#import "UserInfo.h"
//
//static NSString * kAppErrorDomainSession =  @"SessionErrorDomain";
//
//typedef enum {
//    kSessionErrorNone=0,
//    kSessionErrorInvalidSignIn,
//    kSessionErrorInvalidId,
//    kSessionErrorInvalidPassword,
//} kSessionErrorCode;
//
//
//@protocol SessionManagerSignInDelegate <NSObject>
//@required
//- (void)signedInFailedWithErrors:(NSError *)error;
//- (void)signedInSuccessfullyWithUser:(UserInfo *)user;
//@optional
//@end
//
//@protocol SessionManagerSignOutDelegate <NSObject>
//@required
//- (void)signedOutSuccessfully;
//@optional
//
//
//@end
//
//
//@interface SessionManager : NSObject{
//    
//}
//
//@property (assign, nonatomic) id <SessionManagerSignInDelegate>  delegateSignIn;
//@property (assign, nonatomic) id <SessionManagerSignOutDelegate>  delegateSignOut;
//
//@property UserInfo      *currentUser;
//
//
//#pragma mark -  Singleton method
//+ (SessionManager *) sharedSessionManager;
//
//#pragma mark - User Session methods
//+ (UserInfo *)currentUser;
//- (BOOL) isUsersignedIn;
//- (void)SignInUserWithId:(NSString *)userid andPassword:(NSString *)password;
//- (void)SignInAsGuest;
//- (void)signOut;
//
//@end
