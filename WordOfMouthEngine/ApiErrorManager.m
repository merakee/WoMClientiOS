//
//  ApiErrorManager.m
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 7/11/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import "ApiErrorManager.h"
#import "JSONResponseSerializerWithData.h"
#import "CommonUtility.h"

@implementation ApiErrorManager

#pragma mark - Error Handling methods - Core
+ (NSError *)getErrorWithDomain:(NSString *)domain
                           code:(NSInteger)code
                    description:(NSString *)description
                         reason:(NSString *)reason
                     suggestion:(NSString *)suggestion{
    
    NSDictionary *userInfo = @{
                               NSLocalizedDescriptionKey: NSLocalizedString(description, nil),
                               NSLocalizedFailureReasonErrorKey: NSLocalizedString(reason, nil),
                               NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString(suggestion, nil)
                               };
    NSError *error = [NSError errorWithDomain:domain
                                         code:code
                                     userInfo:userInfo];
    
    return error;
}
+ (NSError *)getErrorForInvalidApiResponse{
    return [ApiErrorManager getErrorWithDomain:kAppErrorDomainApi
                                          code:kAPIManagerErrorInvalidSignUp
                                   description:@"Something Went Wrong"
                                        reason:@"Invalid Api Response"
                                    suggestion:@"Please try again."];
}
+ (NSError *)getErrorForInternalError{
    return [ApiErrorManager getErrorWithDomain:kAppErrorDomainApi
                                          code:kAPIManagerErrorInvalidSignUp
                                   description:@"Something Went Wrong"
                                        reason:@"Internal Error in the iOS client"
                                    suggestion:@"Please try again."];
}
+ (NSError *)getErrorForInvalidParameters{
    return [ApiErrorManager getErrorWithDomain:kAppErrorDomainApi
                                          code:kAPIManagerErrorInvalidParameters
                                   description:@"Invalid Parameters"
                                        reason:@"Internal Error in the iOS client"
                                    suggestion:@"Please try again."];
}

+ (NSError *)getErrorForSignInSaveUser{
    return [ApiErrorManager getErrorWithDomain:kAppErrorDomainApi
                                          code:kAPIManagerErrorInvalidSignUp
                                   description:@"Internal Error"
                                        reason:@"Failed to save user in DB"
                                    suggestion:@"Please let us know if this happens again"];
}

+ (NSError *)getErrorForInvalidRequestForAnonymousUser{
    return [ApiErrorManager getErrorWithDomain:kAppErrorDomainApi
                                          code:kAPIManagerErrorInvalidParameters
                                   description:@"Invalid request for anonymous user"
                                        reason:@"User must be singed in for this action"
                                    suggestion:@"Please try after user is signed in."];
}

#pragma mark - Error Unitilty methods
+ (NSString *)getErrorReasonFromError:(NSError *)error{
    NSDictionary *edic=nil;
    NSString *reason=@"";
    if(error&&[error  userInfo]&&[error  userInfo][JSONResponseSerializerWithDataKey]){
        edic = [error  userInfo][JSONResponseSerializerWithDataKey][@"message"];
    }
    
    if(edic){
        if([edic isKindOfClass:[NSDictionary class]]){
            NSMutableString *eString = [[NSMutableString alloc] init];
            for(NSString * key in edic){
                [eString appendString:[key capitalizedString]];
                if([edic[key] count]>=1){
                    [eString appendFormat:@" %@\n", edic[key][0]];
                }
            }
            // drop the last
            reason = [eString stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
        }
        if([edic isKindOfClass:[NSString class]]){
            reason = (NSString *)edic;
        }
    }
    else{
        reason = error.localizedDescription;
    }
    return  reason;
}

#pragma mark - Error Handling methods - Session and Registration
+ (NSError *)processSignUpError:(NSError *)error{
    return [ApiErrorManager getErrorWithDomain:kAppErrorDomainApi
                                          code:kAPIManagerErrorInvalidSignUp
                                   description:@"Sign Up Error"
                                        reason:[ApiErrorManager getErrorReasonFromError:error]
                                    suggestion:@"Please try again"];
}
+ (NSError *)processSignInError:(NSError *)error{
    return [ApiErrorManager getErrorWithDomain:kAppErrorDomainApi
                                          code:kAPIManagerErrorInvalidSignIn
                                   description:@"Sign In Error"
                                        reason:[ApiErrorManager getErrorReasonFromError:error]
                                    suggestion:@"Please try again"];
}

+ (NSError *)processSignOutError:(NSError *)error{
    return [ApiErrorManager getErrorWithDomain:kAppErrorDomainApi
                                          code:kAPIManagerErrorInvalidSignOut
                                   description:@"Sign Out Error"
                                        reason:[ApiErrorManager getErrorReasonFromError:error]
                                    suggestion:@"Please try again"];
}


#pragma mark - Error Handling methods - Content
+ (NSError *)processGetContentError:(NSError *)error{
    return [ApiErrorManager getErrorWithDomain:kAppErrorDomainApi
                                          code:kAPIManagerErrorApi
                                   description:@"Get Content Error"
                                        reason:[ApiErrorManager getErrorReasonFromError:error]
                                    suggestion:@"Please try again"];
}

+ (NSError *)processPostContentError:(NSError *)error{
    return [ApiErrorManager getErrorWithDomain:kAppErrorDomainApi
                                          code:kAPIManagerErrorApi
                                   description:@"Post Content Error"
                                        reason:[ApiErrorManager getErrorReasonFromError:error]
                                    suggestion:@"Please try again"];
}


#pragma mark - Error Handling methods - User Response
+ (NSError *)processPostResponseError:(NSError *)error{
    return [ApiErrorManager getErrorWithDomain:kAppErrorDomainApi
                                          code:kAPIManagerErrorApi
                                   description:@"Post Response Error"
                                        reason:[ApiErrorManager getErrorReasonFromError:error]
                                    suggestion:@"Please try again"];
}

#pragma mark - Error Handling methods - Content Flag
+ (NSError *)processFlagContentError:(NSError *)error{
    return [ApiErrorManager getErrorWithDomain:kAppErrorDomainApi
                                          code:kAPIManagerErrorApi
                                   description:@"Flag Content Error"
                                        reason:[ApiErrorManager getErrorReasonFromError:error]
                                    suggestion:@"Please try again"];
}
#pragma mark - Error Handling methods - Comment
+ (NSError *)processGetCommentError:(NSError *)error{
    return [ApiErrorManager getErrorWithDomain:kAppErrorDomainApi
                                          code:kAPIManagerErrorApi
                                   description:@"Get Comment Error"
                                        reason:[ApiErrorManager getErrorReasonFromError:error]
                                    suggestion:@"Please try again"];
}

+ (NSError *)processPostCommentError:(NSError *)error{
    return [ApiErrorManager getErrorWithDomain:kAppErrorDomainApi
                                          code:kAPIManagerErrorApi
                                   description:@"Post Comment Error"
                                        reason:[ApiErrorManager getErrorReasonFromError:error]
                                    suggestion:@"Please try again"];
}


#pragma mark - Error Handling methods - Comment Response
+ (NSError *)processPostCommentResponseError:(NSError *)error{
    return [ApiErrorManager getErrorWithDomain:kAppErrorDomainApi
                                          code:kAPIManagerErrorApi
                                   description:@"Post Comment Like Error"
                                        reason:[ApiErrorManager getErrorReasonFromError:error]
                                    suggestion:@"Please try again"];
}

#pragma mark - Error Handling methods - History
+ (NSError *)processGetHistoryError:(NSError *)error{
    return [ApiErrorManager getErrorWithDomain:kAppErrorDomainApi
                                          code:kAPIManagerErrorApi
                                   description:@"Get History Error"
                                        reason:[ApiErrorManager getErrorReasonFromError:error]
                                    suggestion:@"Please try again"];
}
#pragma mark - Error Handling methods - User Info
+ (NSError *)processGetProfileError:(NSError *)error{
    return [ApiErrorManager getErrorWithDomain:kAppErrorDomainApi
                                          code:kAPIManagerErrorApi
                                   description:@"Get Profile Error"
                                        reason:[ApiErrorManager getErrorReasonFromError:error]
                                    suggestion:@"Please try again"];
}

+ (NSError *)processUpdateProfileError:(NSError *)error{
    return [ApiErrorManager getErrorWithDomain:kAppErrorDomainApi
                                          code:kAPIManagerErrorApi
                                   description:@"Get Profile Error"
                                        reason:[ApiErrorManager getErrorReasonFromError:error]
                                    suggestion:@"Please try again"];
}

#pragma mark - Error Handling methods - Notification
+ (NSError *)processGetNotificationListError:(NSError *)error{
    return [ApiErrorManager getErrorWithDomain:kAppErrorDomainApi
                                          code:kAPIManagerErrorApi
                                   description:@"Get Notification Error"
                                        reason:[ApiErrorManager getErrorReasonFromError:error]
                                    suggestion:@"Please try again"];
}
+ (NSError *)processGetNotificationCountError:(NSError *)error{
    return [ApiErrorManager getErrorWithDomain:kAppErrorDomainApi
                                          code:kAPIManagerErrorApi
                                   description:@"Get Notification Count Error"
                                        reason:[ApiErrorManager getErrorReasonFromError:error]
                                    suggestion:@"Please try again"];
}

#pragma mark - Error Handling methods - Notification Reset
+ (NSError *)processResetNotificationContentError:(NSError *)error{
    return [ApiErrorManager getErrorWithDomain:kAppErrorDomainApi
                                          code:kAPIManagerErrorApi
                                   description:@"Reset Notification Content Error"
                                        reason:[ApiErrorManager getErrorReasonFromError:error]
                                    suggestion:@"Please try again"];
}
+ (NSError *)processResetNotificationCommentError:(NSError *)error{
    return [ApiErrorManager getErrorWithDomain:kAppErrorDomainApi
                                          code:kAPIManagerErrorApi
                                   description:@"Reset Notification Comment Error"
                                        reason:[ApiErrorManager getErrorReasonFromError:error]
                                    suggestion:@"Please try again"];
}

#pragma mark - Error Handling methods - Display Method
+ (void)displayAlertWithError:(NSError *)error withDelegate:(id)delegate{
    [CommonUtility displayAlertWithTitle:error.localizedDescription
                                 message:[[error.localizedFailureReason stringByAppendingString:@"\n"]
                                          stringByAppendingString:error.localizedRecoverySuggestion]
                                delegate:delegate];
}
+ (void)displayAlertForAnonymousUserCannotHaveProfileWithDelegate:(id)delegate{
    [CommonUtility displayAlertViewWithTitle:@"No Profile for Guest User"
                                     message:@"Please sign in to see profile."
                                cancelButton:@"cancel"
                               customButtons:[NSArray arrayWithObjects:@"sign in",nil]
                                    delegate:delegate];
}
@end
