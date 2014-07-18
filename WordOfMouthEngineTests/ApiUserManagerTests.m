//
//  ApiUserManagerTests.m
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 7/8/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ApiUserManager.h"

@interface ApiUserManagerTests : XCTestCase{
    ApiUserManager      *aum;
    ApiUser *user, *auser;
    ApiUserDatabase *uid;
}

@end

@implementation ApiUserManagerTests

- (void)setUp{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    user= [[ApiUser alloc] initWithUserId:nil
                                   userTypeId:@2
                                    email:@"user@example.com"
                      authenticationToken:@"dfsr543jdfs9uhffaf4R"
                                 signedIn:@YES];
    auser= [[ApiUser alloc] initWithUserId:nil
                                userTypeId:@1
                                     email:@"huest@example.com"
                       authenticationToken:@"dfsr543jdfs9sfsdfaf4R"
                                  signedIn:@YES];
    uid = [[ApiUserDatabase  alloc] init];
}

- (void)tearDown{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    aum=nil;
    user=nil;
    auser=nil;
    [uid deleteUserInfo];
    [uid deleteAnonymousUserInfo];
    [super tearDown];
    
}

- (void)testApiUserManagerWithNoUser{
    [uid deleteUserInfo];
    aum =[[ApiUserManager alloc] init];
    // check if the user is nil
    XCTAssertNil(aum.currentUser,"Current User must be nil");
    XCTAssertFalse([aum isUserSignedIn],"User should not be singed in");
    aum.currentUser = user;
    XCTAssert([aum isUserSignedIn],"User should be singed in");
    aum.currentUser.signedIn=@NO;
    XCTAssertFalse([aum isUserSignedIn],"User should not be singed in");
    aum.currentUser.signedIn=@YES;
    aum.currentUser.authenticationToken=@"";
    XCTAssertFalse([aum isUserSignedIn],"User should not be singed in");
    aum.currentUser.authenticationToken=nil;
    XCTAssertFalse([aum isUserSignedIn],"User should not be singed in");
    aum.currentUser.authenticationToken=@"sdlfasdfdshfdlghf";
    aum.currentUser.email=@"";
    XCTAssertFalse([aum isUserSignedIn],"User should not be singed in");
    aum.currentUser.email=nil;
    XCTAssertFalse([aum isUserSignedIn],"User should not be singed in");
    aum.currentUser.email=@"dfasdh";
    XCTAssert([aum isUserSignedIn],"User should be singed in");
}

- (void)testApiUserManagerWithSignedInUser{
    [uid saveUserInfo:user];
    [uid saveAnonymousUserInfo:auser];
    aum =[[ApiUserManager alloc] init];
    // check if the user is nil
    XCTAssertNotNil(aum.currentUser,"Current User must not be nil");
    XCTAssert([aum isUserSignedIn],"User should be singed in");
    XCTAssertEqual(aum.currentUser.userTypeId.integerValue, user.userTypeId.integerValue);
    XCTAssertEqualObjects(aum.currentUser.email, user.email);
    XCTAssertEqualObjects(aum.currentUser.authenticationToken, user.authenticationToken);
    XCTAssertEqualObjects(aum.currentUser.signedIn, user.signedIn);
}

- (void)testApiUserManagerWithAnomymousSignedInUser{
    [uid deleteUserInfo];
    [uid saveAnonymousUserInfo:auser];
    aum =[[ApiUserManager alloc] init];
    // check if the user is nil
    XCTAssertNil(aum.currentUser,"Current User must be nil");
    XCTAssertFalse([aum isUserSignedIn],"User should not be singed in");
}

- (void)testUserSignInAndSignOut{
    [uid deleteUserInfo];
    aum =[[ApiUserManager alloc] init];
    // check if the user is nil
    XCTAssertNil(aum.currentUser,"Current User must be nil");
    // sign in user
    XCTAssert([aum signInUser:user], @"Should be able to sign in user");
    // check if the user is nil
    XCTAssertNotNil(aum.currentUser,"Current User must not be nil");
    XCTAssert([aum isUserSignedIn],"User should be singed in");
    XCTAssertEqual(aum.currentUser.userTypeId.integerValue, user.userTypeId.integerValue);
    XCTAssertEqualObjects(aum.currentUser.email, user.email);
    XCTAssertEqualObjects(aum.currentUser.authenticationToken, user.authenticationToken);
    XCTAssertEqualObjects(aum.currentUser.signedIn, user.signedIn);
    
    
    XCTAssert([aum signOutUser], @"Should be able to sign out user");
    // check if the user is nil
    XCTAssertNil(aum.currentUser,"Current User must be nil");
    XCTAssertFalse([aum isUserSignedIn],"User should not be singed in");
}
- (void)testAnonymousUserSignInAndSignOut{
    [uid deleteUserInfo];
    [uid saveAnonymousUserInfo:auser];
    aum =[[ApiUserManager alloc] init];
    // check if the user is nil
    XCTAssertNil(aum.currentUser,"Current User must be nil");
    // sign in user
    XCTAssert([aum signInAnonymousUser], @"Should be able to sign in user");
    // check if the user is nil
    XCTAssertNotNil(aum.currentUser,"Current User must not be nil");
    XCTAssert([aum isUserSignedIn],"User should be singed in");
    XCTAssertEqual(aum.currentUser.userTypeId.integerValue, auser.userTypeId.integerValue);
    XCTAssertEqualObjects(aum.currentUser.email, auser.email);
    XCTAssertEqualObjects(aum.currentUser.authenticationToken, auser.authenticationToken);
    XCTAssertEqualObjects(aum.currentUser.signedIn, auser.signedIn);
    
    
    XCTAssert([aum signOutUser], @"Should be able to sign out user");
    // check if the user is nil
    XCTAssertNil(aum.currentUser,"Current User must be nil");
    XCTAssertFalse([aum isUserSignedIn],"User should not be singed in");
    
    // sign in user
    XCTAssert([aum signInUser:user], @"Should be able to sign in user");
    // check if the user is nil
    XCTAssertNotNil(aum.currentUser,"Current User must not be nil");
    XCTAssert([aum isUserSignedIn],"User should be singed in");
    XCTAssertEqual(aum.currentUser.userTypeId.integerValue, user.userTypeId.integerValue);
    XCTAssertEqualObjects(aum.currentUser.email, user.email);
    XCTAssertEqualObjects(aum.currentUser.authenticationToken, user.authenticationToken);
    XCTAssertEqualObjects(aum.currentUser.signedIn, user.signedIn);
    XCTAssert([aum signOutUser], @"Should be able to sign out user");
    // check if the user is nil
    XCTAssertNil(aum.currentUser,"Current User must be nil");
    XCTAssertFalse([aum isUserSignedIn],"User should not be singed in");
}



@end
