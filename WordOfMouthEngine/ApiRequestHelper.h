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

// Content photo parameters
static const float kAMAPI_CONTENT_PHOTO_COMPRESSION = 0.7;

@interface ApiRequestHelper : NSObject

#pragma mark -  Utility Methods: JSON Request
+(NSDictionary *)userSignUpParamsWithUserTypeId:(int)userTypeId email:(NSString *)email password:(NSString *)password andPasswordConfirmation:(NSString *)passwordConfirmation;
+(NSDictionary *)userSignInParamsWithEmail:(NSString *)email andPassword:(NSString *)password;
+(NSDictionary *)userAuthenticationParams:(ApiUser *)user;
+(NSDictionary *)contentParamsWithUser:(ApiUser *)user categoryId:(int)categoryId text:(NSString *)text photo_token:(UIImage *)photo;
+(NSDictionary *)responseParamsWith:(ApiUser *)user contentId:(int)contentId andResponse:(NSNumber *)response;
+(NSDictionary *)addUserAuth:(ApiUser *)user toDictionary:(NSDictionary *)infoDictionary;


#pragma mark - user info from response
/*!
 *  Converts Json Dictionary to ApiUser Object
 *  @param userDic User Dictionary containing User information
 *  @return Returns ApiUser Object with values from userDic
 *  @discussion Assings noResponseCount to nil since API does not return the value 
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

#pragma mark - content info from response
/*!
 *  Converts Json Dictionary to UserResponse Object
 *  @param UserResponseDic Dictionary containing User Response information
 *  @return Returns ApiUserResponse Object with values from cUserResponseDic.
 *  @
 */
+ (ApiUserResponse *)getUserResponseFromDictionary:(NSDictionary *)userResponseDic;
@end
