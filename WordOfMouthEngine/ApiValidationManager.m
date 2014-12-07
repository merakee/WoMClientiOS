//
//  ApiValidationManager.m
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 7/15/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import "ApiValidationManager.h"

@implementation ApiValidationManager

#pragma mark - core validation methods
+ (NSString *)isUserTypeIdValid:(int)userTypeId{
    if(userTypeId!= kAPIUserTypeAnonymous && userTypeId!= kAPIUserTypeWom){
        return @"Unknown User Type";
    }
    
    return nil;
}
+ (NSString *)isEmailValid:(NSString *)email{
    if([email length]==0){
        return @"Email is empty";
    }
    
    //Create a regex string
    NSString *stricterFilterString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}" ;
    
    //Create predicate with format matching your regex string
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:
                              @"SELF MATCHES %@", stricterFilterString];
    
    //true if email address is valid
    if(![emailTest evaluateWithObject:email]){
        return @"Email is not valid";
    }
    
    return nil;
}
+ (NSString *)isPasswordValid:(NSString *)password{
    if([password length]<kAPIValidationPasswordMinLentgh){
        return [NSString stringWithFormat:@"Password must be at least %d charecter long",kAPIValidationPasswordMinLentgh];
    }
    return nil;
}
+ (NSString *)doesPassword:(NSString *)password matchConfirmation:(NSString *)passwordConfirmation{
    if(![password isEqualToString:passwordConfirmation]){
        return @"Password confirmation must match password";
    }
    return nil;
}
+ (NSString *)isContentTextValid:(NSString *)text{
    if([text length]<kAPIValidationContentMinLength){
        return [NSString stringWithFormat:@"Text must be at least %d charecter long",kAPIValidationContentMinLength];
    }
    if([text length]>kAPIValidationContentMaxLength){
        return [NSString stringWithFormat:@"Text must be shoter than %d charecter long",kAPIValidationContentMaxLength];
    }
    
    return nil;
}
+ (NSString *)isContentCategoryValid:(int)categoryId{
    if(categoryId != kAPIContentCategoryRumor &&
       categoryId != kAPIContentCategorySecret &&
       categoryId != kAPIContentCategoryLocalInfo &&
       categoryId != kAPIContentCategoryNews){
        return @"Please select a content type.";
    }
    return nil;
}

+ (NSString *)isCommentTextValid:(NSString *)text{
    if([text length]<kAPIValidationCommentMinLength){
        return [NSString stringWithFormat:@"Text must be at least %d charecter long",kAPIValidationCommentMinLength];
    }
    if([text length]>kAPIValidationCommentMaxLength){
        return [NSString stringWithFormat:@"Text must be shoter than %d charecter long",kAPIValidationCommentMaxLength];
    }
    
    return nil;
}


#pragma mark - sign up validation methods
+ (NSError *)validateSignUpWithUserTypeId:(int)userTypeId
                                    email:(NSString *)email
                                 password:(NSString *)password
                     passwordConfirmation:(NSString *)passwordConfirmation{
    
    
    // check if anomymou user
    if(userTypeId==kAPIUserTypeAnonymous){
        return nil;
        
    }
    
    NSMutableString * reason = [[NSMutableString alloc] initWithString:@""];
    NSString *msg = [ApiValidationManager isUserTypeIdValid:userTypeId];
    if(msg){
        [reason appendFormat:@"%@\n",msg];
    }
    
    msg = [ApiValidationManager isEmailValid:email];
    if(msg){
        [reason appendFormat:@"%@\n",msg];
    }
    
    msg = [ApiValidationManager isPasswordValid:password];
    if(msg){
        [reason appendFormat:@"%@\n",msg];
    }
    
    msg = [ApiValidationManager doesPassword:password matchConfirmation:passwordConfirmation];
    if(msg){
        [reason appendFormat:@"%@\n",msg];
    }
    
    if([reason length]==0){
        return nil;
    }
    
    return [ApiErrorManager getErrorWithDomain:kAppErrorDomainApi
                                          code:kAPIManagerErrorValidation
                                   description:@"Invalid Input"
                                        reason:[reason stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]]     // drop last new line
                                    suggestion:@"Please check and try again"];
}

#pragma mark - sign in validation methods
+ (NSError *)validateSignInWithUserTypeId:(int)userTypeId
                                    email:(NSString *)email
                                 password:(NSString *)password{
    
    // check if anomymou user
    if(userTypeId==kAPIUserTypeAnonymous){
        return nil;
    }
    
    NSMutableString * reason = [[NSMutableString alloc] initWithString:@""];
    NSString *msg = [ApiValidationManager isUserTypeIdValid:userTypeId];
    if(msg){
       [reason appendFormat:@"%@\n",msg];
    }
    if(userTypeId==kAPIUserTypeAnonymous){
        return nil;
    }
    
    msg = [ApiValidationManager isEmailValid:email];
    if(msg){
        [reason appendFormat:@"%@\n",msg];
    }
    
    msg = [ApiValidationManager isPasswordValid:password];
    if(msg){
        [reason appendFormat:@"%@\n",msg];
    }
    
    if([reason length]==0){
        return nil;
    }
    
    return [ApiErrorManager getErrorWithDomain:kAppErrorDomainApi
                                          code:kAPIManagerErrorValidation
                                   description:@"Invalid Input"
                                        reason:[reason stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]]     // drop last new line
                                    suggestion:@"Please check and try again"];
}
#pragma mark - content validation methods
+ (NSError *)validatePostContentWithCategoryId:(int)categoryId
                                          text:(NSString *)text andPhoto:(UIImage *)photo{
    if(photo){
        return nil; 
    }
    NSMutableString * reason = [[NSMutableString alloc] initWithString:@""];
    NSString *msg = [ApiValidationManager isContentCategoryValid:categoryId];
    if(msg){
         [reason appendFormat:@"%@\n",msg];
    }
    msg = [ApiValidationManager isContentTextValid:text];
    if(msg){
        [reason appendFormat:@"%@\n",msg];
    }
    
    if([reason length]==0){
        return nil;
    }
    
    return [ApiErrorManager getErrorWithDomain:kAppErrorDomainApi
                                          code:kAPIManagerErrorValidation
                                   description:@"Invalid Input"
                                        reason:[reason stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]]     // drop last new line
                                    suggestion:@"Please check and try again"];
}
#pragma mark - user validation methods

#pragma mark - comment validation methods
+ (NSError *)validatePostCommentWithText:(NSString *)text{
    NSMutableString * reason = [[NSMutableString alloc] initWithString:@""];
    NSString *msg = [ApiValidationManager isCommentTextValid:text];
    if(msg){
        [reason appendFormat:@"%@\n",msg];
    }
    
    if([reason length]==0){
        return nil;
    }
    
    return [ApiErrorManager getErrorWithDomain:kAppErrorDomainApi
                                          code:kAPIManagerErrorValidation
                                   description:@"Invalid Input"
                                        reason:[reason stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]]     // drop last new line
                                    suggestion:@"Please check and try again"];
    
}


@end
