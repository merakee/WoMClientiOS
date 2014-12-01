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
#import "PlaceHolderFactory.h"
#import "CommonUtility.h"
#import "TestHelper.h"

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
    // sign in user
    [TestHelper signInAnonymousUser];
}

- (void)tearDown
{
    //apiManager.apiUserManager.currentUser=nil;
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    //[TestHelper signOutAnonymousUser];
    [TestHelper signOutAndDeleteAnonymousUser];
}

#pragma mark - Post Content
- (void)testApiManagerPostContent{
    XCTAssert([apiManager isUserSignedIn], @"User should be signed in");
    // post 100 items
    for(int ind=0;ind<1;ind++){
        int cid = [CommonUtility pickRandom:4]+1;
        NSString *text =[PlaceHolderFactory sentencesWithNumber:2];
        ApiUser *currentUser =apiManager.apiUserManager.currentUser;
        
        StartAsyncBlock();
        [apiManager     postContentWithCategoryId:cid
                                             text:text
                                            photo:nil 
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
    }
}

- (void)testApiManagerPostContentWithImage{
    XCTAssert([apiManager isUserSignedIn], @"User should be signed in");
    // post 100 items
    for(int ind=0;ind<1;ind++){
        int cid = [CommonUtility pickRandom:4]+1;
        NSString *text =[PlaceHolderFactory sentencesWithNumber:2];
        ApiUser *currentUser =apiManager.apiUserManager.currentUser;
        
        StartAsyncBlock();
        [apiManager     postContentWithCategoryId:cid
                                             text:text
                                            photo:[UIImage imageNamed:[[@"bg" stringByAppendingFormat:@"%d",[CommonUtility pickRandom:4]+1] stringByAppendingString:@".jpg"]]
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
    }
}

#pragma mark - Get Content
- (void)testApiManagerGetContent{
    // get 100 items
    for(int ind=0;ind<100;ind++){
        XCTAssert([apiManager isUserSignedIn], @"User should be signed in");
        //  user
        StartAsyncBlock();
        [apiManager     getContentListSuccess:^(NSArray *contentArray){
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
    }
}

- (void)checkValidityOfContentArray:(NSArray *)array{
    for(int ind =0; ind<[array count];ind++){
        [self checkValidityOfContent:array[ind]];
    }
}

- (BOOL)checkValidityOfContent:(ApiContent *)content{
    XCTAssert(content.contentId && content.contentId.integerValue>1,@"Must be postive integer");
    XCTAssert(content.categoryId &&content.categoryId.integerValue>=kAPIContentCategoryNews
              &&content.categoryId.integerValue<=kAPIContentCategoryLocalInfo,@"Must be a valid category");
    XCTAssert(content.userId&&content.userId.integerValue>1,@"Must be postive integer");
    XCTAssert(content.contentText&&[content.contentText length]>kAPIValidationContentMinLength && [content.contentText length]<kAPIValidationContentMinLength,@"Must be of valid length");
    XCTAssertNotNil(content.photoToken,@"Must not be nil");
    XCTAssertNotNil(content.createdAt,@"Must not be nil");
    XCTAssertNotNil(content.totalSpread,@"Must not be nil");
    XCTAssertNotNil(content.spreadCount,@"Must not be nil");
    XCTAssertNotNil(content.killCount,@"Must not be nil");
    XCTAssertNotNil(content.commentCount,@"Must not be nil");
}

#pragma mark - Response
- (void)testApiManagerPostResponse{
    XCTAssert([apiManager isUserSignedIn], @"User should be signed in");
    XCTAssert([TestHelper createContentsWithCount:100],@"Must be able to create contents");
    // post 100 items
    for(int ind=0;ind<100;ind++){
        //int contentId =[CommonUtility pickRandom:100]+1;
        int contentId =ind+1;
        NSNumber *response= [NSNumber numberWithBool:[CommonUtility pickRandom:2]>0];
        ApiUser *currentUser =apiManager.apiUserManager.currentUser;
        
        StartAsyncBlock();
        [apiManager     postResponseWithContentId:contentId
                                         response:response
                                          success:^(ApiUserResponse *userResponse){
                                              XCTAssertEqual(userResponse.contentId.integerValue, contentId);
                                              XCTAssertEqual(userResponse.userResponse,response);
                                              XCTAssertEqual(userResponse.userId.integerValue,currentUser.userId.integerValue);
                                              StopAsyncBlock();
                                          }
                                          failure:^(NSError *error){
                                              StopAsyncBlock();
                                              NSLog(@"Error: %@",error);
                                              XCTFail(@"Must be sucessful");
                                          }];
        
        // Run the Wait loop
        WaitUntilAsyncBlockCompletes();
    }
}

@end
