//
//  ContentManager.m
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 2/13/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import "ContentManager.h"

@implementation ContentManager


#pragma mark - Content methods
+ (ContentInfo *)getContent{
    
    ContentInfo *ci  =[[ContentInfo alloc] initWithBody:@"This is default content body. This will hold the test for the content"
                                               authorId:1000
                                              timeStamp:@"default time stamp"
                                            spreadCount:500];
    
    return ci;
}
@end
