//
//  JSONResponseSerializerWithData.h
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 7/9/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import "AFURLResponseSerialization.h"

// NSError userInfo key that will contain response data
static NSString * const JSONResponseSerializerWithDataKey = @"JSONResponseSerializerWithDataKey";

@interface JSONResponseSerializerWithData : AFJSONResponseSerializer

@end
