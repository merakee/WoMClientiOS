//
//  SessionManager.h
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 2/13/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfo.h"

@interface SessionManager : NSObject{
    
}

@property UserInfo      *currentUser;

#pragma mark - User Session methods
+ (BOOL) isUserLoggedIn;
+ (UserInfo *)currentUser;

@end
