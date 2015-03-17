//
//  ApiManagerCommentSpec.m
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



SpecBegin(ApiManagerComment)
// helper methods

describe(@"Comment", ^{
    // set up all variables
    __block ApiManager *apiManager;
    __block int new_comment_id;
    __block int newContentId;
    __block NSString *text;
    __block NSString *email;
    __block NSString *password;
    
    
    sharedExamplesFor(@"User With All Permission", ^(NSDictionary *data) {
        //        // Locally defined shared examples can override global shared examples within its scope.
        
        it(@"should be able to post comment with text",^{
            expect([apiManager isUserSignedIn]).to.beTruthy();
            // post a new content and get id
            newContentId = [TestHelperSpec  postContent];
            
            expect(newContentId).to.beGreaterThan(0);
            
            for(int ind=0;ind<20;ind++){
                text =[PlaceHolderFactory  sentence];
                waitUntil(^(DoneCallback done) {
                    text =[PlaceHolderFactory  sentence];
                    [apiManager postCommentWithContentId:newContentId
                                                    text:text
                                                 success:^(ApiComment *comment) {
                                                     expect(comment).toNot.beNil();
                                                     expect([ApiComment isValidComment:comment]).to.beTruthy();
                                                     expect(comment.commentText).to.equal(text);
                                                     done();
                                                 }
                                                 failure:^(NSError *error) {
                                                     NSLog(@"Error: %@",error);
                                                     expect(error).to.beNil();
                                                     done();
                                                 }];
                });
            }
        });
        
        
        
        it(@"should be able to get comment array with default parameters",^{
            waitUntil(^(DoneCallback done) {
                [apiManager getCommentsForContentId:newContentId
                                               mode:kAPICommentOrderModeRecent
                                              count:0
                                             offset:0
                                            success:^(NSArray *commentArray) {
                                                expect([commentArray count]).to.equal(20);
                                                done();
                                            }
                                            failure:^(NSError *error) {
                                                NSLog(@"Error: %@",error);
                                                expect(error).to.beNil();
                                                done();
                                            }];
            });
            
        });
        
        it(@"should be able to get comment array with popular ordering",^{
            waitUntil(^(DoneCallback done) {
                [apiManager getCommentsForContentId:newContentId
                                               mode:kAPICommentOrderModePopular
                                              count:0
                                             offset:0
                                            success:^(NSArray *commentArray) {
                                                expect([commentArray count]).to.equal(20);
                                                done();
                                            }
                                            failure:^(NSError *error) {
                                                NSLog(@"Error: %@",error);
                                                expect(error).to.beNil();
                                                done();
                                            }];
            });
            
        });
        
        it(@"should be able to get comment array with count",^{
            waitUntil(^(DoneCallback done) {
                [apiManager getCommentsForContentId:newContentId
                                               mode:kAPICommentOrderModeRecent
                                              count:12
                                             offset:0
                                            success:^(NSArray *commentArray) {
                                                expect([commentArray count]).to.equal(12);
                                                done();
                                            }
                                            failure:^(NSError *error) {
                                                NSLog(@"Error: %@",error);
                                                expect(error).to.beNil();
                                                done();
                                            }];
            });
            
        });
        
        it(@"should be able to get comment array with count and offset parameter",^{
            waitUntil(^(DoneCallback done) {
                [apiManager getCommentsForContentId:newContentId
                                               mode:kAPICommentOrderModeRecent
                                              count:12
                                             offset:10
                                            success:^(NSArray *commentArray) {
                                                expect([commentArray count]).to.equal(10);
                                                done();
                                            }
                                            failure:^(NSError *error) {
                                                NSLog(@"Error: %@",error);
                                                expect(error).to.beNil();
                                                done();
                                            }];
            });
            
        });
        
        it(@"should be able to get comment array with only offset",^{
            waitUntil(^(DoneCallback done) {
                [apiManager getCommentsForContentId:newContentId
                                               mode:kAPICommentOrderModeRecent
                                              count:0
                                             offset:12
                                            success:^(NSArray *commentArray) {
                                                expect([commentArray count]).to.equal(8);
                                                done();
                                            }
                                            failure:^(NSError *error) {
                                                NSLog(@"Error: %@",error);
                                                expect(error).to.beNil();
                                                done();
                                            }];
            });
            
        });
        
        it(@"should be able to get comment array with wrong parameters",^{
            waitUntil(^(DoneCallback done) {
                [apiManager getCommentsForContentId:newContentId
                                               mode:kAPICommentOrderModeRecent
                                              count:-34
                                             offset:-56
                                            success:^(NSArray *commentArray) {
                                                expect([commentArray count]).to.equal(20);
                                                new_comment_id = (int) [((ApiComment *) commentArray[0]).commentId integerValue];
                                                done();
                                            }
                                            failure:^(NSError *error) {
                                                NSLog(@"Error: %@",error);
                                                expect(error).to.beNil();
                                                done();
                                            }];
            });
            
        });
        
        
        it(@"should be able to post comment response without response",^{
            // post a new comment and get id
            new_comment_id = [TestHelperSpec postCommtentForContent:newContentId];
            expect(new_comment_id).to.beGreaterThan(0);
            
            waitUntil(^(DoneCallback done) {
                [apiManager postCommentResponseWithCommentId:new_comment_id
                                                     success:^(ApiCommentResponse *commentResponse) {
                                                         expect(commentResponse).toNot.beNil();
                                                         expect([ApiCommentResponse isValidCommentResponse:commentResponse]).to.beTruthy();
                                                         expect(commentResponse.commentResponse).to.beTruthy;
                                                         done();
                                                     }
                                                     failure:^(NSError *error) {
                                                         NSLog(@"Error: %@",error);
                                                         //expect(error.localizedFailureReason).to.equal(@"User_Id User already responsed to this comment. User cannot respond to the same comment more than once.");
                                                         expect(error).to.beNil();
                                                         done();
                                                     }];
            });
        });
    });
    
    beforeAll(^{
        // This is run once and only once before all of the examples
        // in this group and before any beforeEach blocks.
        apiManager = [ApiManager sharedApiManager];
        //signUpUser(@"test_user1@test.com",@"testpassword");
        //signUpUser(@"test_user2@test.com",@"testpassword");
    });
    
    beforeEach(^{
        // This is run before each example.
        [TestHelperSpec signInUserWithEmail:email andPassword:password];
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
        email=nil;
        password=nil;
        itShouldBehaveLike(@"User With All Permission",nil);
    });
    
    describe(@"Normal User", ^{
        email=@"test_user1@test.com";
        password=@"testpassword";
        itShouldBehaveLike(@"User With All Permission",nil);
    });
});

SpecEnd
