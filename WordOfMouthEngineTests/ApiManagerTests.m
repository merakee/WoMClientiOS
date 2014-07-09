//
//  ApiManagerTests.m
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 11/18/13.
//  Copyright (c) 2013 Bijit Halder. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ApiManager.h"

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
    XCTAssertEqual(apiManager, [ApiManager sharedApiManager], @"Must be singleton");
}
- (void)testApiManagerSignInAnonymousUser{
    XCTAssertFalse([apiManager isUserSignedIn], @"User shoud not be signed in");
    
    // anonymous user
    [uid saveAnonymousUserInfo:auser];
    XCTAssertTrue([apiManager signInUserWithUserTypeId:1 email:nil andPassword:nil], @"Should be able to sign in user");
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
