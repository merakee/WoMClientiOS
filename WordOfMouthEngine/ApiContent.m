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
@synthesize photoToken;
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
             photoToken:(NSString *)photoToken_
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
        self.photoToken = photoToken_;
        self.timeStamp = timeStamp_;
        self.totalSpread = totalSpread_;
        self.spreadCount = spreadCount_;
        self.killCount = killCount_;
        self.noResponseCount = noResponseCount_;
        
    }
    return self;
}

#pragma mark - Utility Methods
+ (ApiContent *)getEmptyContentNotice{
    return [[ApiContent alloc] initWithContentId:@0
                                            text:@"Sorry! There is no content right now. Wait or press any button to refresh"
                                          userId:@0
                                      categoryId:[NSNumber numberWithInteger:kAPIContentCategoryEmpty]
                                      photoToken:@""
                                       timeStamp:@""
                                     totalSpread:@0
                                     spreadCount:@0
                                       killCount:@0
                                 noResponseCount:@0];
}

+(BOOL)isValidContent:(ApiContent *)content{
    return (content.contentId&&(content.contentId.intValue>0)
            &&content.categoryId&&(content.categoryId.intValue>=1)&&(content.categoryId.intValue<=4)
            &&content.contentText&&content.userId);
}

+(void)printContentInfo:(ApiContent *)content {
    DBLog(@"Content info:--------------------");
    DBLog(@"Content Id: %ld",(long)content.contentId.integerValue);
    DBLog(@"Text: %@",content.contentText);
    DBLog(@"Author Id: %ld",(long)content.userId.integerValue);
    DBLog(@"Category Id: %ld",(long)content.categoryId.integerValue);
    DBLog(@"Photo Token: %@",content.photoToken);
    DBLog(@"Time Stamp: %@",content.timeStamp);
    DBLog(@"Total Spread: %ld",(long)content.totalSpread.integerValue);
    DBLog(@"Spread Count: %ld",(long)content.spreadCount.integerValue);
    DBLog(@"Kill Count: %ld",(long)content.killCount.integerValue);
    DBLog(@"No Response Count: %ld",(long)content.noResponseCount.integerValue);
}

@end
