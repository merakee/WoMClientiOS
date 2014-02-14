//
//  ApiUser.m
//  WordOfMotuhEngine
//
//  Created by Bijit Halder on 11/10/13.
//  Copyright (c) 2013 Bijit Halder. All rights reserved.
//

#import "ApiUser.h"

@implementation ApiUser

@synthesize  userId;
@synthesize  name;
@synthesize  email;

#pragma mark - Init Methods
- (id)initWithId:(int)userId_
                   name:(NSString *)name_
                  email:(NSString *)email_ {
    if (self = [super init]) {
        // initialization code
        self.userId = userId_;
        self.name = name_;
        self.email=email_;
    }
    return self;
}

#pragma mark - Utility methods

@end
