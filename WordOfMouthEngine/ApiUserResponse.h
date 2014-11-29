//
//  ApiUserResponse.h
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 11/10/13.
//  Copyright (c) 2013 Bijit Halder. All rights reserved.
//

/*!
 * @header ApiUserResponse
 * Class for UserResponse information and interfacing with BackEnd Api
 * @abstract ApiUserResponse  Interface
 * @author Bijit Halder
 * @version 2.0
 */

#import <Foundation/Foundation.h>

/*!
 * @typedef kApiUserResponseType;
 * @brief User response types: spread and kill
 * @constant kApiUserResponseTypeKill
 * @constant kApiUserResponseTypeSpread
 */
typedef enum {
    kApiUserResponseTypeKill=0,
    kApiUserResponseTypeSpread=1,
} kApiUserResponseType;

@interface ApiUserResponse : NSObject{
    
}
/*!
 * @property userId
 * @brief  Id of the user
 */
@property   NSNumber *userId;
/*!
 * @property contentId
 * @brief  Id of the content
 */
@property   NSNumber *contentId;
/*!
 * @property userResponse
 * @brief  Value of the user response: spread or kill
 */
@property   NSNumber *userResponse;

#pragma mark - Init Methods
- (ApiUserResponse *)initWithUserId:(NSNumber *)userId_
                          contentId:(NSNumber *)contentId_
                       userResponse:(NSNumber *)userResponse_;

#pragma mark - Utility Methods
/*!
 *  Valdiates existence of user response properties: userid and contentid
 *  @param userResponse An ApiUserResponse Object
 *  @return BOOL value indicating validity of the user object
 *  @discussion To be valid userId and contentId must be a positive integer (>=1)
 */
+(BOOL)isValidUserResponse:(ApiUserResponse *)userResponse;
/*!
 *  Prints ApiUserResponse Object with all the properties
 *  @param userResponse An ApiUserResponse Object to be printed
 */
+(void)printApiUserResponse:(ApiUserResponse  *)userResponse;

@end
