//
//  ApiErrorManager.h
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 7/11/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ApiErrorManager.h"

/*!
 *  APIManager error codes
 */
typedef enum {
    kAPIManagerErrorNone=0,
    kAPIManagerErrorInvalidSignUp,
    kAPIManagerErrorInvalidSignIn,
    kAPIManagerErrorInvalidSignOut,
    kAPIManagerErrorInvalidPassword,
    kAPIManagerErrorInternal,
    kAPIManagerErrorApi,
    kAPIManagerErrorValidation,
} kAPIManagerErrorCode;
// Error
static NSString *kAppErrorDomainApi =  @"AppErrorDomainApi";


@interface ApiErrorManager : NSObject

#pragma mark - Error Handling methods - Core
#pragma mark - Error Handling methods - Core
+ (NSError *)getErrorWithDomain:(NSString *)domain
                           code:(NSInteger)code
                    description:(NSString *)description
                         reason:(NSString *)reason
                     suggestion:(NSString *)suggestion;
+ (NSError *)getErrorForInvalidApiResponse;
+ (NSError *)getErrorForInternalError;

#pragma mark - Error Handling methods - Session and Registration
+ (NSError *)getErrorForSignInSaveUser;
+ (NSError *)processSignUpError:(NSError *)error;
+ (NSError *)processSignInError:(NSError *)error;
+ (NSError *)processSignOutError:(NSError *)error;

#pragma mark - Error Handling methods - Content
+ (NSError *)processGetContentError:(NSError *)error;
+ (NSError *)processPostContentError:(NSError *)error;

#pragma mark - Error Handling methods - Response
+ (NSError *)processPostResponseError:(NSError *)error;


#pragma mark - Error Handling methods - User Info
+ (NSError *)processGetProfileError:(NSError *)error;
+ (NSError *)processUpdateProfileError:(NSError *)error;

#pragma mark - Error Handling methods - Display Method
+ (void)displayAlertWithError:(NSError *)error withDelegate:(id)delegate;
@end
