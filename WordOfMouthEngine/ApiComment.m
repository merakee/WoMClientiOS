//
//  Comment.m
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 11/24/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import "ApiComment.h"
#import "LocalMacros.h"

@implementation ApiComment

@synthesize commentId;
@synthesize commentText;
@synthesize userId;
@synthesize contentId;
@synthesize timeStamp;
@synthesize likeCount;


#pragma mark - Init Methods
- (id)initWithCommentId:(NSNumber *)commentId_
                   text:(NSString *)commentText_
                 userId:(NSNumber * )userId_
             contentId:(NSNumber * )contentId_
              timeStamp:(NSString *)timeStamp_
           likeCount:(NSNumber * )likeCount_{
    if(self = [super init]) {
        // initialization code
        self.commentId = commentId_;
        self.commentText = commentText_;
        self.userId = userId_;
        self.contentId = contentId_;
        self.timeStamp = timeStamp_;
        self.likeCount = likeCount_;
        
    }
    return self;
}

#pragma mark - Utility Methods
+ (ApiComment *)getEmptyCommentNotice{
    return [[ApiComment alloc] initWithCommentId:@0
                                            text:@"Sorry! There is no comment yet."
                                          userId:@0
                                       contentId:@0
                                       timeStamp:@""
                                    likeCount:@0];
}

+(BOOL)isValidComment:(ApiComment *)comment{
    return (comment.commentId&&(comment.commentId.intValue>0)
            &&comment.contentId&&(comment.contentId.intValue>0)
            &&comment.commentText&&comment.userId);
}

+(void)printCommentInfo:(ApiComment *)comment {
    NSLog(@"Comment info:--------------------");
    NSLog(@"Comment Id: %ld",(long)comment.commentId.integerValue);
    NSLog(@"Text: %@",comment.commentText);
    NSLog(@"Author Id: %ld",(long)comment.userId.integerValue);
    NSLog(@"Content Id: %ld",(long)comment.contentId.integerValue);
    NSLog(@"Time Stamp: %@",comment.timeStamp);
    NSLog(@"Like Count: %ld",(long)comment.likeCount.integerValue);
}

@end

