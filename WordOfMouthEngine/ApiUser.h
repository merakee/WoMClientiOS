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

@property   NSNumber *userTypeId;
@property   NSString *email;
@property   NSString *authenticationToken;
@property   NSNumber *signedIn;


#pragma mark - Init Methods
- (ApiUser *)initWithTypeId:(NSNumber *)userTypeId_
                      email:(NSString *)email_
        authenticationToken:(NSString *)authenticationToken_
                   signedIn:(NSNumber *)signedIn_;

#pragma mark - Utility Methods
+(void)printApiUser:(ApiUser  *)user;

@end
