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
static const int kAPIValidationContentMinLentgh = 2;
static const int kAPIValidationContentMaxLentgh = 530;

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
+ (NSError *)validatePostCotentWithCategoryId:(int)categoryId
                                          text:(NSString *)text;
#pragma mark - user validation methods


@end
