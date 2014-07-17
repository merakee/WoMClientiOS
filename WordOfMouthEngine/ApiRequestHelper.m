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
    if(!user){return @{};}
    if(user.userTypeId==nil){user.userTypeId=[NSNumber numberWithInt:kAPIUserTypeOthers];}
    if (user.email==nil){user.email=@"";}
    if(user.authenticationToken==nil){user.authenticationToken=@"";}
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

#pragma mark - user info from response
+ (ApiUser *)getUserFromDictionary:(NSDictionary *)userDic{
    return [[ApiUser alloc] initWithUserId:userDic[@"user"][@"id"]
                                userTypeId:userDic[@"user"][@"user_type_id"]
                                     email:userDic[@"user"][@"email"]
                       authenticationToken:userDic[@"user"][@"authentication_token"]
                                  signedIn:@YES];
}

#pragma mark - content info from response
+ (NSArray *)getContentArrayFromDictionary:(NSDictionary *)contentsDic{
    NSMutableArray *contentArray =[[NSMutableArray alloc] init];
    
    for (NSDictionary *contentDic in contentsDic[@"contents"]){
        ApiContent *content =[ApiRequestHelper getContentFromDictionaryWithOutRoot:contentDic];
        if([ApiContent isValidContent:content]){
            [contentArray addObject:content];
        }
        else{
            return nil;
        }
    }
    return (NSArray *)contentArray;
}
+ (ApiContent *)getContentFromDictionary:(NSDictionary *)contentDic{
    return [ApiRequestHelper getContentFromDictionaryWithOutRoot:contentDic[@"content"]];
}
+ (ApiContent *)getContentFromDictionaryWithOutRoot:(NSDictionary *)contentDic{
    return [[ApiContent alloc] initWithContentId:contentDic[@"id"]
                                            text:contentDic[@"text"]
                                          userId:contentDic[@"user_id"]
                                      categoryId:contentDic[@"content_category_id"]
                                      photoToken:contentDic[@"photo_token"]
                                       timeStamp:contentDic[@"created_at"]
                                     totalSpread:contentDic[@"total_spread"]
                                     spreadCount:contentDic[@"spread_count"]
                                       killCount:contentDic[@"kill_count"]
                                 noResponseCount:contentDic[@"no_response_count"]];
}
#pragma mark - content info from response
+ (ApiUserResponse *)getUserResponseFromDictionary:(NSDictionary *)userResponseDic{
    return [[ApiUserResponse alloc] initWithUserId:userResponseDic[@"user_response"][@"user_id"]
                                         contentId:userResponseDic[@"user_response"][@"content_id"]
                                      userResponse:userResponseDic[@"user_response"][@"response"] ];
}

@end
