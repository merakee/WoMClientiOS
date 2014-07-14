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

#pragma mark - Error Handling methods - Session and Registration
+ (NSError *)getErrorForSignInSaveUser{
    return [ApiErrorManager getErrorWithDomain:kAppErrorDomainApi
                                          code:kAPIManagerErrorInvalidSignUp
                                   description:@"Internal Error"
                                        reason:@"Failed to save user in DB"
                                    suggestion:@"Please let us know if this happens again"];
}

+ (NSError *)processSignUpError:(NSError *)error{
    NSLog(@"Localized Error: %@",[error  localizedDescription]);
    NSLog(@"User Info: %@",[error  userInfo][JSONResponseSerializerWithDataKey]);
    
    return error;
}
+ (NSError *)processSignInError:(NSError *)error{
    return error;
}

+ (NSError *)processSignOutError:(NSError *)error{
    return error;
}


#pragma mark - Error Handling methods - Content
+ (NSError *)processGetContentError:(NSError *)error{
    return error;
}

+ (NSError *)processPostContentError:(NSError *)error{
    return error;
}


#pragma mark - Error Handling methods - Response
+ (NSError *)processPostResponseError:(NSError *)error{
    return error;
}



#pragma mark - Error Handling methods - User Info
+ (NSError *)processGetProfileError:(NSError *)error{
    return error;
}

+ (NSError *)processUpdateProfileError:(NSError *)error{
    return error;
}


@end
