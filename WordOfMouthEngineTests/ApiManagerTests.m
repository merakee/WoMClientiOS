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
    UserInfoDatabase *uid;
}

@end

@implementation ApiManagerTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    user= [[ApiUser alloc] initWithTypeId:@2
                                    email:@"user@example.com"
                      authenticationToken:@"dfsr543jdfs9uhffaf4R"
                                 signedIn:@YES];
    auser= [[ApiUser alloc] initWithTypeId:@1
                                     email:@"huest@example.com"
                       authenticationToken:@"dfsr543jdfs9sfsdfaf4R"
                                  signedIn:@YES];
    uid = [[UserInfoDatabase  alloc] init];
    apiManager=[ApiManager sharedApiManager];
}

- (void)tearDown
{
    apiManager.apiUserManager.currentUser=nil;
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testApiManagerBasics{
    XCTAssertNotNil(apiManager,@"Shared manger should not be nil");
    XCTAssertEqualObjects(apiManager, [ApiManager sharedApiManager],@"Must be singleton");
}

- (void)testApiManagerSignupProcess{
    StartAsyncBlock();
    
    [apiManager signUpUserWithUserTypeId:kAPIUserTypeAnonymous
                                   email:nil
                                password:nil
                    passwordConfirmation:nil
                                 success:^(){
                                     StopAsyncBlock();
                                 }
                                 failure:^(NSError *error){
                                     StopAsyncBlock();
                                     XCTFail(@"Must be sucessful");
                                 }];
    
    // Run the Wait loop
    WaitUntilAsyncBlockCompletes();
    
}
- (void)testApiManagerSignInAnonymousUser{
    XCTAssertFalse([apiManager isUserSignedIn], @"User shoud not be signed in");
    
    // anonymous user
    [uid saveAnonymousUserInfo:auser];
    
    StartAsyncBlock();
    [apiManager signInUserWithUserTypeId:kAPIUserTypeAnonymous
                                   email:nil
                                password:nil
                                 success:^(){
                                     StopAsyncBlock();
                                 }
                                 failure:^(NSError *error){
                                     StopAsyncBlock();
                                     XCTFail(@"Must be sucessful");
                                 }];
    
    // Run the Wait loop
    WaitUntilAsyncBlockCompletes();
    
    XCTAssertEqual([apiManager currentUser].userTypeId.integerValue, auser.userTypeId.integerValue);
    XCTAssertEqualObjects([apiManager currentUser].email, auser.email);
    XCTAssertEqualObjects([apiManager currentUser].authenticationToken, auser.authenticationToken);
    XCTAssertEqualObjects([apiManager currentUser].signedIn, auser.signedIn);
    
    [apiManager performEnteredBackgroundActions];
    XCTAssertFalse([apiManager isUserSignedIn], @"User shoud not be signed in");
}

- (void)testApiManagerSignInUser{
    XCTAssertFalse([apiManager isUserSignedIn], @"User shoud not be signed in");
    
    //  user
    [uid saveUserInfo:user];
    XCTAssertTrue([apiManager isUserSignedIn], @"User shoud  be signed in");
    XCTAssertEqual([apiManager currentUser].userTypeId.integerValue, user.userTypeId.integerValue);
    XCTAssertEqualObjects([apiManager currentUser].email, user.email);
    XCTAssertEqualObjects([apiManager currentUser].authenticationToken, user.authenticationToken);
    XCTAssertEqualObjects([apiManager currentUser].signedIn, auser.signedIn);
    
    [apiManager performEnteredBackgroundActions];
    XCTAssertTrue([apiManager isUserSignedIn], @"User shoud be signed in");
    
    [apiManager performEnteredBackgroundActions];
    apiManager.apiUserManager.currentUser=nil;
    XCTAssertTrue([apiManager isUserSignedIn], @"User shoud be signed in");
    
    [apiManager performEnteredBackgroundActions];
    [uid deleteUserInfo];
    XCTAssertTrue([apiManager isUserSignedIn], @"User shoud be signed in");
    
    apiManager.apiUserManager.currentUser=nil;
    XCTAssertFalse([apiManager isUserSignedIn], @"User shoud not be signed in");
}


@end
