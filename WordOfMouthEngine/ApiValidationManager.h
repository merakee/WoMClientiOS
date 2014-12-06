//
//  ApiValidationManager.h
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 7/15/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ApiUser.h"
#import "ApiContent.h"
#import "ApiErrorManager.h"

static const int kAPIValidationPasswordMinLentgh = 8;
static const int kAPIValidationContentMinLength = 1;
static const int kAPIValidationContentMaxLength = 250;
static const int kAPIValidationCommentMinLength = 1;
static const int kAPIValidationCommentMaxLength = 250;

@interface ApiValidationManager : NSObject

#pragma mark - sign up validation methods
+ (NSError *)validateSignUpWithUserTypeId:(int)userTypeId
                                    email:(NSString *)email
                                 password:(NSString *)password
                     passwordConfirmation:(NSString *)passwordConfirmation;
#pragma mark - sign in validation methods
+ (NSError *)validateSignInWithUserTypeId:(int)userTypeId
                                    email:(NSString *)email
                                 password:(NSString *)password;
#pragma mark - content validation methods
+ (NSError *)validatePostContentWithCategoryId:(int)categoryId
                                          text:(NSString *)text
                                      andPhoto:(UIImage *)photo;

#pragma mark - comment validation methods
+ (NSError *)validatePostCommentWithText:(NSString *)text;

#pragma mark - user validation methods


@end
