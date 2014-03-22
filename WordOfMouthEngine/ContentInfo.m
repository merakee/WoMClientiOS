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

@synthesize contentId;
@synthesize contentBody;
@synthesize authorId;
@synthesize categoryId;
@synthesize timeStamp;
@synthesize totalSpread;
@synthesize spreadCount;
@synthesize killCount;
@synthesize noResponseCount;


#pragma mark - Init Methods
- (id)initWithContentId:(NSInteger)contentId_
                   body:(NSString *)contentBody_
               authorId:(NSInteger )authorId_
             categoryId:(NSInteger )categoryId_
              timeStamp:(NSString *)timeStamp_
            totalSpread:(NSInteger )totalSpread_
            spreadCount:(NSInteger )spreadCount_
              killCount:(NSInteger )killCount_
        noResponseCount:(NSInteger )noResponseCount_{
    if(self = [super init]) {
        // initialization code
        self.contentId = contentId_;
        self.contentBody = contentBody_;
        self.authorId = authorId_;
        self.categoryId = categoryId_;
        self.timeStamp = timeStamp_;
        self.totalSpread = totalSpread_;
        self.spreadCount = spreadCount_;
        self.killCount = killCount_;
        self.noResponseCount = noResponseCount_;
        
    }
    return self;
}

#pragma mark - Utility Methods
+(void)printContentInfo:(ContentInfo *)ci {
    DBLog(@"Content info:--------------------");
    DBLog(@"Content Id: %ld",(long)ci.contentId);
    DBLog(@"Body: %@",ci.contentBody);
    DBLog(@"Author Id: %ld",(long)ci.authorId);
    DBLog(@"Category Id: %ld",(long)ci.categoryId);
    DBLog(@"Time Stamp: %@",ci.timeStamp);
    DBLog(@"Total Spread: %ld",(long)ci.totalSpread);
    DBLog(@"Spread Count: %ld",(long)ci.spreadCount);
    DBLog(@"Kill Count: %ld",(long)ci.killCount);
    DBLog(@"No Response Count: %ld",(long)ci.noResponseCount);
}

@end
