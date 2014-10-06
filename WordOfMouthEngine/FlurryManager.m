//
//  FlurryManager.m
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 8/13/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import "FlurryManager.h"

@implementation FlurryManager

#pragma mark - class method
+ (NSString *)getKey{
    return @"Q6V5K73TT779FHW9RDT4";
}
+ (NSString *)getEventName:(kFACustomEventType)type{
    if(type==kFAUserSessionSignIn){
        return @"Event:UserSessionSignIn";
    }
    if(type==kFAUserSessionSignInSuccess){
        return @"Event:UserSessionSignInSuccess";
    }
    
    if(type==kFAUserSessionSignInFailure){
        return @"Event:UserSessionSignInFailure";
    }
    
    if(type==kFAUserSessionGuestSignIn){
        return @"Event:UserSessionGuestSignIn";
    }
    
    if(type==kFAUserSessionGuestSignInSuccess){
        return @"Event:UserSessionGuestSignInSuccess";
    }
    
    if(type==kFAUserSessionGuestSignInFailure){
        return @"Event:UserSessionGuestSignInFailure";
    }
    
    if(type==kFAUserSessionSignUp){
        return @"Event:UserSessionSignUp";
    }
    
    if(type==kFAUserSessionSignUpSuccess){
        return @"Event:UserSessionSignUpSuccess";
    }
    
    if(type==kFAUserSessionSignUpFailure){
        return @"Event:UserSessionSignUpFailure";
    }
    
    if(type==kFAUserSessionSignOut){
        return @"Event:UserSessionSignOut";
    }
    
    if(type==kFAContentSession){
        return @"Event:ContentSession";
    }
    
    if(type==kFAContentFetch){
        return @"Event:ContentFetch";
    }
    
    if(type==kFAContentEach){
        return @"Event:ContentEach";
    }
    if(type==kFAContentKill){
        return @"Event:ContentKill";
    }

    if(type==kFAContentSpread){
        return @"Event:ContentSpread";
    }

    if(type==kFAComposeSession){
        return @"Event:ComposeSession";
    }
    
    if(type==kFAComposePhoto){
        return @"Event:ComposePhoto";
    }
    
    if(type==kFAComposeCamera){
        return @"Event:ComposeCamera";
    }
    
    if(type==kFAComposeAlbum){
        return @"Event:ComposeAlbum";
    }
    
    if(type==kFAComposePost){
        return @"Event:ContentPost";
    }

    if(type==kFAComposePostSuccess){
        return @"Event:ContentPostSuccess";
    }

    if(type==kFAComposePostFailure){
        return @"Event:ContentPostFailure";
    }

    
    return @"Event:Default";
}
@end
