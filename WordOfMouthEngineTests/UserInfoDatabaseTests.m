//
//  UserInfoDatabaseTests.m
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 7/7/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UserInfoDatabase.h"

@interface UserInfoDatabaseTests : XCTestCase{
    UserInfoDatabase *uid;
    ApiUser *user;
    ApiUser *auser;
}

@end


@implementation UserInfoDatabaseTests

- (void)setUp{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    uid =[[UserInfoDatabase alloc] init];
    
    user= [[ApiUser alloc] initWithTypeId:@2
                                    email:@"user@example.com"
                      authenticationToken:@"dfsr543jdfs9uhffaf4R"
                                 signedIn:@YES];
    auser= [[ApiUser alloc] initWithTypeId:@1
                                     email:@"anon@example.com"
                       authenticationToken:@"dfsr543jdfs9uhffaf4R"
                                  signedIn:@YES];
    
}

- (void)tearDown{
        [uid deleteUserInfo];
    [uid deleteAnonymousUserInfo];
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];

}

- (void)testUserActions{
    // test regular user
    XCTAssertNil([uid getUser],@"There should be no user");
    XCTAssertTrue([uid saveUserInfo:user],@"User should be saved");
    
    ApiUser *user1=[uid getUser];
    XCTAssertEqual(user.userTypeId.intValue,user1.userTypeId.intValue,@"Saved User typeid %d should be same as retrived User usertypeid %d",user.userTypeId.intValue,user1.userTypeId.intValue);
    XCTAssertEqualObjects(user.email, user1.email, @"Saved User email %@ should be same as retrived User email %@",user.email, user1.email);
    XCTAssertEqualObjects(user.authenticationToken,user1.authenticationToken, @"Saved User email %@ should be same as retrived User email %@", user.authenticationToken,user1.authenticationToken);
    XCTAssertEqual(user.signedIn.boolValue,user1.signedIn.boolValue,@"Saved User typeid %d should be same as retrived User usertypeid %d",user.signedIn.boolValue,user1.signedIn.boolValue);
    
    XCTAssertTrue([uid deleteUserInfo],@"User should be deleted");
    
    XCTAssertNil([uid getUser],@"There should be no user");
}

- (void)testAnonymouUserActions{
    // test anonhhmous user
    ApiUser *u1=[uid getAnonymousUser];
    XCTAssertNil(u1,@"There should be no user %@",u1);
    XCTAssertTrue([uid saveAnonymousUserInfo:auser],@"User should be saved");
    
    ApiUser *auser1=[uid getAnonymousUser];
    XCTAssertEqual(auser.userTypeId.intValue,auser1.userTypeId.intValue,@"Saved User typeid %d should be same as retrived User usertypeid %d",auser.userTypeId.intValue,auser1.userTypeId.intValue);
    XCTAssertEqualObjects(auser.email, auser1.email, @"Saved User email %@ should be same as retrived User email %@",auser.email, auser1.email);
    XCTAssertEqualObjects(auser.authenticationToken,auser1.authenticationToken, @"Saved User email %@ should be same as retrived User email %@",auser.authenticationToken,auser1.authenticationToken);
    XCTAssertEqual(auser.signedIn.boolValue,auser1.signedIn.boolValue,@"Saved User typeid %d should be same as retrived User usertypeid %d",auser.signedIn.boolValue,auser1.signedIn.boolValue);
}

@end
