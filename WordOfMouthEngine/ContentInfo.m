//
//  ContentInfo.m
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 2/15/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import "ContentInfo.h"
#import "LocalMacros.h"

@implementation ContentInfo

@synthesize contentBody;
@synthesize authorId;
@synthesize timeStamp;
@synthesize spreadCount;

#pragma mark - Init Methods
- (id)initWithBody:(NSString *)contentBody_
          authorId:(NSInteger )authorId_
         timeStamp:(NSString *)timeStamp_
       spreadCount:(NSInteger )spreadCount_{
    if(self = [super init]) {
        // initialization code
        self.contentBody = contentBody_;
        self.authorId = authorId_;
        self.timeStamp = timeStamp_;
        self.spreadCount = spreadCount_;

    }
    return self;
}

#pragma mark - Utility Methods
+(void)printRewardInfo:(ContentInfo *)ci {
    DBLog(@"Content info:--------------------");
    DBLog(@"Body: %@",ci.contentBody);
    DBLog(@"Author Id: %d",ci.authorId);
    DBLog(@"Time Stamp: %@",ci.timeStamp);
    DBLog(@"Spread Count: %d",ci.spreadCount);
}

@end
