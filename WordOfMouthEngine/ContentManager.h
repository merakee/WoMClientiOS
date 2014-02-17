//
//  ContentManager.h
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 2/13/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContentInfo.h"

@interface ContentManager : NSObject

#pragma mark - Content methods
+ (ContentInfo *)getContent;
@end
