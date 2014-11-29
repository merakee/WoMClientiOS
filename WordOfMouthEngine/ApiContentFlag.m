//
//  ApiContentFlag.m
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 11/29/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import "ApiContentFlag.h"

@implementation ApiContentFlag

@synthesize contentFlagId;
@synthesize userId;
@synthesize contentId;

#pragma mark - Init Methods
- (id)initWithContentFlagId:(NSNumber *)contentFlagId_
                     userId:(NSNumber * )userId_
                  contentId:(NSNumber * )contentId_{
    if(self = [super init]) {
        // initialization code
        self.contentFlagId = contentFlagId_;
        self.userId = userId_;
        self.contentId = contentId_;
    }
    return self;
}

#pragma mark - Utility Methods

+(BOOL)isValidContentFlag:(ApiContentFlag *)contentFlag{
    return (contentFlag.contentFlagId&&(contentFlag.contentFlagId.intValue>0)
            &&contentFlag.contentId&&(contentFlag.contentId.intValue>0)
            &&contentFlag.userId&&(contentFlag.userId.intValue>0));
}

+(void)printContentFlagInfo:(ApiContentFlag  *)contentFlag {
    NSLog(@"ApiContentFlag Info:--------------------");
    NSLog(@"Content Flag Id: %ld",(long)contentFlag.contentFlagId.integerValue);
    NSLog(@"Author Id: %ld",(long)contentFlag.userId.integerValue);
    NSLog(@"Content Id: %ld",(long)contentFlag.contentId.integerValue);
}

@end




