//
//  UserInfoDatabaseTests.m
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 7/7/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ApiUserDatabase.h"

@interface ApiUserDatabaseTests : XCTestCase{
    ApiUserDatabase *uid;
    ApiUser *user;
    ApiUser *auser;
}

@end


@implementation ApiUserDatabaseTests

- (void)setUp{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    uid =[[ApiUserDatabase alloc] init];
    
    user= [[ApiUser alloc] initWithUserId:@2342
                               userTypeId:[NSNumber numberWithInt:kAPIUserTypeWom]
                                    email:@"user@example.com"
                      authenticationToken:@"dfsr543jdfs9uhffaf4R"
                                 signedIn:@YES];
    auser= [[ApiUser alloc] initWithUserId:@32671
                                userTypeId:[NSNumber numberWithInt:kAPIUserTypeAnonymous]
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
    XCTAssert([uid saveUserInfo:user],@"User should be saved");
    
    ApiUser *user1=[uid getUser];
    XCTAssertEqual(user.userId.intValue,user1.userId.intValue,@"Saved User id %d should be same as retrived User userid %d",user.userTypeId.intValue,user1.userTypeId.intValue);
    XCTAssertEqual(user.userTypeId.intValue,user1.userTypeId.intValue,@"Saved User typeid %d should be same as retrived User usertypeid %d",user.userTypeId.intValue,user1.userTypeId.intValue);
    XCTAssertEqualObjects(user.email, user1.email, @"Saved User email %@ should be same as retrived User email %@",user.email, user1.email);
    XCTAssertEqualObjects(user.authenticationToken,user1.authenticationToken, @"Saved User email %@ should be same as retrived User email %@", user.authenticationToken,user1.authenticationToken);
    XCTAssertEqual(user.signedIn.boolValue,user1.signedIn.boolValue,@"Saved User typeid %d should be same as retrived User usertypeid %d",user.signedIn.boolValue,user1.signedIn.boolValue);
    
    XCTAssert([uid deleteUserInfo],@"User should be deleted");
    
    XCTAssertNil([uid getUser],@"There should be no user");
}

- (void)testAnonymouUserActions{
    // test anonhhmous user
    XCTAssert([uid saveAnonymousUserInfo:auser],@"User should be saved");
    
    ApiUser *auser1=[uid getAnonymousUser];
        XCTAssertEqual(auser.userId.intValue,auser1.userId.intValue,@"Saved User id %d should be same as retrived User userid %d",auser.userTypeId.intValue,auser1.userTypeId.intValue);
    XCTAssertEqual(auser.userTypeId.intValue,auser1.userTypeId.intValue,@"Saved User typeid %d should be same as retrived User usertypeid %d",auser.userTypeId.intValue,auser1.userTypeId.intValue);
    XCTAssertEqualObjects(auser.email, auser1.email, @"Saved User email %@ should be same as retrived User email %@",auser.email, auser1.email);
    XCTAssertEqualObjects(auser.authenticationToken,auser1.authenticationToken, @"Saved User email %@ should be same as retrived User email %@",auser.authenticationToken,auser1.authenticationToken);
    XCTAssertEqual(auser.signedIn.boolValue,auser1.signedIn.boolValue,@"Saved User typeid %d should be same as retrived User usertypeid %d",auser.signedIn.boolValue,auser1.signedIn.boolValue);
}
- (void)testDecoulingOfUsers{
    // test regular user
    XCTAssert([uid saveUserInfo:user],@"User should be saved");
    // test anonhhmous user
    XCTAssert([uid saveAnonymousUserInfo:auser],@"User should be saved");
    // see regular user
    XCTAssert([uid getUser], @"User should still be there");
    // delete regular user
    XCTAssert([uid deleteUserInfo], @"User should able to delete");
    // see regular user
    XCTAssertFalse([uid getUser], @"User should not be there");
    // see anon user
    XCTAssert([uid getAnonymousUser], @"User should still be there");
    // test regular user
    XCTAssert([uid saveUserInfo:user],@"User should be saved");
    // save anaon user
    XCTAssert([uid saveAnonymousUserInfo:auser],@"User should be saved");
    // see regular user
    XCTAssert([uid getUser], @"User should be there");
    // see anon user
    XCTAssert([uid getAnonymousUser], @"User should still be there");
}

@end
