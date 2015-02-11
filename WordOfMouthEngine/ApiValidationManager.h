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

/*!
 *  @brief Minimum length for password
 */
static const int kAPIValidationPasswordMinLentgh = 8;
/*!
 *  @brief Minimum length for content text
 */
static const int kAPIValidationContentMinLength = 1;
/*!
 *  @brief Maximum length for content text
 */
static const int kAPIValidationContentMaxLength = 250;
/*!
 *  @brief Minimum length for Comment
 */
static const int kAPIValidationCommentMinLength = 1;
/*!
 *  @brief Maximum length for Comment
 */
static const int kAPIValidationCommentMaxLength = 400;
/*!
 *  @brief Minimum length for Nickname
 */
static const int kAPIValidationNicknameMinLentgh = 2;
/*!
 *  @brief Maximum length for Nickname
 */
static const int kAPIValidationNicknameMaxLentgh = 17;
/*!
 *  @brief Minimum length for Bio
 */
static const int kAPIValidationBioMinLentgh = 1;
/*!
 *  @brief Maximum length for Bio
 */
static const int kAPIValidationBioMaxLentgh = 100;
/*!
 *  @brief Minimum length for Hometown
 */
static const int kAPIValidationHometownMinLentgh = 1;
/*!
 *  @brief Maximumlength for Hometown
 */
static const int kAPIValidationHometownMaxLentgh = 40;

@interface ApiValidationManager : NSObject

#pragma mark - sign up validation methods
+ (NSError *)validateSignUpWithUserTypeId:(int)userTypeId
                                    email:(NSString *)email
                                 password:(NSString *)password
                     passwordConfirmation:(NSString *)passwordConfirmation
                                 nickname:(NSString *)nickname
                                   avatar:(UIImage *)avatar
                                      bio:(NSString *)bio
                                 hometown:(NSString *)hometown;
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
