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
@synthesize likeCount;
@synthesize likeCountNew;
@synthesize didLike;
@synthesize createdAt;
@synthesize updatedAt;


#pragma mark - Init Methods
- (id)initWithCommentId:(NSNumber *)commentId_
                   text:(NSString *)commentText_
                 userId:(NSNumber * )userId_
              contentId:(NSNumber * )contentId_
              likeCount:(NSNumber * )likeCount_
           likeCountNew:(NSNumber * )likeCountNew_
                didLike:(NSNumber *)didLike_
              createdAt:(NSString *)createdAt_
              updatedAt:(NSString *)updatedAt_{
    if(self = [super init]) {
        // initialization code
        self.commentId = commentId_;
        self.commentText = commentText_;
        self.userId = userId_;
        self.contentId = contentId_;
        self.likeCount = likeCount_;
        self.likeCountNew = likeCountNew_;
        self.didLike = didLike_;
        self.createdAt = createdAt_;
        self.updatedAt = updatedAt_;
        
    }
    return self;
}

#pragma mark - Utility Methods
+ (ApiComment *)getEmptyCommentNotice{
    return [[ApiComment alloc]  initWithCommentId:@0
                                             text:@"Sorry! There is no comment yet."
                                           userId:@0
                                        contentId:@0
                                        likeCount:@0
                                     likeCountNew:@0
                                          didLike:false
                                        createdAt:@""
                                        updatedAt:@""];
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
    NSLog(@"Like Count: %ld",(long)comment.likeCount.integerValue);
    NSLog(@"Like Count New: %ld",(long)comment.likeCountNew.integerValue);
    NSLog(@"Did Like: %ld",(long)comment.didLike.boolValue);
    NSLog(@"Created At: %@",comment.createdAt);
    NSLog(@"Updated At: %@",comment.updatedAt);
}

+(NSString *)getCommentOderMode:(kAPICommentOrderMode)mode{
    if(mode==kAPICommentOrderModePopular){
        return @"popular";
    }
    // default
    return @"recent";
}
@end

