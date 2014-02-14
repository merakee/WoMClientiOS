//
//  ApiUser.h
//  WordOfMotuhEngine
//
//  Created by Bijit Halder on 11/10/13.
//  Copyright (c) 2013 Bijit Halder. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ApiUser : NSObject

@property int userId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *email;


#pragma mark - Init Methods
- (id)initWithId:(int)userId_
                   name:(NSString *)name_
                  email:(NSString *)email_;

#pragma mark - Utility methods

@end
