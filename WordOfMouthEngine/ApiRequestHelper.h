//
//  ApiRequestHelper.h
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 7/14/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ApiUser.h"

@interface ApiRequestHelper : NSObject

#pragma mark -  Utility Methods: JSON Request
+(NSDictionary *)userSignUpParamsWithUserTypeId:(int)userTypeId email:(NSString *)email password:(NSString *)password andPasswordConfirmation:(NSString *)passwordConfirmation;
+(NSDictionary *)userSignInParamsWithEmail:(NSString *)email andPassword:(NSString *)password;
+(NSDictionary *)userAuthenticationParams:(ApiUser *)user;
+(NSDictionary *)contentParamsWithUser:(ApiUser *)user categoryId:(int)categoryId andtext:(NSString *)text;
+(NSDictionary *)responseParamsWith:(ApiUser *)user contentId:(int)contentId andResponse:(NSNumber *)response;
+(NSDictionary *)addUserAuth:(ApiUser *)user toDictionary:(NSDictionary *)infoDictionary;
+ (ApiUser *)getUserFromDictionary:(NSDictionary *)userInfo;@end
