//
//  ContentInfo.h
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 2/15/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ContentInfo : NSObject{
    
}

@property NSInteger contentId;
@property NSString *contentBody;
@property NSInteger authorId;
@property NSInteger categoryId;
@property NSString *timeStamp;
@property NSInteger totalSpread;
@property NSInteger spreadCount;
@property NSInteger killCount;
@property NSInteger noResponseCount;

#pragma mark - Init Methods
- (id)initWithContentId:(NSInteger)contentId_
                   body:(NSString *)contentBody_
               authorId:(NSInteger )authorId_
             categoryId:(NSInteger )categoryId_
              timeStamp:(NSString *)timeStamp_
            totalSpread:(NSInteger )totalSpread_
            spreadCount:(NSInteger )spreadCount_
              killCount:(NSInteger )killCount_
        noResponseCount:(NSInteger )noResponseCount_;

#pragma mark - Utility Methods
+(void)printContentInfo:(ContentInfo  *)ci;

@end
