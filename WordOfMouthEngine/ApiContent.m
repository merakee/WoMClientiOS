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
@synthesize commentCount;


#pragma mark - Init Methods
- (id)initWithContentId:(NSNumber *)contentId_
                   text:(NSString *)contentText_
                 userId:(NSNumber * )userId_
             categoryId:(NSNumber * )categoryId_
             photoToken:(NSDictionary *)photoToken_
              timeStamp:(NSString *)timeStamp_
            totalSpread:(NSNumber * )totalSpread_
            spreadCount:(NSNumber * )spreadCount_
              killCount:(NSNumber * )killCount_
        commentCount:(NSNumber * )commentCount_{
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
        self.commentCount = commentCount_;
        
    }
    return self;
}

#pragma mark - Utility Methods
+ (ApiContent *)getEmptyContentNotice{
    return [[ApiContent alloc] initWithContentId:@0
                                            text:@"Sorry! There is no content right now. Wait or press any button to refresh"
                                          userId:@0
                                      categoryId:[NSNumber numberWithInteger:kAPIContentCategoryEmpty]
                                      photoToken:@{}
                                       timeStamp:@""
                                     totalSpread:@0
                                     spreadCount:@0
                                       killCount:@0
                                 commentCount:@0];
}

+(BOOL)isValidContent:(ApiContent *)content{
    return (content.contentId&&(content.contentId.intValue>0)
            &&content.categoryId&&(content.categoryId.intValue>=1)&&(content.categoryId.intValue<=4)
            &&content.contentText&&content.userId);
}

+(void)printContentInfo:(ApiContent *)content {
    NSLog(@"Content info:--------------------");
    NSLog(@"Content Id: %ld",(long)content.contentId.integerValue);
    NSLog(@"Text: %@",content.contentText);
    NSLog(@"Author Id: %ld",(long)content.userId.integerValue);
    NSLog(@"Category Id: %ld",(long)content.categoryId.integerValue);
    NSLog(@"Photo Token: %@",content.photoToken);
    NSLog(@"Time Stamp: %@",content.timeStamp);
    NSLog(@"Total Spread: %ld",(long)content.totalSpread.integerValue);
    NSLog(@"Spread Count: %ld",(long)content.spreadCount.integerValue);
    NSLog(@"Kill Count: %ld",(long)content.killCount.integerValue);
    NSLog(@"Comment Count: %ld",(long)content.commentCount.integerValue);
}

@end
