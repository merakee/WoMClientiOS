//
//  ApiManagerHistorySpec.m
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



SpecBegin(ApiManagerHistory)
// helper methods

describe(@"History", ^{
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
        it(@"should not be able to get content history array with default parameters",^{
            waitUntil(^(DoneCallback done) {
                [apiManager getHistoryOfContentsWithCount:0
                                                   offset:0
                                                  success:^(NSArray *historyArray) {
                                                      expect([historyArray count]).to.equal(0);
                                                      done();
                                                  }
                                                  failure:^(NSError *error) {
                                                      NSLog(@"Error: %@",error);
                                                      expect(error.localizedDescription).to.equal(@"Invalid request for anonymous user");
                                                      done();
                                                  }];
            });
            
        });
        
        it(@"should not be able to get content history array with count",^{
            waitUntil(^(DoneCallback done) {
                [apiManager getHistoryOfContentsWithCount:13
                                                   offset:0
                                                  success:^(NSArray *historyArray) {
                                                      expect([historyArray count]).to.equal(0);
                                                      done();
                                                  }
                                                  failure:^(NSError *error) {
                                                      NSLog(@"Error: %@",error);
                                                      expect(error.localizedDescription).to.equal(@"Invalid request for anonymous user");
                                                      done();
                                                      
                                                  }];
            });
            
        });
        
        it(@"should not be able to get content history array with count and offset",^{
            waitUntil(^(DoneCallback done) {
                [apiManager getHistoryOfContentsWithCount:13
                                                   offset:8
                                                  success:^(NSArray *historyArray) {
                                                      expect([historyArray count]).to.equal(0);
                                                      done();
                                                  }
                                                  failure:^(NSError *error) {
                                                      NSLog(@"Error: %@",error);
                                                      expect(error.localizedDescription).to.equal(@"Invalid request for anonymous user");
                                                      done();
                                                  }];
            });
            
        });
        
        it(@"should not be able to get content history array with wrong count and offset",^{
            waitUntil(^(DoneCallback done) {
                [apiManager getHistoryOfContentsWithCount:-56
                                                   offset:-34
                                                  success:^(NSArray *historyArray) {
                                                      expect([historyArray count]).to.equal(0);
                                                      done();
                                                  }
                                                  failure:^(NSError *error) {
                                                      NSLog(@"Error: %@",error);
                                                      expect(error.localizedDescription).to.equal(@"Invalid request for anonymous user");
                                                      done();
                                                      
                                                  }];
            });
            
        });
        
        it(@"should not be able to get comment history array with default parameters",^{
            waitUntil(^(DoneCallback done) {
                [apiManager getHistoryOfCommentsWithCount:0
                                                   offset:0
                                                  success:^(NSArray *historyArray) {
                                                      expect([historyArray count]).to.equal(0);
                                                      done();
                                                  }
                                                  failure:^(NSError *error) {
                                                      NSLog(@"Error: %@",error);
                                                      expect(error.localizedDescription).to.equal(@"Invalid request for anonymous user");
                                                      done();
                                                      
                                                  }];
            });
            
        });
        
        it(@"should not be able to get comment history array with count",^{
            waitUntil(^(DoneCallback done) {
                [apiManager getHistoryOfCommentsWithCount:13
                                                   offset:0
                                                  success:^(NSArray *historyArray) {
                                                      expect([historyArray count]).to.equal(0);
                                                      done();
                                                  }
                                                  failure:^(NSError *error) {
                                                      NSLog(@"Error: %@",error);
                                                      expect(error.localizedDescription).to.equal(@"Invalid request for anonymous user");
                                                      done();
                                                      
                                                  }];
            });
            
        });
        
        it(@"should not be able to get comment history array with count and offset",^{
            waitUntil(^(DoneCallback done) {
                [apiManager getHistoryOfCommentsWithCount:13
                                                   offset:8
                                                  success:^(NSArray *historyArray) {
                                                      expect([historyArray count]).to.equal(0);
                                                      done();
                                                  }
                                                  failure:^(NSError *error) {
                                                      NSLog(@"Error: %@",error);
                                                      expect(error.localizedDescription).to.equal(@"Invalid request for anonymous user");
                                                      done();
                                                      
                                                  }];
            });
            
        });
        
        it(@"should not be able to get comment history array with wrong count and offset",^{
            waitUntil(^(DoneCallback done) {
                [apiManager getHistoryOfCommentsWithCount:-56
                                                   offset:-34
                                                  success:^(NSArray *historyArray) {
                                                      expect([historyArray count]).to.equal(0);
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

describe(@"History", ^{
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
        
        it(@"should be able to get content history array with default parameters",^{
            waitUntil(^(DoneCallback done) {
                [apiManager getHistoryOfContentsWithCount:0
                                                   offset:0
                                                  success:^(NSArray *historyArray) {
                                                      expect([historyArray count]).to.equal(20);
                                                      done();
                                                  }
                                                  failure:^(NSError *error) {
                                                      NSLog(@"Error: %@",error);
                                                      expect(error).to.beNil();
                                                      done();
                                                  }];
            });
            
        });
        
        it(@"should be able to get content history array with count",^{
            waitUntil(^(DoneCallback done) {
                [apiManager getHistoryOfContentsWithCount:13
                                                   offset:0
                                                  success:^(NSArray *historyArray) {
                                                      expect([historyArray count]).to.equal(13);
                                                      done();
                                                  }
                                                  failure:^(NSError *error) {
                                                      NSLog(@"Error: %@",error);
                                                      expect(error).to.beNil();
                                                      done();
                                                  }];
            });
            
        });
        
        it(@"should be able to get content history array with count and offset",^{
            waitUntil(^(DoneCallback done) {
                [apiManager getHistoryOfContentsWithCount:16
                                                   offset:8
                                                  success:^(NSArray *historyArray) {
                                                      expect([historyArray count]).to.equal(16);
                                                      done();
                                                  }
                                                  failure:^(NSError *error) {
                                                      NSLog(@"Error: %@",error);
                                                      expect(error).to.beNil();
                                                      done();
                                                  }];
            });
            
        });
        
        it(@"should be able to get content history array with wrong count and offset",^{
            waitUntil(^(DoneCallback done) {
                [apiManager getHistoryOfContentsWithCount:-56
                                                   offset:-34
                                                  success:^(NSArray *historyArray) {
                                                      expect([historyArray count]).to.equal(20);
                                                      done();
                                                  }
                                                  failure:^(NSError *error) {
                                                      NSLog(@"Error: %@",error);
                                                      expect(error).to.beNil();
                                                      done();
                                                  }];
            });
            
        });
        
        it(@"should be able to get comment history array with default parameters",^{
            waitUntil(^(DoneCallback done) {
                [apiManager getHistoryOfCommentsWithCount:0
                                                   offset:0
                                                  success:^(NSArray *historyArray) {
                                                      expect([historyArray count]).to.equal(20);
                                                      done();
                                                  }
                                                  failure:^(NSError *error) {
                                                      NSLog(@"Error: %@",error);
                                                      expect(error).to.beNil();
                                                      done();
                                                  }];
            });
            
        });
        
        it(@"should be able to get comment history array with count",^{
            waitUntil(^(DoneCallback done) {
                [apiManager getHistoryOfCommentsWithCount:11
                                                   offset:0
                                                  success:^(NSArray *historyArray) {
                                                      expect([historyArray count]).to.equal(11);
                                                      done();
                                                  }
                                                  failure:^(NSError *error) {
                                                      NSLog(@"Error: %@",error);
                                                      expect(error).to.beNil();
                                                      done();
                                                  }];
            });
            
        });
        
        it(@"should be able to get comment history array with count and offset",^{
            waitUntil(^(DoneCallback done) {
                [apiManager getHistoryOfCommentsWithCount:12
                                                   offset:8
                                                  success:^(NSArray *historyArray) {
                                                      expect([historyArray count]).to.equal(12);
                                                      done();
                                                  }
                                                  failure:^(NSError *error) {
                                                      NSLog(@"Error: %@",error);
                                                      expect(error).to.beNil();
                                                      done();
                                                  }];
            });
            
        });
        
        it(@"should be able to get comment history array with wrong count and offset",^{
            waitUntil(^(DoneCallback done) {
                [apiManager getHistoryOfCommentsWithCount:-56
                                                   offset:-34
                                                  success:^(NSArray *historyArray) {
                                                      expect([historyArray count]).to.equal(20);
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
