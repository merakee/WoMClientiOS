//
//  ContentInfo.h
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 2/15/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum {
    kAPIContentCategoryNews=1,
    kAPIContentCategorySecret=2,
    kAPIContentCategoryRumor=3,
    kAPIContentCategoryLocalInfo=4,
    kAPIContentCategoryOther=5
} kAPIContentCategory;


@interface ApiContent : NSObject{
    
}

@property NSNumber * contentId;
@property NSString *contentText;
@property NSNumber * userId;
@property NSNumber * categoryId;
@property NSString *photoToken;
@property NSString *timeStamp;
@property NSNumber * totalSpread;
@property NSNumber * spreadCount;
@property NSNumber * killCount;
@property NSNumber * noResponseCount;

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
        noResponseCount:(NSNumber * )noResponseCount_;

#pragma mark - Utility Methods
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
