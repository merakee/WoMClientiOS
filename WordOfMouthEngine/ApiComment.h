//
//  Comment.h
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 11/24/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

/*!
 * @header ApiComment
 * Class for Comment information and interfacing with BackEnd Api
 * @abstract ApiComment  Interface
 * @author Bijit Halder
 * @version 2.0
 */

#import <Foundation/Foundation.h>

/*!
 * @typedef kAPICommentOrderMode
 * @brief Comment order modes. Default Recent
 * @constant kAPICommentOrderModeRecent
 * @constant kAPICommentOrderModePopular
 */
typedef enum {
    kAPICommentOrderModeRecent = 0,
    kAPICommentOrderModePopular = 1,
} kAPICommentOrderMode;



@interface ApiComment : NSObject{
    
}
/*!
 * @property commentId
 * @brief  Id of the comment
 */
@property NSNumber * commentId;
/*!
 * @brief  Text of the comment
 */
@property NSString *commentText;
/*!
 * @brief  Author user id
 */
@property NSNumber * userId;
/*!
 * @brief  Id of the content the comment belongs to
 */
@property NSNumber * contentId;
/*!
 * @brief  Total number of likes
 */
@property NSNumber * likeCount;
/*!
 * @brief  Total number of new likes
 */
@property NSNumber * likeCountNew;
/*!
 * @brief  The falg to denote if the current user already liked the comment: 1 for yes, 0 for everything else (false, nil, not known)
 */
@property NSNumber *didLike;
/*!
 * @brief  Time stamp when the comment was created (GMT)
 */
@property NSString *createdAt;
/*!
 * @brief  Time stamp when the comment was last updated (GMT)
 */
@property NSString *updatedAt;

#pragma mark - Init Methods
- (id)initWithCommentId:(NSNumber *)commentId_
                   text:(NSString *)commentText_
                 userId:(NSNumber * )userId_
              contentId:(NSNumber * )contentId_
              likeCount:(NSNumber * )likeCount_
           likeCountNew:(NSNumber * )likeCountNew_
                didLike:(NSNumber *)didLike_
              createdAt:(NSString *)createdAt_
              updatedAt:(NSString *)updatedAt_;

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
 *  @discussion To be valid commentId and contentId must be a positive integer (>=1) and must have valid text and userid
 */
+(BOOL)isValidComment:(ApiComment *)comment;
/*!
 *  Prints ApiComment Object with all the properties
 *  @param comment An ApiComment Object to be printed
 */
+(void)printCommentInfo:(ApiComment  *)comment;

/*!
 *  Returns text tag for comment mode given the mode
 *  @param mode One of the comment mode
 *  @return a string containing the mode that is needed for the API calls
 */
+(NSString *)getCommentOderMode:(kAPICommentOrderMode)mode;

@end
