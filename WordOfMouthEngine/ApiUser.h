//
//  ApiUser.h
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 11/10/13.
//  Copyright (c) 2013 Bijit Halder. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ApiUser : NSObject

@property  NSNumber *userTypeId;
@property  NSString *email;
@property  NSString *authenticationToken;


#pragma mark - Init Methods
- (ApiUser *)initWithTypeId:(int)userTypeId_
                   email:(NSString *)email_
                  authenticationToken:(NSString *)authenticationToken_;

#pragma mark - Utility methods

@end
