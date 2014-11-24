//
//  ApiCommentResponse.m
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 11/24/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import "ApiCommentResponse.h"

@implementation ApiCommentResponse

@synthesize commentResponseId;
@synthesize userId;
@synthesize commentId;
@synthesize commentResponse;

#pragma mark - Init Methods
- (ApiCommentResponse *)initWithResponseId:(NSNumber *)commentResponseId_
                                    userId:(NSNumber *)userId_
                                 commentId:(NSNumber *)commentId_
                           commentResponse:(NSNumber *)commentResponse_{
    if (self = [super init]) {
        // initialization code
        self.commentResponseId=commentResponseId_;
        self.userId = userId_;
        self.commentId = commentId_;
        self.commentResponse = commentResponse_;
    }
    return self;
}
- (ApiCommentResponse *)initWithResponseId:(NSNumber *)commentResponseId_
                                     userId:(NSNumber *)userId_
                             commentId:(NSNumber *)commentId_{
    if (self = [super init]) {
        // initialization code
        self.commentResponseId=commentResponseId_;
        self.userId = userId_;
        self.commentId = commentId_;
        self.commentResponse = [NSNumber numberWithInt:kApiCommentResponseTypeLike];
    }
    return self;
}


#pragma mark - Utility Methods
+(BOOL)isValidCommentResponse:(ApiCommentResponse *)commentResponse{
    return (commentResponse.commentResponseId&&(commentResponse.commentResponseId.intValue>0)
            &&commentResponse.userId&&(commentResponse.userId.intValue>0)
            &&commentResponse.commentId&&(commentResponse.commentId.intValue>0) );
}
+(void)printApiCommentResponse:(ApiCommentResponse  *)commentResponse{
    NSLog(@"Api User Response:--------------------");
    NSLog(@"User Id: %d",[commentResponse.userId intValue]);
    NSLog(@"Comment Id: %d",[commentResponse.commentId intValue]);
    NSLog(@"Comment Response: %d",[commentResponse.commentResponse intValue]);
}


@end
