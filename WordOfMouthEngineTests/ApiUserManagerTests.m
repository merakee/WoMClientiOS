//
//  ApiUserManagerTests.m
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 7/8/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import "SpectaSetUp.h"
#import "ApiUserManager.h"


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

SpecBegin(ApiUserManager)

describe(@"ApiUserManager", ^{
    
    // set up all variables
    __block ApiUserManager      *aum;
    __block ApiUser *user, *auser;
    __block ApiUserDatabase *uid;
    
    //    sharedExamplesFor(@"another shared behavior", ^(NSDictionary *data) {
    //        // Locally defined shared examples can override global shared examples within its scope.
    //    });
    
    beforeAll(^{
        // This is run once and only once before all of the examples
        // in this group and before any beforeEach blocks.
        uid =[[ApiUserDatabase alloc] init];
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
    });
    
    beforeEach(^{
        // This is run before each example.
        aum =[[ApiUserManager alloc] init];
    });
    afterEach(^{
        // This is run after each example.
        aum=nil;
        [uid deleteUserInfo];
        [uid deleteAnonymousUserInfo];
    });
    
    afterAll(^{
        // This is run once and only once after all of the examples
        // in this group and after any afterEach blocks.
    });
    
    describe(@"With no user", ^{
        it(@"should return nil user",^{
            // check if the user is nil
            expect(aum.currentUser).to.beFalsy();
            expect([aum isUserSignedIn]).to.beFalsy();
        });
        
        it(@"should set current user info",^{
            aum.currentUser = user;
            expect([aum isUserSignedIn]).to.beTruthy();
            aum.currentUser.signedIn=@NO;
            expect([aum isUserSignedIn]).to.beFalsy();
            aum.currentUser.signedIn=@YES;
            aum.currentUser.authenticationToken=@"";
            expect([aum isUserSignedIn]).to.beFalsy();
            aum.currentUser.authenticationToken=nil;
            expect([aum isUserSignedIn]).to.beFalsy();
            aum.currentUser.authenticationToken=@"sdlfasdfdshfdlghf";
            aum.currentUser.email=@"";
            expect([aum isUserSignedIn]).to.beFalsy();
            aum.currentUser.email=nil;
            expect([aum isUserSignedIn]).to.beFalsy();
            aum.currentUser.email=@"dfasdh";
            expect([aum isUserSignedIn]).to.beTruthy();
            
        });
    });
    
    describe(@"With saved user", ^{
        it(@"should have valid current user",^{
            [uid saveUserInfo:user];
            aum =[[ApiUserManager alloc] init];
            expect(aum.currentUser).to.beTruthy();
            expect([aum isUserSignedIn]).to.beTruthy();
            expect(aum.currentUser.userTypeId.integerValue).to.equal(user.userTypeId.integerValue);
            expect(aum.currentUser.email).to.equal(user.email);
            expect(aum.currentUser.authenticationToken).to.equal(user.authenticationToken);
            expect(aum.currentUser.signedIn).to.equal(user.signedIn);
        });
        
    });
    
    describe(@"With saved anonymous user", ^{
        it(@"should not have valid current user",^{
            [uid saveAnonymousUserInfo:auser];
            aum =[[ApiUserManager alloc] init];
            expect(aum.currentUser).to.beFalsy();
            expect([aum isUserSignedIn]).to.beFalsy();
        });
        
    });
    
    describe(@"User sign in and sign out",^{
        it(@"should have valid current user",^{
            
            // check if the user is nil
            expect(aum.currentUser).to.beFalsy();
        });
        
        it(@"should sign in user",^{
            
            // sign in user
            expect([aum signInUser:user]).to.beTruthy();
            // check if the user is nil
            expect(aum.currentUser).to.beTruthy();
            expect([aum isUserSignedIn]).to.beTruthy();
            expect(aum.currentUser.userTypeId.integerValue).to.equal(user.userTypeId.integerValue);
            expect(aum.currentUser.email).to.equal(user.email);
            expect(aum.currentUser.authenticationToken).to.equal(user.authenticationToken);
            expect(aum.currentUser.signedIn).to.equal(user.signedIn);
        });
        
        
        it(@"should sign out user",^{
            
            expect([aum signOutUser]).to.beTruthy();
            // check if the user is nil
            expect(aum.currentUser).to.beFalsy();
            expect([aum isUserSignedIn]).to.beFalsy();
            
        });
        
        
    });
    
    describe(@"Anonymous User sign in and sign out",^{
        
        [uid deleteUserInfo];
        
        it(@"should have valid current user",^{
            [uid saveAnonymousUserInfo:auser];
            
            // check if the user is nil
            expect(aum.currentUser).to.beFalsy();
        });
        
        it(@"should sign in user",^{
            [uid saveAnonymousUserInfo:auser];
            
            // sign in user
            expect([aum signInAnonymousUser]).to.beTruthy();
            // check if the user is nil
            expect(aum.currentUser).to.beTruthy();
            expect([aum isUserSignedIn]).to.beTruthy();
            expect(aum.currentUser.userTypeId.integerValue).to.equal(auser.userTypeId.integerValue);
            expect(aum.currentUser.email).to.equal(auser.email);
            expect(aum.currentUser.authenticationToken).to.equal(auser.authenticationToken);
            expect(aum.currentUser.signedIn).to.equal(auser.signedIn);
        });
        
        
        it(@"should sign out user",^{
            [uid saveAnonymousUserInfo:auser];
            
            expect([aum signOutUser]).to.beTruthy();
            // check if the user is nil
            expect(aum.currentUser).to.beTruthy();
            expect([aum isUserSignedIn]).to.beFalsy();
        });
        it(@"should sign in user",^{
            [uid saveAnonymousUserInfo:auser];
            
            // sign in user
            expect([aum signInUser:user]).to.beTruthy();
            // check if the user is nil
            expect(aum.currentUser).to.beTruthy();
            expect([aum isUserSignedIn]).to.beTruthy();
            expect(aum.currentUser.userTypeId.integerValue).to.equal(user.userTypeId.integerValue);
            expect(aum.currentUser.email).to.equal(user.email);
            expect(aum.currentUser.authenticationToken).to.equal(user.authenticationToken);
            expect(aum.currentUser.signedIn).to.equal(user.signedIn);
        });
        it(@"should sign out user",^{
            [uid saveAnonymousUserInfo:auser];
            
            expect([aum signOutUser]).to.beTruthy();
            // check if the user is nil
            expect(aum.currentUser).to.beFalsy();
            expect([aum isUserSignedIn]).to.beFalsy();
            
        });
    });
    
    
});

SpecEnd
