//
//  ApiManagerNotificationSpec.m
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 12/1/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import "SpectaSetUp.h"
#import "TestHelperSpec.h"
#import "ApiManager.h"

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



SpecBegin(ApiManagerNotification)
// helper methods

describe(@"Notification", ^{
    // set up all variables
    __block ApiManager *apiManager;
    
    //sharedExamplesFor(@"User With Right Permission", ^(NSDictionary *data) {
    // Locally defined shared examples can override global shared examples within its scope.
    // });
    
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
        it(@"should not be able to get notification count",^{
            waitUntil(^(DoneCallback done) {
                [apiManager
                 getNotificationCountSuccess:^(ApiNotificationCount *notificationCount) {
                     expect([ApiNotificationCount isValidNotificationCount:notificationCount]).to.beFalsy();
                     done();
                 }
                 failure:^(NSError *error) {
                     NSLog(@"Error: %@",error);
                     expect(error.localizedDescription).to.equal(@"Invalid request for anonymous user");
                     done();
                 }];
            });
        });
        
        it(@"should not be able to get notification list",^{
            waitUntil(^(DoneCallback done) {
                [apiManager
                 getNotificationListSuccess:^(NSArray *notificationArray) {
                     expect([notificationArray count]).to.equal(0);
                     done();
                 }
                 failure:^(NSError *error) {
                     NSLog(@"Error: %@",error);
                     expect(error.localizedDescription).to.equal(@"Invalid request for anonymous user");
                     done();
                 }];
            });
            
        });
        
        it(@"should not be able to resent notification for content",^{
            int contentId = [TestHelperSpec postContent];
            [TestHelperSpec postCommtentForContent:contentId];
            
            waitUntil(^(DoneCallback done) {
                [apiManager
                 resetNotificationCountForContent:contentId
                 withCount:1
                 success:^(ApiContent *content) {
                     expect([ApiContent isValidContent:content]).to.beFalsy();
                     done();
                 }
                 failure:^(NSError *error) {
                     NSLog(@"Error: %@",error);
                     expect(error.localizedDescription).to.equal(@"Invalid request for anonymous user");
                     done();
                 }];
            });
        });
        
        it(@"should not be able to resent notification for comment",^{
            int commentId = [TestHelperSpec postCommtentForContent:1];
            [TestHelperSpec likeCommtentWithId:commentId];
            
            waitUntil(^(DoneCallback done) {
                [apiManager
                 resetNotificationCountForComment:commentId
                 withCount:1
                 success:^(ApiComment *comment) {
                     expect([ApiComment isValidComment:comment]).to.beFalsy();
                     done();
                 }
                 failure:^(NSError *error) {
                     NSLog(@"Error: %@",error);
                     expect(error.localizedDescription).to.equal(@"Invalid request for anonymous user");
                     done();
                 }];
            });
        });
        
    });
    
});

describe(@"Notification", ^{
    // set up all variables
    __block ApiManager *apiManager;
    
    //sharedExamplesFor(@"User With Right Permission", ^(NSDictionary *data) {
    // Locally defined shared examples can override global shared examples within its scope.
    // });
    
    beforeAll(^{
        // This is run once and only once before all of the examples
        // in this group and before any beforeEach blocks.
        apiManager = [ApiManager sharedApiManager];
        //signUpUser(@"test_user1@test.com",@"testpassword");
        //signUpUser(@"test_user2@test.com",@"testpassword");
        [TestHelperSpec signInUserWithEmail:@"test_user1@test.com" andPassword:@"testpassword"];
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
        
        for(int ind=0;ind<10;ind++){
            int contentId = [TestHelperSpec postContent];
            int commentId = [TestHelperSpec postCommtentForContent:contentId];
            [TestHelperSpec likeCommtentWithId:commentId];
        }
        
        it(@"should be able to get notification count",^{
            
            waitUntil(^(DoneCallback done) {
                [apiManager
                 getNotificationCountSuccess:^(ApiNotificationCount *notificationCount) {
                     expect([ApiNotificationCount isValidNotificationCount:notificationCount]).to.beTruthy();
                     done();
                 }
                 failure:^(NSError *error) {
                     NSLog(@"Error: %@",error);
                     expect(error).to.beNil();
                     done();
                 }];
            });
        });
        
        it(@"should be able to get notification list",^{
            waitUntil(^(DoneCallback done) {
                [apiManager
                 getNotificationListSuccess:^(NSArray *notificationArray) {
                     expect([notificationArray count]).to.beGreaterThanOrEqualTo(20);
                     done();
                 }
                 failure:^(NSError *error) {
                     NSLog(@"Error: %@",error);
                     expect(error).to.beNil();
                     done();
                 }];
            });
            
        });
        
        it(@"should not be able to resent notification for content",^{
            int contentId = [TestHelperSpec postContent];
            [TestHelperSpec postCommtentForContent:contentId];
            
            waitUntil(^(DoneCallback done) {
                [apiManager
                 resetNotificationCountForContent:contentId
                 withCount:1
                 success:^(ApiContent *content) {
                     expect([ApiContent isValidContent:content]).to.beTruthy();
                     expect(content.commentCountNew).to.equal(0);
                     done();
                 }
                 failure:^(NSError *error) {
                     NSLog(@"Error: %@",error);
                     expect(error).to.beNil();
                     done();
                 }];
            });
        });
        
        it(@"should be able to resent notification for comment",^{
            int commentId = [TestHelperSpec postCommtentForContent:1];
            int  commentResponseId = [TestHelperSpec likeCommtentWithId:commentId];
            NSLog(@"CRID *************: %d",commentResponseId);
            
            waitUntil(^(DoneCallback done) {
                [apiManager
                 resetNotificationCountForComment:commentId
                 withCount:1
                 success:^(ApiComment *comment) {
                     expect([ApiComment isValidComment:comment]).to.beTruthy();
                     expect(comment.likeCountNew).to.equal(0);
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



SpecEnd
