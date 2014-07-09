////
////  SessionManager.m
////  WordOfMouthEngine
////
////  Created by Bijit Halder on 2/13/14.
////  Copyright (c) 2014 Bijit Halder. All rights reserved.
////
//
//#import "SessionManager.h"
//#import "CommonUtility.h"
//
//
//@implementation SessionManager
//
//@synthesize delegateSignIn;
//@synthesize delegateSignOut;
//@synthesize currentUser;
//
//static SessionManager *sharedSessionManager=nil;
//
//#pragma mark - Init Methods
//- (id)init{
//    if(self = [super init]) {
//        // initialization code
//        [self setAllDefaults];
//        
//    }
//    return self;
//}
//
//- (void)setAllDefaults {
//    self.currentUser = nil;
//    self.delegateSignIn=nil;
//    self.delegateSignOut=nil;
//}
//
//
//#pragma mark -  Singleton method
//+ (SessionManager *) sharedSessionManager {
//    if (sharedSessionManager != nil) {
//        return sharedSessionManager;
//    }
//    
//    sharedSessionManager= [[SessionManager alloc] init];
//    return sharedSessionManager;
//}
//
//#pragma mark - User Methods
//- (UserInfo *)defaultUser{
//    return [ [UserInfo alloc]
//            initWithId: 0
//            name: @"Anonymous"
//            email:@"onone@online.com"];
//    
//}
//
//#pragma mark - User Session methods
//+ (UserInfo *)currentUser{
//    return [SessionManager sharedSessionManager].currentUser;
//}
//- (BOOL) isUsersignedIn{
//    return !(self.currentUser == nil);
//}
//- (void)SignInAsGuest{
//    self.currentUser =[self defaultUser];
//    [self SignInUserWithId:currentUser.userName andPassword:nil];
//}
//- (void)SignInUserWithId:(NSString *)userid andPassword:(NSString *)password{
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
//    
//}
//- (void)signOut{
//    // reset current user
//    self.currentUser = nil;
//    
//    // notify delegate
//    if ([self.delegateSignOut respondsToSelector:@selector(signedOutSuccessfully)]) {
//        [self.delegateSignOut signedOutSuccessfully];
//    }
//}
//
//
//#pragma mark - User Credential validation methods
//- (BOOL)isValidUserId:(NSString *)userid andPassword:(NSString *)password{
//    
//    // check id
//    if(![@[@"Ahmet",@"User1",@"User2",@"User3",@"Anonymous"] containsObject:userid]){
//        return NO;
//    }
//    // check pass word
//    if (!([userid isEqualToString:@"Anonymous"]||[password isEqualToString:@"1234"])){
//        return NO;
//    }
//    
//    return YES;
//}
//
//
//
//@end
