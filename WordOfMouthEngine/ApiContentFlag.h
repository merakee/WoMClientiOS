//
//  ApiContentFlag.h
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 11/29/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

/*!
 * @header ApiContentFlag
 * Class for ApiContentFlag information and interfacing with BackEnd Api
 * @abstract ApiContentFlag  Interface
 * @author Bijit Halder
 * @version 2.0
 */

#import <Foundation/Foundation.h>

@interface ApiContentFlag : NSObject{
    
}

/*!
 * @brief  Conent Flag id
 */
@property NSNumber * contentFlagId;
/*!
 * @brief  Author user id
 */
@property NSNumber * userId;
/*!
 * @brief  Flagged content id
 */
@property NSNumber * contentId;


#pragma mark - Init Methods
- (id)initWithContentFlagId:(NSNumber *)contentFlagId_
                     userId:(NSNumber * )userId_
                  contentId:(NSNumber * )contentId_;

#pragma mark - Utility Methods
/*!
 *  Valdiates existence of contentFlag properties
 *  @param contentFlag An ApiContentFlag Object
 *  @return BOOL value indicating validity of the contentFlag object
 *  @discussion To be valid all contentFlag vaules must be nonnegative integer (>=0) and totalNewCount = likeCountNew + commentCountNew
 */
+(BOOL)isValidContentFlag:(ApiContentFlag *)contentFlag;
/*!
 *  Prints ApiContentFlag Object with all the properties
 *  @param contentFlag An ApiContentFlag Object to be printed
 */
+(void)printContentFlagInfo:(ApiContentFlag  *)contentFlag;

@end




