//
//  ContentManager.m
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 2/13/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import "ContentManager.h"
#import "CommonUtility.h"


@implementation ContentManager

#pragma mark -  Init Methods
- (id)init {
    if ((self = [super init])) {
        // init setting
        [self setAllDefaults];
    }
    return self;
}

- (void)setAllDefaults {
    contentArray =[[NSMutableArray alloc] init];
    currentContentIndex=0;
}

#pragma mark - Content methods
- (void)getContentWithActivityIndicator:(UIActivityIndicatorView *)activitiyIndicator
                                success:(void (^)(ApiContent *content))success
                                failure:(void (^)(ApiContent *content))failure {
    // if there is more content
    if(currentContentIndex<[contentArray count]){
        success(contentArray[currentContentIndex++]);
        return;
    }
    // else get content from api
    if(activitiyIndicator){
        [activitiyIndicator startAnimating];
    }
    // reset values
    currentContentIndex=0;
    [contentArray removeAllObjects];
    
    [[ApiManager sharedApiManager] getContentListSuccess:^(NSArray *contents){
        if(activitiyIndicator){
            [activitiyIndicator stopAnimating];
        }
        [contentArray setArray: contents];
        
        // check if api returned an empy array
        if(currentContentIndex<[contentArray count]){
            success(contentArray[currentContentIndex++]);
        }else{
            failure([ApiContent getEmptyContentNotice]);
        }
        
    }failure:^(NSError *error){
        [activitiyIndicator stopAnimating];
        [ApiErrorManager displayAlertWithError:error withDelegate:nil];
        failure([ApiContent getEmptyContentNotice]);
    }];
}

#pragma mark - Utility methods
+ (NSArray *)getActiveCategoryList{
    return @[@"News",@"Secret",@"Rumor",@"Local Info"];
}
+ (NSString *)getCategoryTextForId:(kAPIContentCategory)category{
    NSArray *cArray = [ContentManager getActiveCategoryList];
    if((category<1)||category>[cArray count]){
        return @"Other";
    }
    return cArray[category-1];
}

+ (kAPIContentCategory)getCategoryIdForText:(NSString *)categoryText{
    NSArray *cArray = [ContentManager getActiveCategoryList];
    NSUInteger index= [cArray indexOfObject:[CommonUtility trimString:categoryText]];
    if(index==NSNotFound){
        return kAPIContentCategoryOther;
    }
    
    return (kAPIContentCategory) index+1;
}

- (void)clearContents{
    [contentArray removeAllObjects];
}
@end
