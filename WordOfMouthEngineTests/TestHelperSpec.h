//
//  TestHelperSpec.m
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 12/1/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import "SpectaSetUp.h"
#import "ApiManager.h"
#import "PlaceHolderFactory.h"

@interface TestHelperSpec : NSObject

#pragma mark - Helper functions: Session
+(bool)signInUserWithEmail:(NSString *)email andPassword:(NSString *)password;
+(bool)signUpUserWithEmail:(NSString *)email andPassword:(NSString *)password;
+(bool)signOutUser;

#pragma mark - Helper functions: Content
+(int)postContent;

#pragma mark - Helper functions: Comment
+(int)postCommtentForContent:(int) contentId;

#pragma mark - Helper functions: Comment Like
+(int)likeCommtentWithId:(int) commentId;

@end
