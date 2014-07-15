//
//  ApiErrorManager.m
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 7/11/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import "ApiErrorManager.h"
#import "JSONResponseSerializerWithData.h"

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
+ (NSError *)getErrorForSignInSaveUser{
    return [ApiErrorManager getErrorWithDomain:kAppErrorDomainApi
                                          code:kAPIManagerErrorInvalidSignUp
                                   description:@"Internal Error"
                                        reason:@"Failed to save user in DB"
                                    suggestion:@"Please let us know if this happens again"];
}

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


#pragma mark - Error Handling methods - Response
+ (NSError *)processPostResponseError:(NSError *)error{
    return [ApiErrorManager getErrorWithDomain:kAppErrorDomainApi
                                          code:kAPIManagerErrorApi
                                   description:@"Post Response Error"
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


@end
