//
//  TestHelper.m
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 7/17/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import "TestHelper.h"
#import "ApiUserDatabase.h"
#import "CommonUtility.h"
#import "PlaceHolderFactory.h"

@implementation TestHelper

#pragma mark - Context helpers
+ (BOOL)startContext:(NSString *)context{
    
    return false;
}
+ (BOOL)stopContext:(NSString *)context{
    
    return false;
}

#pragma mark - Misc Helpers: Session
+ (BOOL)signInAnonymousUser{
    __block BOOL isSuccess=false;
    StartAsyncBlock();
    [[ApiManager sharedApiManager] signInUserWithUserTypeId:kAPIUserTypeAnonymous
                                                      email:nil
                                                   password:nil
                                                    success:^(){
                                                        isSuccess=true;
                                                        StopAsyncBlock();
                                                    }
                                                    failure:^(NSError *error){
                                                        isSuccess=false;
                                                        StopAsyncBlock();
                                                    }];
    
    // Run the Wait loop
    WaitUntilAsyncBlockCompletes();
    
    return isSuccess;
}
+ (BOOL)signInUser:(ApiUser *)user{
    __block BOOL isSuccess=false;
    StartAsyncBlock();
    [[ApiManager sharedApiManager]  signInUserWithUserTypeId:user.userTypeId.intValue
                                                       email:user.email
                                                    password:@"password"
                                                     success:^(){
                                                         isSuccess=true;
                                                         StopAsyncBlock();
                                                     }
                                                     failure:^(NSError *error){
                                                         isSuccess=false;
                                                         StopAsyncBlock();
                                                     }];
    
    // Run the Wait loop
    WaitUntilAsyncBlockCompletes();
    
    return isSuccess;
}
+ (BOOL)signOutAnonymousUser{
    [ApiManager sharedApiManager].apiUserManager.currentUser = nil;
    return true;
}
+ (BOOL)signOutUser{
    BOOL isDone = [[[ApiUserDatabase alloc] init] deleteUserInfo];
    [ApiManager sharedApiManager].apiUserManager.currentUser = nil;
    return isDone;
}
+ (BOOL)signOutAndDeleteAnonymousUser{
    BOOL isDone = [[[ApiUserDatabase alloc] init] deleteAnonymousUserInfo];
    return isDone && [TestHelper signOutAnonymousUser];
}
+ (BOOL)signOutAllUsers{
    return [TestHelper signOutAnonymousUser] && [TestHelper signOutUser];
}
+ (BOOL)signOutAndDeleteAllUsers{
    return [TestHelper signOutUser] && [TestHelper   signOutAndDeleteAllUsers];
}


#pragma mark - Misc Helpers: Content and User
+ (BOOL)createContentsWithCount:(int)count{
    __block BOOL isDone=[TestHelper signInAnonymousUser];
    
    for(int ind=0;ind<count;ind++){
        if(!isDone){
            break;
        }
        
        StartAsyncBlock();
        [[ApiManager sharedApiManager]     postContentWithCategoryId:[CommonUtility pickRandom:4]+1
                                                                text:[PlaceHolderFactory sentencesWithNumber:2]
                                                               photo:nil
                                                             success:^(ApiContent * content){
                                                                 StopAsyncBlock();
                                                             }
                                                             failure:^(NSError *error){
                                                                 isDone = false;
                                                                 StopAsyncBlock();
                                                             }];
        
        // Run the Wait loop
        WaitUntilAsyncBlockCompletes();
        
    }
    
    return isDone;
}
+ (BOOL)createUSersWithCount:(int)count{
    BOOL isDone= [TestHelper signInAnonymousUser];
    for(int ind=0;ind<count;ind++){
        if(!isDone){
            break;
        }
        
    }
    return isDone;
}
@end
