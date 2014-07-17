//
//  ApiUser.h
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 11/10/13.
//  Copyright (c) 2013 Bijit Halder. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    kAPIUserTypeAnonymous=1,
    kAPIUserTypeWom,
    kAPIUserTypeFacebook,
    kAPIUserTypeTwitter,
    kAPIUserTypeGooglePlus,
    kAPIUserTypeOthers,
} kAPIUserType;

@interface ApiUser : NSObject

@property   NSNumber *userId;
@property   NSNumber *userTypeId;
@property   NSString *email;
@property   NSString *authenticationToken;
@property   NSNumber *signedIn;


#pragma mark - Init Methods
- (ApiUser *)initWithUserId:(NSNumber *)userId_
                 userTypeId:(NSNumber *)userTypeId_
                      email:(NSString *)email_
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
