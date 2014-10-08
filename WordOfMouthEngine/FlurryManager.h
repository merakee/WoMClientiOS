//
//  FlurryManager.h
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 8/13/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Flurry.h"

typedef enum {
    kFAUserSessionSignIn=0,
    kFAUserSessionSignInSuccess,
    kFAUserSessionSignInFailure,
    kFAUserSessionGuestSignIn,
    kFAUserSessionGuestSignInSuccess,
    kFAUserSessionGuestSignInFailure,
    kFAUserSessionSignUp,
    kFAUserSessionSignUpSuccess,
    kFAUserSessionSignUpFailure,
    kFAUserSessionSignOut,
    kFAContentSession,
    kFAContentFetch,
    kFAContentEach,
    kFAContentKill,
    kFAContentSpread,
    kFAComposeSession,
    kFAComposePhoto,
    kFAComposeCamera,
    kFAComposeAlbum,
    kFAComposePost,
    kFAComposePostSuccess,
    kFAComposePostFailure,
} kFACustomEventType;

@interface FlurryManager : NSObject

#pragma mark - class method
+ (NSString *)getEventName:(kFACustomEventType)type;
+ (NSString *)getKey;
@end
