//
//  ApiUser.h
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 11/10/13.
//  Copyright (c) 2013 Bijit Halder. All rights reserved.
//


/*!
 * @header ApiUser
 * Class for User information and interfacing with BackEnd Api
 * @abstract ApiUser Interface
 * @author Bijit Halder
 * @version 2.0
 */

#import <Foundation/Foundation.h>

/*!
 * @typedef kAPIUserType
 * @brief List of type fo users
 * @constant kAPIUserTypeAnonymous
 * @constant kAPIUserTypeWom,
 * @constant kAPIUserTypeFacebook,
 * @constant kAPIUserTypeTwitter
 * @constant kAPIUserTypeGooglePlus
 * @constant kAPIUserTypeOthers
 */

typedef enum {
    kAPIUserTypeAnonymous=1,
    kAPIUserTypeWom,
    kAPIUserTypeFacebook,
    kAPIUserTypeTwitter,
    kAPIUserTypeGooglePlus,
    kAPIUserTypeOthers,
} kAPIUserType;

@interface ApiUser : NSObject

/*!
 * @brief User id
 */
@property   NSNumber *userId;
/*!
 * @brief User type id
 */
@property   NSNumber *userTypeId;
/*!
 * @brief User password
 */
@property   NSString *password;
/*!
 * @brief User password confirmation
 */
@property   NSString *passwordConfirmation;
/*!
 * @brief User email
 */
@property   NSString *email;
/*!
 * @brief User authentication token
 */
@property   NSString *authenticationToken;
/*!
 * @brief User signedIn flag
 */
@property   NSNumber *signedIn;
/*!
 * @brief User nickname
 */
@property   NSString *nickname;
/*!
 * @brief User avatar URL
 */
@property   NSString *avatarURL;
/*!
 * @brief User avatar image
 */
@property   UIImage  *avatar;
/*!
 * @brief User bio
 */
@property   NSString *bio;
/*!
 * @brief User social tags
 */
@property   NSArray *socialTags;
/*!
 * @brief User hometown
 */
@property   NSString *hometown;


#pragma mark - Init Methods
- (ApiUser *)initWithUserId:(NSNumber *)userId_
                 userTypeId:(NSNumber *)userTypeId_
                      email:(NSString *)email_
                   nickname:(NSString *)nickname_
                  avatarURL:(NSString *)avatarURL_
                        bio:(NSString *)bio_
                   hometown:(NSString*)hometown_
                 socialTags:(NSArray *)socialTags_
        authenticationToken:(NSString *)authenticationToken_
                   signedIn:(NSNumber *)signedIn_;

#pragma mark - Utility Methods
/*!
 *  Valdiates existence of user properties: userid, userTypeId, email, and authenticationToken
 *  @param user An ApiUser Object
 *  @return BOOL value indicating validity of the user object
 *  @discussion To be valid userId must be a positive integer (>=1) and userTypeId must be between 1 and 2: [1 2]
 */
+(BOOL)isValidUser:(ApiUser *)user;
/*!
 *  Prints ApiUser Object with all the properties
 *  @param content An ApiUser Object to be printed
 */
+(void)printApiUser:(ApiUser  *)user;

@end
