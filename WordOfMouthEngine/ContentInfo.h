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

@property NSString *contentBody;
@property NSInteger authorId;
@property NSString *timeStamp;
@property NSInteger spreadCount;

#pragma mark - Init Methods
- (id)initWithBody:(NSString *)contentBody_
          authorId:(NSInteger )authorId_
         timeStamp:(NSString *)timeStamp_
       spreadCount:(NSInteger )spreadCount_;

#pragma mark - Utility Methods
+(void)printRewardInfo:(ContentInfo  *)ci;

@end
