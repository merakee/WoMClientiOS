//
//  ApiRequestHelper.m
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 7/14/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import "ApiRequestHelper.h"

@implementation ApiRequestHelper

#pragma mark -  Utility Methods: JSON Request - Session
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

+(NSDictionary *)addUserAuth:(ApiUser *)user toDictionary:(NSDictionary *)infoDictionary{
    NSMutableDictionary *dictionaryWithUserAuth = [[NSMutableDictionary alloc] initWithDictionary:infoDictionary];
    [dictionaryWithUserAuth addEntriesFromDictionary:[ApiRequestHelper userAuthenticationParams:user]];
    return (NSDictionary *)dictionaryWithUserAuth;
}

#pragma mark -  Utility Methods: JSON Request - Content
+(NSDictionary *)getContentParamsWithUser:(ApiUser *)user contentId:(int)contentId{
    return [self addUserAuth:user  toDictionary:@{@"params":@{@"content_id": [NSNumber numberWithInt:contentId]}}];
}
+(NSDictionary *)contentParamsWithUser:(ApiUser *)user categoryId:(int)categoryId text:(NSString *)text photo_token:(UIImage *)photo{
    NSDictionary *contentDic;
    if(photo){
        NSString *photoFile = [UIImageJPEGRepresentation(photo,kAMAPI_CONTENT_PHOTO_COMPRESSION) base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithCarriageReturn];
        NSDictionary *photoTokenDic = @{@"filename": @"image.jpg",
                                        @"file":photoFile,
                                        @"content_type":@"image/jpeg"};
        contentDic= @{@"content":@{
                              @"content_category_id": [NSNumber numberWithInt:categoryId],
                              @"text":text,
                              @"photo_token": photoTokenDic}};
        
    }else{
        contentDic= @{@"content":@{
                              @"content_category_id": [NSNumber numberWithInt:categoryId],
                              @"text":text}};
    }
    
    return [self addUserAuth:user toDictionary:contentDic];
}
+(NSDictionary *)responseParamsWithUser:(ApiUser *)user contentId:(int)contentId andResponse:(NSNumber *)response{
    if (!response){return @{};}
    return [self addUserAuth:user  toDictionary:@{@"user_response":@{
                                                          @"content_id": [NSNumber numberWithInt:contentId],
                                                          @"response":response}}];
}
+(NSDictionary *)flagContentParamsWithUser:(ApiUser *)user contentId:(int)contentId{
    return [self addUserAuth:user  toDictionary:@{@"params":@{@"content_id": [NSNumber numberWithInt:contentId]}}];
}
#pragma mark -  Utility Methods: JSON Request - Comment
+(NSDictionary *)commentParamsWithUser:(ApiUser *)user contentId:(int)contentId text:(NSString *)text{
    return [self addUserAuth:user toDictionary:@{@"comment":@{
                                                         @"content_id": [NSNumber numberWithInt:contentId],
                                                         @"text":text}}];
}
+(NSDictionary *)getCommentsParamsWithUser:(ApiUser *)user
                                 contentId:(int)contentId
                                      mode:(kAPICommentOrderMode)mode
                                     count:(int)count
                                    offset:(int)offset{
    
    return [self addUserAuth:user  toDictionary:@{@"params":@{
                                                          @"content_id": [NSNumber numberWithInt:contentId],
                                                          @"mode": [ApiComment getCommentOderMode:mode],
                                                          @"count": [NSNumber numberWithInt:count],
                                                          @"offset": [NSNumber numberWithInt:offset]}}];
}

+(NSDictionary *)commentResponseParamsWith:(ApiUser *)user commentId:(int)commentId andResponse:(NSNumber *)response{
    if (!response){return @{};}
    return [self addUserAuth:user  toDictionary:@{@"comment_response":@{
                                                          @"comment_id": [NSNumber numberWithInt:commentId],
                                                          @"response":response}}];
}
+(NSDictionary *)commentResponseParamsWith:(ApiUser *)user commentId:(int)commentId{
    return [self addUserAuth:user  toDictionary:@{@"comment_response":@{
                                                          @"comment_id": [NSNumber numberWithInt:commentId],
                                                          @"response":[NSNumber numberWithInteger:kApiCommentResponseTypeLike]}}];
}

#pragma mark -  Utility Methods: JSON Request - History
+(NSDictionary *)getHistoryParamsWithUser:(ApiUser *)user
                                    count:(int)count
                                   offset:(int)offset{
    return [self addUserAuth:user  toDictionary:@{@"params":@{
                                                          @"count": [NSNumber numberWithInt:count],
                                                          @"offset": [NSNumber numberWithInt:offset]}}];
    
}

#pragma mark -  Utility Methods: JSON Request - Notification
+(NSDictionary *)getResetNotificationContentParamsWithUser:(ApiUser *)user
                                                 contentId:(int)contentId
                                                     count:(int)count{
    return [self addUserAuth:user  toDictionary:@{@"params":@{
                                                          @"content_id": [NSNumber numberWithInt:contentId],
                                                          @"count": [NSNumber numberWithInt:count]}}];
    
}
+(NSDictionary *)getResetNotificationCommentParamsWithUser:(ApiUser *)user
                                                 commentId:(int)commentId
                                                     count:(int)count{
    return [self addUserAuth:user  toDictionary:@{@"params":@{
                                                          @"comment_id": [NSNumber numberWithInt:commentId],
                                                          @"count": [NSNumber numberWithInt:count]}}];
    
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
                                      photoToken:contentDic[@"photo_token"]?contentDic[@"photo_token"]:@{}
                                     totalSpread:contentDic[@"total_spread"]
                                     spreadCount:contentDic[@"spread_count"]
                                       killCount:contentDic[@"kill_count"]
                                    commentCount:contentDic[@"comment_count"]
                                 commentCountNew:contentDic[@"new_comment_count"]
                                       createdAt:contentDic[@"created_at"]
                                       updatedAt:contentDic[@"updated_at"]];
}
#pragma mark - content response info from response
+ (ApiUserResponse *)getUserResponseFromDictionary:(NSDictionary *)userResponseDic{
    return [[ApiUserResponse alloc] initWithUserId:userResponseDic[@"content_response"][@"user_id"]
                                         contentId:userResponseDic[@"content_response"][@"content_id"]
                                      userResponse:userResponseDic[@"content_response"][@"response"] ];
}

#pragma mark - content flag info from response
/*!
 *  Converts Json Dictionary to ApiContentFlag Object
 *  @param UserResponseDic Dictionary containing ApiContentFlag information
 *  @return Returns ApiContentFlagObject with values from ContentFlagDic.
 *  @
 */
+ (ApiContentFlag *)getContentFlagFromDictionary:(NSDictionary *)contentFlagDic{
    return [[ApiContentFlag  alloc] initWithContentFlagId:contentFlagDic[@"content_flag"][@"id"]
                                                   userId:contentFlagDic[@"content_flag"][@"user_id"]
                                                contentId:contentFlagDic[@"content_flag"][@"content_id"]];
}

#pragma mark - comment info from response
+ (NSArray *)getCommentArrayFromDictionary:(NSDictionary *)commentsDic{
    NSMutableArray *commentArray =[[NSMutableArray alloc] init];
    
    for (NSDictionary *commentDic in commentsDic[@"comments"]){
        ApiComment *comment =[ApiRequestHelper getCommentFromDictionaryWithOutRoot:commentDic];
        if([ApiComment isValidComment:comment]){
            [commentArray addObject:comment];
        }
        else{
            return nil;
        }
    }
    return (NSArray *)commentArray;
}
+ (ApiComment *)getCommentFromDictionary:(NSDictionary *)commentDic{
    return [ApiRequestHelper getCommentFromDictionaryWithOutRoot:commentDic[@"comment"]];
}
+ (ApiComment *)getCommentFromDictionaryWithOutRoot:(NSDictionary *)commentDic{
    return [[ApiComment alloc] initWithCommentId:commentDic[@"id"]
                                            text:commentDic[@"text"]
                                          userId:commentDic[@"user_id"]
                                       contentId:commentDic[@"content_id"]
                                       likeCount:commentDic[@"like_count"]
                                    likeCountNew:commentDic[@"new_like_count"]
                                         didLike:commentDic[@"did_like"]
                                       createdAt:commentDic[@"created_at"]
                                       updatedAt:commentDic[@"updated_at"]];
}
#pragma mark - comment response from response
+ (ApiCommentResponse *)getCommentResponseFromDictionary:(NSDictionary *)userResponseDic{
    return [[ApiCommentResponse alloc] initWithResponseId:userResponseDic[@"comment_response"][@"id"]
                                                   userId:userResponseDic[@"comment_response"][@"user_id"]
                                                commentId:userResponseDic[@"comment_response"][@"comment_id"]
                                          commentResponse:userResponseDic[@"comment_response"][@"response"] ];
}

#pragma mark - notification list from response
+ (NSArray *)getNotificationArrayFromDictionary:(NSDictionary *)notificationsDic{
    NSMutableArray *notificationArray =[[NSMutableArray alloc] init];
    
    for (NSDictionary *notificationDic in notificationsDic[@"notifications"]){
        if(notificationDic[@"content_category_id"]){
            ApiContent *content =[ApiRequestHelper getContentFromDictionaryWithOutRoot:notificationDic];
            if([ApiContent isValidContent:content]){
                [notificationArray addObject:content];
            }
            else{
                return nil;
            }
        }
        else if(notificationDic[@"content_id"]){
            ApiComment *comment  =[ApiRequestHelper getCommentFromDictionaryWithOutRoot:notificationDic];
            if([ApiComment isValidComment:comment]){
                [notificationArray addObject:comment];
            }
            else{
                return nil;
            }
        }
    }
    return (NSArray *)notificationArray;
}

#pragma mark - notification count from response
/*!
 *  Converts get notification list response object and retures an ApiNotificationCount object
 *  if there is error - missing and invalid values in the response object
 *  @return an ApiNotificationCount object
 */
+ (ApiNotificationCount *)getNotificationCountFromDictionary:(NSDictionary *)notificationCountDic{
    return [[ApiNotificationCount alloc] initWithUserId:notificationCountDic[@"notifications"][@"user_id"]
                                          totalNewCount:notificationCountDic[@"notifications"][@"total_new_count"]
                                        commentCountNew:notificationCountDic[@"notifications"][@"new_comment_count"]
                                           likeCountNew:notificationCountDic[@"notifications"][@"new_like_count"]];
}

@end
