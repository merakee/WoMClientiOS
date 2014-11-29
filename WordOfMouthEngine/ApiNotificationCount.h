//
//  ApiNotificationCount.h
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 11/29/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

/*!
 * @header ApiNotificationCount
 * Class for ApiNotificationCount information and interfacing with BackEnd Api
 * @abstract ApiNotificationCount  Interface
 * @author Bijit Halder
 * @version 2.0
 */

#import <Foundation/Foundation.h>

@interface ApiNotificationCount : NSObject{
    
}
/*!
 * @brief  Author user id
 */
@property NSNumber * userId;
/*!
 * @brief  Total number of new items: new comments + new likes
 */
@property NSNumber * totalNewCount;
/*!
 * @brief  Total number of new likes
 */
@property NSNumber * likeCountNew;
/*!
 * @brief  Total number of comment
 */
@property NSNumber * commentCountNew;

#pragma mark - Init Methods
- (id)initWithUserId:(NSNumber * )userId_
           totalNewCount:(NSNumber * )totalNewCount_
           commentCountNew:(NSNumber * )commentCountNew_
           likeCountNew:(NSNumber * )likeCountNew_;

#pragma mark - Utility Methods
/*!
 *  Valdiates existence of notificationCount properties
 *  @param notificationCount An ApiNotificationCount Object
 *  @return BOOL value indicating validity of the notificationCount object
 *  @discussion To be valid all notificationCount vaules must be nonnegative integer (>=0) and totalNewCount = likeCountNew + commentCountNew
 */
+(BOOL)isValidNotificationCount:(ApiNotificationCount *)notificationCount;
/*!
 *  Prints ApiNotificationCount Object with all the properties
 *  @param notificationCount An ApiNotificationCount Object to be printed
 */
+(void)printNotificationCountInfo:(ApiNotificationCount  *)notificationCount;

@end



