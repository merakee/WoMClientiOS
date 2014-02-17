//
//  UserInfo.h
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 2/15/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UserInfo : NSObject{
    
}

@property NSInteger userId;
@property NSString *userName;
@property NSString *userEmail;

#pragma mark - Init Methods
- (id)initWithId:(NSInteger)userId_
            name:(NSString *)userName_
           email:(NSString *)userEmail_;

#pragma mark - Utility Methods
+(void)printRewardInfo:(UserInfo  *)ui;

@end
