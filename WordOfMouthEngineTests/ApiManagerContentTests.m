//
//  ApiManagerTests.m
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 11/18/13.
//  Copyright (c) 2013 Bijit Halder. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ApiManager.h"
#import "AsynTextHelper.h"
#import "ApiUserDatabase.h"
#import "PlaceHolderFactory.h"
#import "CommonUtility.h"

@interface ApiManagerContentTests : XCTestCase{
    ApiManager *apiManager;
    ApiUser *user, *auser;
}

@end

@implementation ApiManagerContentTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    apiManager=[ApiManager sharedApiManager];
    // sign in user with database
    apiManager.apiUserManager.currentUser = [[[ApiUserDatabase alloc] init] getAnonymousUser];
}

- (void)tearDown
{
    //apiManager.apiUserManager.currentUser=nil;
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testApiManagerSignUpAnonymousUserFirstTimeForContent{
    //XCTAssert([apiManager isUserSignedIn], @"User should be signed in");
    
    // delete all user
    XCTAssert([[[ApiUserDatabase alloc] init] deleteAnonymousUserInfo],@"Delete anonymous user info should be successful");
    XCTAssert([[[ApiUserDatabase alloc] init] deleteUserInfo],@"Delete  user info should be successful");
    apiManager.apiUserManager.currentUser =nil;
    
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
}

#pragma mark - Content
- (void)testApiManagerPostContent{
    XCTAssert([apiManager isUserSignedIn], @"User should be signed in");
    int cid = [CommonUtility pickRandom:4]+1;
    NSString *text =[PlaceHolderFactory sentencesWithNumber:2];
    ApiUser *currentUser =apiManager.apiUserManager.currentUser;
    //  user
    StartAsyncBlock();
    
    [apiManager     postContentWithCategoryId:cid
                                         text:text
                                      success:^(ApiContent * content){
                                          XCTAssertEqual(content.categoryId.integerValue, cid);
                                          XCTAssertEqualObjects(content.contentText,text);
                                          XCTAssertEqual(content.userId.integerValue,currentUser.userId.integerValue);
                                          StopAsyncBlock();
                                      }
                                      failure:^(NSError *error){
                                          StopAsyncBlock();
                                          NSLog(@"Error: %@",error);
                                          XCTFail(@"Must be sucessful");
                                      }];
    
    // Run the Wait loop
    WaitUntilAsyncBlockCompletes();
    
    // delete anonymous user
    //XCTAssert([[[ApiUserDatabase alloc] init] deleteAnonymousUserInfo],@"Delete anonymous user info should be successful");
}


- (void)testApiManagerGetContent{
    XCTAssert([apiManager isUserSignedIn], @"User should be signed in");
    //  user
    StartAsyncBlock();
    [apiManager     getContentSuccess:^(NSArray *contentArray){
        XCTAssert([contentArray count]==20,@"There must be 20 contents");
        StopAsyncBlock();
    }
                              failure:^(NSError *error){
                                  StopAsyncBlock();
                                  NSLog(@"Error: %@",error);
                                  XCTFail(@"Must be sucessful");
                              }];
    
    // Run the Wait loop
    WaitUntilAsyncBlockCompletes();
    
    // delete all user
    //XCTAssert([[[ApiUserDatabase alloc] init] deleteAnonymousUserInfo],@"Delete anonymous user info should be successful");
    //XCTAssert([[[ApiUserDatabase alloc] init] deleteUserInfo],@"Delete  user info should be successful");
    //apiManager.apiUserManager.currentUser =nil;
}

#pragma mark - Response


@end
