//
//  ApiRequestHelper.m
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 7/14/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import "ApiRequestHelper.h"

@implementation ApiRequestHelper

#pragma mark -  Utility Methods: JSON Request
+(NSDictionary *)userSignUpParamsWithUserTypeId:(int)userTypeId email:(NSString *)email password:(NSString *)password andPasswordConfirmation:(NSString *)passwordConfirmation{
    if (email==nil){email=@"";}
    if(password==nil){password=@"";}
    if(passwordConfirmation==nil){passwordConfirmation=@"";}
    return @{@"user":@{
                     @"user_type_id": [NSNumber numberWithInt:userTypeId],
                     @"email":email,
                     @"password":password,
                     @"password_confirmation":passwordConfirmation}};
}
+(NSDictionary *)userSignInParamsWithEmail:(NSString *)email andPassword:(NSString *)password{
    if (email==nil){email=@"";}
    if(password==nil){password=@"";}
    return @{@"user":@{
                     @"email":email,
                     @"password":password}};
}
+(NSDictionary *)userAuthenticationParams:(ApiUser *)user{
    return @{@"user":@{
                     @"user_type_id": user.userTypeId,
                     @"email":user.email,
                     @"authentication_token":user.authenticationToken}};
}
+(NSDictionary *)contentParamsWithUser:(ApiUser *)user categoryId:(int)categoryId andtext:(NSString *)text{
    return [self addUserAuth:user toDictionary:@{@"content":@{
                                                   @"content_category_id": [NSNumber numberWithInt:categoryId],
                                                   @"text":text}}];
}
+(NSDictionary *)responseParamsWith:(ApiUser *)user contentId:(int)contentId andResponse:(NSNumber *)response{
    return [self addUserAuth:user  toDictionary:@{@"content":@{
                                                   @"content_id": [NSNumber numberWithInt:contentId],
                                                   @"response":response}}];
}
+(NSDictionary *)addUserAuth:(ApiUser *)user toDictionary:(NSDictionary *)infoDictionary{
    NSMutableDictionary *dictionaryWithUserAuth = [[NSMutableDictionary alloc] initWithDictionary:infoDictionary];
    [dictionaryWithUserAuth addEntriesFromDictionary:[ApiRequestHelper userAuthenticationParams:user]];
    return (NSDictionary *)dictionaryWithUserAuth;
}
+ (ApiUser *)getUserFromDictionary:(NSDictionary *)userInfo{
    return [[ApiUser alloc] initWithTypeId:userInfo[@"user"][@"user_type_id"]
                                     email:userInfo[@"user"][@"email"]
                       authenticationToken:userInfo[@"user"][@"authentication_key"]
                                  signedIn:@YES];
}

@end
