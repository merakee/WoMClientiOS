//
//  UserInfoDatabaseTests.m
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 7/7/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import "SpectaSetUp.h"
#import "ApiUserDatabase.h"


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

SpecBegin(ApiUserDatabase)

describe(@"ApiUserDatabase", ^{
    
    // set up all variables
    __block ApiUserDatabase *uid;
    __block ApiUser *user;
    __block ApiUser *auser;
    
    //    sharedExamplesFor(@"another shared behavior", ^(NSDictionary *data) {
    //        // Locally defined shared examples can override global shared examples within its scope.
    //    });
    
    beforeAll(^{
        // This is run once and only once before all of the examples
        // in this group and before any beforeEach blocks.
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
    });
    
    beforeEach(^{
        // This is run before each example.
    });
    afterEach(^{
        // This is run after each example.
        [uid deleteUserInfo];
        [uid deleteAnonymousUserInfo];
    });
    
    afterAll(^{
        // This is run once and only once after all of the examples
        // in this group and after any afterEach blocks.
    });
    
    
    it(@"should save user", ^{
        // test regular user
        expect([uid saveUserInfo:user]).to.beTruthy();
    });
    
    it(@"should get the user info", ^{
        // test regular user
        expect([uid saveUserInfo:user]).to.beTruthy();
        ApiUser *user1=[uid getUser];
        expect(user.userId.integerValue).to.equal(user1.userId.integerValue);
        expect(user.userTypeId.integerValue).to.equal(user1.userTypeId.integerValue);
        expect(user.email).to.equal(user1.email);
        expect(user.authenticationToken).to.equal(user1.authenticationToken);
        expect(user.signedIn).to.equal(user1.signedIn);
        expect([uid deleteUserInfo]).to.beTruthy();
        
        expect([uid getUser]).to.beFalsy();
    });
    
    it(@"should save guest user", ^{
        // test regular user
        expect([uid saveAnonymousUserInfo:auser]).to.beTruthy();
    });
    
    it(@"should get the guest user info", ^{
        // test regular user
        expect([uid saveAnonymousUserInfo:auser]).to.beTruthy();
        ApiUser *user1=[uid getAnonymousUser];
        [ApiUser printApiUser:user1];
        expect(auser.userId.integerValue).to.equal(user1.userId.integerValue);
        expect(auser.userTypeId.integerValue).to.equal(user1.userTypeId.integerValue);
        expect(auser.email).to.equal(user1.email);
        expect(auser.authenticationToken).to.equal(user1.authenticationToken);
        expect(auser.signedIn).to.equal(user1.signedIn);
    });
    
    it(@"should isolate users", ^{
        // test regular user
        expect([uid saveUserInfo:user]).to.beTruthy();
        // test anonhhmous user
        expect([uid saveAnonymousUserInfo:auser]).to.beTruthy();
        // see regular user
        expect([uid getUser]).to.beTruthy();
        // delete regular user
        expect([uid deleteUserInfo]).to.beTruthy();
        // see regular user
        expect([uid getUser]).to.beFalsy();
        // see anon user
        expect([uid getAnonymousUser]).to.beTruthy();
        // test regular user
        expect([uid saveUserInfo:user]).to.beTruthy();
        // save anaon user
        expect([uid saveAnonymousUserInfo:auser]).to.beTruthy();
        // see regular user
        expect([uid getUser]).to.beTruthy();
        // see anon user
        expect([uid getAnonymousUser]).to.beTruthy();
    });
});

SpecEnd

