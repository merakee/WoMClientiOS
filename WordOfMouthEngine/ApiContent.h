//
//  ContentInfo.h
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 2/15/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//


/*!
 * @header ApiContent
 * Class for Content information and interfacing with BackEnd Api
 * @abstract ApiContent Interface
 * @author Bijit Halder
 * @version 2.0
 */

#import <Foundation/Foundation.h>

/*!
 * @typedef kAPIContentCategory
 * @brief A list of Content Category
 * @constant kAPIContentCategoryEmpty
 * @constant kAPIContentCategoryNews
 * @constant kAPIContentCategorySecret
 * @constant kAPIContentCategoryRumor
 * @constant kAPIContentCategoryLocalInfo
 * @constant kAPIContentCategoryOther
 */

typedef enum {
    kAPIContentCategoryEmpty=0,
    kAPIContentCategoryNews=1,
    kAPIContentCategorySecret=2,
    kAPIContentCategoryRumor=3,
    kAPIContentCategoryLocalInfo=4,
    kAPIContentCategoryOther=5
} kAPIContentCategory;



@interface ApiContent : NSObject{
    
}

/*!
 * @brief Content id
 */
@property NSNumber * contentId;
/*!
 * @brief  Text of the content
 */
@property NSString *contentText;
/*!
 * @brief  Author User id
 */
@property NSNumber * userId;
/*!
 * @brief  Id for content category
 */
@property NSNumber * categoryId;
/*!
 * @brief  Photo token - link to S3 bucket
 */
@property NSDictionary *photoToken;
/*!
 * @brief  Total number of responses: spread_count + kill_count
 */
@property NSNumber * totalSpread;
/*!
 * @brief  Total number of spreads
 */
@property NSNumber * spreadCount;
/*!
 * @brief  Total number of kills
 */
@property NSNumber * killCount;
/*!
 * @brief  Total number of comments
 */
@property NSNumber * commentCount;
/*!
 * @brief  Total number of new comments
 */
@property NSNumber * commentCountNew;
/*!
 * @brief  Time Stamp for when it was created (GMT)
 */
@property NSString *createdAt;
/*!
 * @brief  Time Stamp for when it was last updated (GMT)
 */
@property NSString *updatedAt;


#pragma mark - Init Methods
- (id)initWithContentId:(NSNumber *)contentId_
                   text:(NSString *)contentText_
               userId:(NSNumber * )userId_
             categoryId:(NSNumber * )categoryId_
              photoToken:(NSDictionary *)photoToken_
            totalSpread:(NSNumber * )totalSpread_
            spreadCount:(NSNumber * )spreadCount_
              killCount:(NSNumber * )killCount_
        commentCount:(NSNumber * )commentCount_
        commentCountNew:(NSNumber * )commentCountNew_
              createdAt:(NSString *)createdAt_
              updatedAt:(NSString *)updatedAt_;

#pragma mark - Utility Methods
/*!
 *  Generates an content with empty notice and EmptyContent category
 *  @return An APiContent Object
 */
+ (ApiContent *)getEmptyContentNotice;
/*!
 *  Valdiates existence of content properties: contentId, categoryId, text, and userId
 *  @param content An ApiContent Object
 *  @return BOOL value indicating validity of the content object
 *  @discussion To be valid contentId must be a positive integer (>=1) and contentTypeId must be between 1 and 4: [1 4]
 */
+(BOOL)isValidContent:(ApiContent *)content;
/*!
 *  Prints ApiContent Object with all the properties
 *  @param content An ApiContent Object to be printed
 */
+(void)printContentInfo:(ApiContent  *)content;

@end
