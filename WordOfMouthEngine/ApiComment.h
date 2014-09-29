//
//  Comment.h
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 11/24/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ApiComment : NSObject{
    
}

@property NSNumber * commentId;
@property NSString *commentText;
@property NSNumber * userId;
@property NSNumber * contentId;
@property NSNumber * likeCount;
@property NSString *timeStamp;

#pragma mark - Init Methods
- (id)initWithCommentId:(NSNumber *)commentId_
                   text:(NSString *)commentText_
                 userId:(NSNumber * )userId_
             contentId:(NSNumber * )contentId_
              timeStamp:(NSString *)timeStamp_
           likeCount:(NSNumber * )likeCount_;

#pragma mark - Utility Methods
/*!
 *  Generates an comment with empty notice and EmptyComment category
 *  @return An APiComment Object
 */
+ (ApiComment *)getEmptyCommentNotice;
/*!
 *  Valdiates existence of comment properties: commentId, categoryId, text, and userId
 *  @param comment An ApiComment Object
 *  @return BOOL value indicating validity of the comment object
 *  @discussion To be valid commentId must be a positive integer (>=1) and commentTypeId must be between 1 and 4: [1 4]
 */
+(BOOL)isValidComment:(ApiComment *)comment;
/*!
 *  Prints ApiComment Object with all the properties
 *  @param comment An ApiComment Object to be printed
 */
+(void)printCommentInfo:(ApiComment  *)comment;


@end
