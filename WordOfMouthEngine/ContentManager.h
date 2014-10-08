//
//  ContentManager.h
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 2/13/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ApiContent.h"
#import "ApiManager.h"

@interface ContentManager : NSObject{
    NSMutableArray *contentArray;
    NSInteger       currentContentIndex;
}

#pragma mark - Content methods
- (void)getContentWithActivityIndicator:(UIActivityIndicatorView *)activitiyIndicator
                                 success:(void (^)(ApiContent *content))success
                                failure:(void (^)(ApiContent *content))failure;

#pragma mark - Utility methods
+ (NSArray *)getActiveCategoryList;
+ (NSString *)getCategoryTextForId:(kAPIContentCategory)category;
+ (kAPIContentCategory)getCategoryIdForText:(NSString *)categoryText;
- (void)clearContents;
@end
