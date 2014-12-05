//
//  ApiManagerTests.m
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 11/18/13.
//  Copyright (c) 2013 Bijit Halder. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ApiManager.h"
#import "AsynTestHelper.h"
#import "ApiUserDatabase.h"
#import "PlaceHolderFactory.h"
#import "CommonUtility.h"

@interface ApiManagerUserSessionTests : XCTestCase{
    ApiManager *apiManager;
    ApiUser *user, *auser;
}

@end

@implementation ApiManagerUserSessionTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    user= [[ApiUser alloc] initWithUserId:nil
                               userTypeId:[NSNumber numberWithInt:kAPIUserTypeWom]
                                    email:@"user@example.com"
                      authenticationToken:nil
                                 signedIn:@YES];
    apiManager=[ApiManager sharedApiManager];
}

- (void)tearDown
{
    //apiManager.apiUserManager.currentUser=nil;
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

#pragma mark - Basic tests
- (void)testApiManagerBasics{
    XCTAssertNotNil(apiManager,@"Shared manger should not be nil");
    XCTAssertEqualObjects(apiManager, [ApiManager sharedApiManager],@"Must be singleton");
}

#pragma mark - User Sign up
- (void)testApiManagerSignUpAnonymousUserFirstTime{
    XCTAssertFalse([apiManager isUserSignedIn], @"User should not be signed in");
    
    // delete anonymous user
    XCTAssert([[[ApiUserDatabase alloc] init] deleteAnonymousUserInfo],@"Delete anonymous user info should be successful");
    
    StartAsyncBlock();
    [apiManager signUpUserWithUserTypeId:kAPIUserTypeAnonymous
                                   email:nil
                                password:nil
                    passwordConfirmation:nil
                                 success:^(){
                                     StopAsyncBlock();
                                 }
                                 failure:^(NSError *error){
                                     XCTFail(@"Must be sucessful");
                                     NSLog(@"Error: %@",error);
                                     StopAsyncBlock();
                                 }];
    
    // Run the Wait loop
    WaitUntilAsyncBlockCompletes();
    
    
    XCTAssert([apiManager isUserSignedIn], @"User should be signed in");
    XCTAssertEqual([apiManager currentUser].userTypeId.integerValue, kAPIUserTypeAnonymous, @"Current user must be an anomynous user");
    apiManager.apiUserManager.currentUser=nil;
}

- (void)testApiManagerSignUpAnonymousUser{
    XCTAssertFalse([apiManager isUserSignedIn], @"User should not be signed in");
    
    StartAsyncBlock();
    [apiManager signUpUserWithUserTypeId:kAPIUserTypeAnonymous
                                   email:nil
                                password:nil
                    passwordConfirmation:nil
                                 success:^(){
                                     StopAsyncBlock();
                                 }
                                 failure:^(NSError *error){
                                     XCTFail(@"Must be sucessful");
                                     NSLog(@"Error: %@",error);
                                     StopAsyncBlock();
                                 }];
    
    // Run the Wait loop
    WaitUntilAsyncBlockCompletes();
    
    
    XCTAssert([apiManager isUserSignedIn], @"User should be signed in");
    XCTAssertEqual([apiManager currentUser].userTypeId.integerValue, kAPIUserTypeAnonymous, @"Current user must be an anomynous user");
    apiManager.apiUserManager.currentUser=nil;
}


- (void)testApiManagerSignUpUserFirstTime{
    XCTAssertFalse([apiManager isUserSignedIn], @"User should not be signed in");
    
    user.email = [PlaceHolderFactory email];    
    StartAsyncBlock();
    [apiManager signUpUserWithUserTypeId:user.userTypeId.intValue
                                   email:user.email
                                password:@"password"
                    passwordConfirmation:@"password"
                                 success:^(){
                                     XCTAssert([apiManager isUserSignedIn], @"User should  be signed in");
                                     XCTAssertEqual([apiManager currentUser].userTypeId.integerValue, user.userTypeId.integerValue);
                                     XCTAssertEqualObjects([apiManager currentUser].email, user.email);
                                     StopAsyncBlock();
                                 }
                                 failure:^(NSError *error){
                                     XCTAssertEqualObjects(@"Email has already been taken",error.localizedFailureReason);
                                     XCTFail(@"It is just a warning. It is possible that the email generated in already in the database. Try running the test again to make sure.");
                                     //NSLog(@"Error: %@",error);
                                     StopAsyncBlock();
                                 }];
    
    // Run the Wait loop
    WaitUntilAsyncBlockCompletes();
    // delete user
    XCTAssert([[[ApiUserDatabase alloc] init] deleteUserInfo],@"Delete user info should be successful");
    apiManager.apiUserManager.currentUser=nil;
}

- (void)testApiManagerSignUpUser{
    // this is to make sure the consequent signup is auccessful
    XCTAssertFalse([apiManager isUserSignedIn], @"User should not be signed in");
    
    StartAsyncBlock();
    [apiManager signUpUserWithUserTypeId:user.userTypeId.intValue
                                   email:user.email
                                password:@"password"
                    passwordConfirmation:@"password"
                                 success:^(){
                                     XCTAssert([apiManager isUserSignedIn], @"User should  be signed in");
                                     XCTAssertEqual([apiManager currentUser].userTypeId.integerValue, user.userTypeId.integerValue);
                                     XCTAssertEqualObjects([apiManager currentUser].email, user.email);
                                     StopAsyncBlock();
                                 }
                                 failure:^(NSError *error){
                                     XCTAssertEqualObjects(@"Email has already been taken",error.localizedFailureReason);
                                     //NSLog(@"Error: %@",error);
                                     StopAsyncBlock();
                                 }];
    
    // Run the Wait loop
    WaitUntilAsyncBlockCompletes();
    // delete user
    XCTAssert([[[ApiUserDatabase alloc] init] deleteUserInfo],@"Delete user info should be successful");
    apiManager.apiUserManager.currentUser=nil;
    XCTAssertFalse([apiManager isUserSignedIn], @"User should not be signed in");
}

#pragma mark - User Sign In
- (void)testApiManagerSignInAnonymousUserFirstTime{
    XCTAssertFalse([apiManager isUserSignedIn], @"User should not be signed in");
    
    // delete anonymous user
    XCTAssert([[[ApiUserDatabase alloc] init] deleteAnonymousUserInfo],@"Delete anonymous user info should be successful");
    
    StartAsyncBlock();
    [apiManager signInUserWithUserTypeId:kAPIUserTypeAnonymous
                                   email:nil
                                password:nil
                                 success:^(){
                                     StopAsyncBlock();
                                 }
                                 failure:^(NSError *error){
                                     StopAsyncBlock();
                                     NSLog(@"Error: %@",error);
                                     XCTFail(@"Must be sucessful");
                                 }];
    
    // Run the Wait loop
    WaitUntilAsyncBlockCompletes();
    
    XCTAssert([apiManager isUserSignedIn], @"User should be signed in");
    XCTAssertEqual([apiManager currentUser].userTypeId.integerValue, kAPIUserTypeAnonymous);
    
    [apiManager performEnteredBackgroundActions];
    XCTAssertFalse([apiManager isUserSignedIn], @"User should not be signed in");
    apiManager.apiUserManager.currentUser=nil;
}

- (void)testApiManagerSignInAnonymousUser{
    XCTAssertFalse([apiManager isUserSignedIn], @"User should not be signed in");
    
    StartAsyncBlock();
    [apiManager signInUserWithUserTypeId:kAPIUserTypeAnonymous
                                   email:nil
                                password:nil
                                 success:^(){
                                     StopAsyncBlock();
                                 }
                                 failure:^(NSError *error){
                                     StopAsyncBlock();
                                     NSLog(@"Error: %@",error);
                                     XCTFail(@"Must be sucessful");
                                 }];
    
    // Run the Wait loop
    WaitUntilAsyncBlockCompletes();
    
    XCTAssert([apiManager isUserSignedIn], @"User should be signed in");
    XCTAssertEqual([apiManager currentUser].userTypeId.integerValue, kAPIUserTypeAnonymous);
    
    [apiManager performEnteredBackgroundActions];
    XCTAssertFalse([apiManager isUserSignedIn], @"User should not be signed in");
}

- (void)testApiManagerSignInUser{
    XCTAssertFalse([apiManager isUserSignedIn], @"User should not be signed in");
    //  user
    StartAsyncBlock();
    [apiManager signInUserWithUserTypeId:user.userTypeId.intValue
                                   email:user.email
                                password:@"password"
                                 success:^(){
                                     StopAsyncBlock();
                                 }
                                 failure:^(NSError *error){
                                     StopAsyncBlock();
                                     NSLog(@"Error: %@",error);
                                     XCTFail(@"Must be sucessful");
                                 }];
    
    // Run the Wait loop
    WaitUntilAsyncBlockCompletes();
    
    XCTAssert([apiManager isUserSignedIn], @"User should  be signed in");
    XCTAssertEqual([apiManager currentUser].userTypeId.integerValue, user.userTypeId.integerValue);
    XCTAssertEqualObjects([apiManager currentUser].email, user.email);
    
    [apiManager performEnteredBackgroundActions];
    XCTAssert([apiManager isUserSignedIn], @"User should be signed in");
    
    [apiManager performEnteredBackgroundActions];
    apiManager.apiUserManager.currentUser=nil;
    XCTAssert([apiManager isUserSignedIn], @"User should be signed in");
    
    [apiManager performEnteredBackgroundActions];
    XCTAssert([apiManager isUserSignedIn], @"User should be signed in");
}

#pragma mark - User Sign Out
- (void)testApiManagerSignOutUser{
    XCTAssert([apiManager isUserSignedIn], @"User should be signed in");
    
    //  user
    StartAsyncBlock();
    
    [apiManager     signOutUserSuccess:^(){
        StopAsyncBlock();
    }
                               failure:^(NSError *error){
                                   StopAsyncBlock();
                                   NSLog(@"Error: %@",error);
                                   XCTFail(@"Must be sucessful");
                               }];
    
    // Run the Wait loop
    WaitUntilAsyncBlockCompletes();
    XCTAssertFalse([apiManager isUserSignedIn], @"User should not be signed in");
    
    // delete all info
    [[[ApiUserDatabase alloc] init] deleteAnonymousUserInfo];
    [[[ApiUserDatabase alloc] init] deleteUserInfo];    
}


@end
