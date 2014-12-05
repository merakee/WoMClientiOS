//
//  ApiRequestHelper.h
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 7/14/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ApiUser.h"
#import "ApiContent.h"
#import "ApiUserResponse.h"
#import "ApiComment.h"
#import "ApiCommentResponse.h"
#import "ApiNotificationCount.h"
#import "ApiContentFlag.h"

// Content photo parameters
static const float kAMAPI_CONTENT_PHOTO_COMPRESSION = 0.7;

@interface ApiRequestHelper : NSObject

#pragma mark -  Utility Methods: JSON Request - Session
+(NSDictionary *)userSignUpParamsWithUserTypeId:(int)userTypeId email:(NSString *)email password:(NSString *)password andPasswordConfirmation:(NSString *)passwordConfirmation;
+(NSDictionary *)userSignInParamsWithEmail:(NSString *)email andPassword:(NSString *)password;
+(NSDictionary *)userAuthenticationParams:(ApiUser *)user;
+(NSDictionary *)addUserAuth:(ApiUser *)user toDictionary:(NSDictionary *)infoDictionary;

#pragma mark -  Utility Methods: JSON Request - Content
+(NSDictionary *)getContentParamsWithUser:(ApiUser *)user contentId:(int)contentId;
+(NSDictionary *)contentParamsWithUser:(ApiUser *)user categoryId:(int)categoryId text:(NSString *)text photo_token:(UIImage *)photo;
+(NSDictionary *)responseParamsWithUser:(ApiUser *)user contentId:(int)contentId andResponse:(NSNumber *)response;
+(NSDictionary *)flagContentParamsWithUser:(ApiUser *)user contentId:(int)contentId;

#pragma mark -  Utility Methods: JSON Request - Comment
+(NSDictionary *)commentParamsWithUser:(ApiUser *)user contentId:(int)contentId text:(NSString *)text;
+(NSDictionary *)getCommentsParamsWithUser:(ApiUser *)user contentId:(int)contentId
                                      mode:(kAPICommentOrderMode)mode
                                     count:(int)count
                                    offset:(int)offset;
+(NSDictionary *)commentResponseParamsWith:(ApiUser *)user commentId:(int)commentId andResponse:(NSNumber *)response;
+(NSDictionary *)commentResponseParamsWith:(ApiUser *)user commentId:(int)commentId;

#pragma mark -  Utility Methods: JSON Request - History
+(NSDictionary *)getHistoryParamsWithUser:(ApiUser *)user
                                     count:(int)count
                                    offset:(int)offset;

#pragma mark -  Utility Methods: JSON Request - Notification
+(NSDictionary *)getResetNotificationContentParamsWithUser:(ApiUser *)user
                                contentId:(int)contentId
                                    count:(int)count;
+(NSDictionary *)getResetNotificationCommentParamsWithUser:(ApiUser *)user
                                                commentId:(int)commentId
                                                    count:(int)count;

#pragma mark - user info from response
/*!
 *  Converts Json Dictionary to ApiUser Object
 *  @param userDic User Dictionary containing User information
 *  @return Returns ApiUser Object with values from userDic
 *  
 */
+ (ApiUser *)getUserFromDictionary:(NSDictionary *)userDic;


#pragma mark - content info from response
/*!
 *  Converts get content response object and retures array of contents. Even for single content it retunrs an array. It returns an empty array if there is not content and retunrs nil 
 *  if there is error - missing and invalid values in the response object
 *  @return An NSArray of ApiContent objects 
 */
+ (NSArray *)getContentArrayFromDictionary:(NSDictionary *)contentsDic;

/*!
 *  Converts Json Dictionary to ApiConent Object
 *  @param contentDic Dictionary containing content information
 *  @return Returns ApiContent Object with values from contentDic. 
 *  @
 */
+ (ApiContent *)getContentFromDictionary:(NSDictionary *)contentDic;

#pragma mark - user response info from response
/*!
 *  Converts Json Dictionary to UserResponse Object
 *  @param UserResponseDic Dictionary containing User Response information
 *  @return Returns ApiUserResponse Object with values from UserResponseDic.
 *  @
 */
+ (ApiUserResponse *)getUserResponseFromDictionary:(NSDictionary *)userResponseDic;

#pragma mark - content flag info from response
/*!
 *  Converts Json Dictionary to ApiContentFlag Object
 *  @param UserResponseDic Dictionary containing ApiContentFlag information
 *  @return Returns ApiContentFlagObject with values from ContentFlagDic.
 *  @
 */
+ (ApiContentFlag  *)getContentFlagFromDictionary:(NSDictionary *)contentFlagDic;


#pragma mark - comment info from response
/*!
 *  Converts get comment response object and retures array of comments. Even for single comment it retunrs an array. It returns an empty array if there is not comment and retunrs nil
 *  if there is error - missing and invalid values in the response object
 *  @return An NSArray of ApiComment objects
 */
+ (NSArray *)getCommentArrayFromDictionary:(NSDictionary *)commentsDic;

/*!
 *  Converts Json Dictionary to ApiComment Object
 *  @param commentDic Dictionary containing comment information
 *  @return Returns ApiComment Object with values from commentDic.
 *  @
 */
+ (ApiComment *)getCommentFromDictionary:(NSDictionary *)commentDic;

#pragma mark - comment response info from response
/*!
 *  Converts Json Dictionary to CommentResponse Object
 *  @param CommentResponseDic Dictionary containing User Response information
 *  @return Returns ApiCommentResponse Object with values from cCommentResponseDic.
 *  @
 */
+ (ApiCommentResponse *)getCommentResponseFromDictionary:(NSDictionary *)userResponseDic;

#pragma mark - notification list from response
/*!
 *  Converts get notification list response object and retures array of notification: each item is either an ApiContent object or ApiCommentObject
 *  Even for single notification it retunrs an array. It returns an empty array if there is not content and retunrs nil
 *  if there is error - missing and invalid values in the response object
 *  @return An NSArray of notification: each item is either an ApiContent object or ApiCommentObject
 */
+ (NSArray *)getNotificationArrayFromDictionary:(NSDictionary *)contentsDic;

#pragma mark - notification count from response
/*!
 *  Converts get notification list response object and retures an ApiNotificationCount object
 *  if there is error - missing and invalid values in the response object
 *  @return an ApiNotificationCount object
 */
+ (ApiNotificationCount *)getNotificationCountFromDictionary:(NSDictionary *)contentsDic;


@end
