//
//  ApiNotificationCount.m
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 11/29/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import "ApiNotificationCount.h"

@implementation ApiNotificationCount

@synthesize userId;
@synthesize totalNewCount;
@synthesize commentCountNew;
@synthesize likeCountNew;

#pragma mark - Init Methods
- (id)initWithUserId:(NSNumber * )userId_
       totalNewCount:(NSNumber * )totalNewCount_
     commentCountNew:(NSNumber * )commentCountNew_
        likeCountNew:(NSNumber * )likeCountNew_{
    if(self = [super init]) {
        // initialization code
        self.userId = userId_;
        self.totalNewCount = totalNewCount_;
        self.commentCountNew = commentCountNew_;
        self.likeCountNew = likeCountNew_;
    }
    return self;
}

#pragma mark - Utility Methods

+(BOOL)isValidNotificationCount:(ApiNotificationCount *)notificationCount{
    return (notificationCount.totalNewCount&&(notificationCount.totalNewCount.intValue>0)
            &&notificationCount.commentCountNew&&(notificationCount.commentCountNew.intValue>0)
            &&notificationCount.likeCountNew&&(notificationCount.likeCountNew.intValue>0)
            &&(notificationCount.totalNewCount.intValue == notificationCount.commentCountNew.intValue +notificationCount.likeCountNew.intValue)
            &&notificationCount.userId);
}

+(void)printNotificationCountInfo:(ApiNotificationCount  *)notificationCount {
    NSLog(@"NotificationCount Info:--------------------");
    NSLog(@"Author Id: %ld",(long)notificationCount.userId.integerValue);
    NSLog(@"Total New Count: %ld",(long)notificationCount.totalNewCount.integerValue);
    NSLog(@"Comment Count New: %ld",(long)notificationCount.commentCountNew.integerValue);
    NSLog(@"Like Count New: %ld",(long)notificationCount.likeCountNew.integerValue);
}

@end


