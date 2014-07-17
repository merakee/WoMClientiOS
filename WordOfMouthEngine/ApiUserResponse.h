//
//  ApiUserResponse.h
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 11/10/13.
//  Copyright (c) 2013 Bijit Halder. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    kApiUserResponseTypeKill=0,
    kApiUserResponseTypeSpread=1,
} kApiUserResponseType;

@interface ApiUserResponse : NSObject

@property   NSNumber *userId;
@property   NSNumber *contentId;
@property   NSNumber *userResponse;

#pragma mark - Init Methods
- (ApiUserResponse *)initWithUserId:(NSNumber *)userId_
                          contentId:(NSNumber *)contentId_
                       userResponse:(NSNumber *)userResponse_;

#pragma mark - Utility Methods
/*!
 *  Valdiates existence of user response properties: userid and contentid
 *  @param user An ApiUserResponse Object
 *  @return BOOL value indicating validity of the user object
 *  @discussion To be valid userId and contentId must be a positive integer (>=1)
 */
+(BOOL)isValidUserResponse:(ApiUserResponse *)userResponse;
/*!
 *  Prints ApiUserResponse Object with all the properties
 *  @param content An ApiUserResponse Object to be printed
 */
+(void)printApiUserResponse:(ApiUserResponse  *)userResponse;

@end
