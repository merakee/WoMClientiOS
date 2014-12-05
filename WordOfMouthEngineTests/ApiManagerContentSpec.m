//
//  ApiManagerContentSpec.m
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 12/1/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//


#import "SpectaSetUp.h"
#import "TestHelperSpec.h"
#import "ApiManager.h"
#import "PlaceHolderFactory.h"
#import "CommonUtility.h"

//SharedExamplesBegin(MySharedExamples)
//// Global shared examples are shared across all spec files.
//
////sharedExamplesFor(@"a shared behavior", ^(NSDictionary *data) {
////    it(@"should do some stuff", ^{
////        id obj = data[@"key"];
////        // ...
////    });
////});
//
//SharedExamplesEnd



SpecBegin(ApiManagerContent)
// helper methods
describe(@"Content", ^{
    // set up all variables
    __block ApiManager *apiManager;
    __block int newContentId;
    __block NSString *text;
    __block bool response;
    
    //    sharedExamplesFor(@"another shared behavior", ^(NSDictionary *data) {
    //        // Locally defined shared examples can override global shared examples within its scope.
    //    });
    
    beforeAll(^{
        // This is run once and only once before all of the examples
        // in this group and before any beforeEach blocks.
        apiManager = [ApiManager sharedApiManager];
        //signUpUser(@"test_user1@test.com",@"testpassword");
        //signUpUser(@"test_user2@test.com",@"testpassword");
        [TestHelperSpec signInUserWithEmail:nil andPassword:nil];
    });
    
    beforeEach(^{
        // This is run before each example.
    });
    afterEach(^{
        // This is run after each example.
    });
    afterAll(^{
        // This is run once and only once after all of the examples
        // in this group and after any afterEach blocks.
        [TestHelperSpec signOutUser];
    });
    
    describe(@"Anonymous User", ^{
        it(@"should be able to get content array",^{
            expect([apiManager isUserSignedIn]).to.beTruthy();
            
            waitUntil(^(DoneCallback done) {
                [apiManager
                 getContentListSuccess:^(NSArray *contentArray){
                     expect([contentArray count]).to.equal(20);
                     newContentId = (int) [((ApiContent *) contentArray[0]).contentId integerValue];
                     done();
                 }
                 failure:^(NSError *error){
                     NSLog(@"Error: %@",error);
                     expect(error).to.beNil();
                     done();
                 }];
            });
            
        });
        
        it(@"should be able to get content with id",^{
            waitUntil(^(DoneCallback done) {
                [apiManager
                 getContentWithId:1
                 success:^(ApiContent *content) {
                     expect(content).toNot.beNil();
                     expect([ApiContent isValidContent:content]).to.beTruthy();
                     done();
                 }
                 failure:^(NSError *error){
                     NSLog(@"Error: %@",error);
                     expect(error).to.beNil();
                     done();
                 }];
            });
        });
        
        it(@"should be able to post content with text",^{
            waitUntil(^(DoneCallback done) {
                text =[PlaceHolderFactory  sentence];
                [apiManager postContentWithCategoryId:kAPIContentCategoryNews
                                                 text:text
                                                photo:nil
                                              success:^(ApiContent *content) {
                                                  expect(content).toNot.beNil();
                                                  expect([ApiContent isValidContent:content]).to.beTruthy();
                                                  expect(content.contentText).to.equal(text);
                                                  done();
                                              }
                                              failure:^(NSError *error) {
                                                  NSLog(@"Error: %@",error);
                                                  expect(error).to.beNil();
                                                  done();
                                              }];
            });
        });
        
        it(@"should be able to post content response with id",^{
            waitUntil(^(DoneCallback done) {
                response =[CommonUtility pickRandom:2]>0;
                [apiManager postResponseWithContentId:newContentId
                                             response:[NSNumber numberWithBool:response]
                                              success:^(ApiUserResponse *userResponse) {
                                                  expect(userResponse).toNot.beNil();
                                                  expect([ApiUserResponse isValidUserResponse:userResponse]).to.beTruthy();
                                                  expect(userResponse.userResponse).to.equal(response);
                                                  done();
                                              }
                                              failure:^(NSError *error) {
                                                  NSLog(@"Error: %@",error);
                                                  //expect(error.localizedFailureReason).to.equal(@"User_Id User already responsed to this content. User cannot respond to the same content more than once.");
                                                  expect(error).to.beNil();
                                                  done();
                                              }];
            });
        });
        
        it(@"should be able to flag content with id",^{
            waitUntil(^(DoneCallback done) {
                [apiManager flagContentWithId:newContentId
                                      success:^(ApiContentFlag *contentFlag) {
                                          expect(contentFlag).toNot.beNil();
                                          expect([ApiContentFlag isValidContentFlag:contentFlag]).to.beTruthy();
                                          expect(contentFlag.contentId).to.equal(newContentId);
                                          done();
                                      }
                                      failure:^(NSError *error) {
                                          NSLog(@"Error: %@",error);
                                          expect(error).to.beNil();
                                          done();
                                      }];
            });
        });
        
    });
});


describe(@"Content", ^{
    // set up all variables
    __block ApiManager *apiManager;
    __block int newContentId;
    __block NSString *text;
    __block bool response;
    
    //    sharedExamplesFor(@"another shared behavior", ^(NSDictionary *data) {
    //        // Locally defined shared examples can override global shared examples within its scope.
    //    });
    
    beforeAll(^{
        // This is run once and only once before all of the examples
        // in this group and before any beforeEach blocks.
        apiManager = [ApiManager sharedApiManager];
        [TestHelperSpec signInUserWithEmail: @"test_user1@test.com" andPassword:@"testpassword"];
    });
    
    beforeEach(^{
        // This is run before each example.
    });
    afterEach(^{
        // This is run after each example.
    });
    afterAll(^{
        // This is run once and only once after all of the examples
        // in this group and after any afterEach blocks.
        [TestHelperSpec signOutUser];
    });
    
    
    describe(@"Normal User", ^{
        it(@"should be able to get content array",^{
            expect([apiManager isUserSignedIn]).to.beTruthy();
            
            waitUntil(^(DoneCallback done) {
                [apiManager
                 getContentListSuccess:^(NSArray *contentArray){
                     expect([contentArray count]).to.equal(20);
                     newContentId = (int) [((ApiContent *) contentArray[0]).contentId integerValue];
                     done();
                 }
                 failure:^(NSError *error){
                     NSLog(@"Error: %@",error);
                     expect(error).to.beNil();
                     done();
                 }];
            });
            
        });
        
        it(@"should be able to get content with id",^{
            waitUntil(^(DoneCallback done) {
                [apiManager
                 getContentWithId:1
                 success:^(ApiContent *content) {
                     expect(content).toNot.beNil();
                     expect([ApiContent isValidContent:content]).to.beTruthy();
                     done();
                 }
                 failure:^(NSError *error){
                     NSLog(@"Error: %@",error);
                     expect(error).to.beNil();
                     done();
                 }];
            });
        });
        
        it(@"should be able to post content with text",^{
            waitUntil(^(DoneCallback done) {
                text =[PlaceHolderFactory  sentence];
                [apiManager postContentWithCategoryId:kAPIContentCategoryNews
                                                 text:text
                                                photo:nil
                                              success:^(ApiContent *content) {
                                                  expect(content).toNot.beNil();
                                                  expect([ApiContent isValidContent:content]).to.beTruthy();
                                                  expect(content.contentText).to.equal(text);
                                                  done();
                                              }
                                              failure:^(NSError *error) {
                                                  NSLog(@"Error: %@",error);
                                                  expect(error).to.beNil();
                                                  done();
                                              }];
            });
        });
        
        it(@"should be able to post content response with id",^{
            waitUntil(^(DoneCallback done) {
                response =[CommonUtility pickRandom:2]>0;
                [apiManager postResponseWithContentId:newContentId
                                             response:[NSNumber numberWithBool:response]
                                              success:^(ApiUserResponse *userResponse) {
                                                  expect(userResponse).toNot.beNil();
                                                  expect([ApiUserResponse isValidUserResponse:userResponse]).to.beTruthy();
                                                  expect(userResponse.userResponse).to.equal(response);
                                                  done();
                                              }
                                              failure:^(NSError *error) {
                                                  NSLog(@"Error: %@",error);
                                                  //NSLog(@"************Error: %@",error.localizedFailureReason);
                                                  //expect(error.localizedFailureReason).to.equal(@"User_Id User already responsed to this content. User cannot respond to the same content more than once.");
                                                  expect(error).to.beNil();
                                                  done();
                                              }];
            });
        });
        
        it(@"should be able to flag content with id",^{
            waitUntil(^(DoneCallback done) {
                [apiManager flagContentWithId:newContentId
                                      success:^(ApiContentFlag *contentFlag) {
                                          expect(contentFlag).toNot.beNil();
                                          expect([ApiContentFlag isValidContentFlag:contentFlag]).to.beTruthy();
                                          expect(contentFlag.contentId).to.equal(newContentId);
                                          done();
                                      }
                                      failure:^(NSError *error) {
                                          NSLog(@"Error: %@",error);
                                          expect(error).toNot.beNil();
                                          done();
                                      }];
            });
        });
        
    });
    
});

SpecEnd
