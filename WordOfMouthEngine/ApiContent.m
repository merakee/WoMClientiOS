//
//  ContentInfo.m
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 2/15/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import "ApiContent.h"
#import "LocalMacros.h"

@implementation ApiContent

@synthesize contentId;
@synthesize contentText;
@synthesize userId;
@synthesize categoryId;
@synthesize timeStamp;
@synthesize totalSpread;
@synthesize spreadCount;
@synthesize killCount;
@synthesize noResponseCount;


#pragma mark - Init Methods
- (id)initWithContentId:(NSNumber *)contentId_
                   text:(NSString *)contentText_
               userId:(NSNumber * )userId_
             categoryId:(NSNumber * )categoryId_
              timeStamp:(NSString *)timeStamp_
            totalSpread:(NSNumber * )totalSpread_
            spreadCount:(NSNumber * )spreadCount_
              killCount:(NSNumber * )killCount_
        noResponseCount:(NSNumber * )noResponseCount_{
    if(self = [super init]) {
        // initialization code
        self.contentId = contentId_;
        self.contentText = contentText_;
        self.userId = userId_;
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
+(BOOL)isValidContent:(ApiContent *)content{
    return (content.contentId&&(content.contentId.intValue>0)
            &&content.categoryId&&(content.categoryId.intValue>=1)&&(content.categoryId.intValue<=4)
            &&content.contentText&&content.userId);
}

+(void)printContentInfo:(ApiContent *)ci {
    DBLog(@"Content info:--------------------");
    DBLog(@"Content Id: %ld",(long)ci.contentId);
    DBLog(@"Text: %@",ci.contentText);
    DBLog(@"Author Id: %ld",(long)ci.userId);
    DBLog(@"Category Id: %ld",(long)ci.categoryId);
    DBLog(@"Time Stamp: %@",ci.timeStamp);
    DBLog(@"Total Spread: %ld",(long)ci.totalSpread);
    DBLog(@"Spread Count: %ld",(long)ci.spreadCount);
    DBLog(@"Kill Count: %ld",(long)ci.killCount);
    DBLog(@"No Response Count: %ld",(long)ci.noResponseCount);
}

@end
