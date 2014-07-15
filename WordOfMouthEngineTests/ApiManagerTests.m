//
//  ApiManagerTests.m
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 11/18/13.
//  Copyright (c) 2013 Bijit Halder. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ApiManager.h"
// Set the flag for a block completion handler
#define StartAsyncBlock() __block BOOL waitingForAsyncBlock = YES

// Set the flag to stop the loop
#define StopAsyncBlock() waitingForAsyncBlock = NO

// Wait and loop until flag is set
#define WaitUntilAsyncBlockCompletes() WaitWhile(waitingForAsyncBlock)

// Macro - Wait for condition to be NO/false in blocks and asynchronous calls
#define WaitWhile(condition)\
do {\
while(condition) {\
[[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];\
}\
} while(0)

@interface ApiManagerTests : XCTestCase{
    ApiManager *apiManager;
    ApiUser *user, *auser;
}

@end

@implementation ApiManagerTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    user= [[ApiUser alloc] initWithTypeId:[NSNumber numberWithInt:kAPIUserTypeWom]
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

- (void)testApiManagerBasics{
    XCTAssertNotNil(apiManager,@"Shared manger should not be nil");
    XCTAssertEqualObjects(apiManager, [ApiManager sharedApiManager],@"Must be singleton");
}

- (void)testApiManagerSignUpAnonymousProcess{
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
- (void)testApiManagerSignUpProcess{
    XCTAssertFalse([apiManager isUserSignedIn], @"User should not be signed in");
    
    StartAsyncBlock();
    [apiManager signUpUserWithUserTypeId:user.userTypeId.integerValue
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
                                     NSLog(@"Error: %@",error);
                                     StopAsyncBlock();
                                 }];
    
    // Run the Wait loop
    WaitUntilAsyncBlockCompletes();
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
    [apiManager signInUserWithUserTypeId:user.userTypeId.integerValue
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

- (void)testApiManagerSignOutUser{
    XCTAssertTrue([apiManager isUserSignedIn], @"User should be signed in");
    
    //  user
    StartAsyncBlock();
    
    [apiManager
     signOutUserSuccess:^(){
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
}


@end
