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

@synthesize delegate;


#pragma mark -  Init Methods
- (id)init {
    if ((self = [super init])) {
        // init setting
        [self setAllDefaults];
    }
    return self;
}

- (void)setAllDefaults {
    self.delegate=nil;
    localContentDatabase = [[LocalContentDatabase alloc] init];
}

#pragma mark -  instance Methods
- (void)postContent:(ContentInfo *)ci{
    // do things to post content
    [self setUpContentWithInfo:ci];
    
    // check validity
    NSError *error=[self isPostValid:ci];
    if(error==nil){
        // post content
        // let delegate know it is done
        [self notifySuccessfulPost];
    }
    else{
        [self notifyFailedPostWithError:error];
    }
}

- (void)setUpContentWithInfo:(ContentInfo *)ci{
    
}
#pragma mark - Delegate method
- (void)notifySuccessfulPost{
    if ([self.delegate respondsToSelector:@selector(contentPostedSuccessfully)]) {
        [self.delegate contentPostedSuccessfully];
    }
}
- (void)notifyFailedPostWithError:(NSError *)error{
    if ([self.delegate respondsToSelector:@selector(contentPostFailedWithError:)]) {
        [self.delegate contentPostFailedWithError:error];
    }
}



#pragma mark - Content methods
- (ContentInfo *)getContent{
    return [localContentDatabase getContent];
}
+ (NSString *)getRandomString{
    NSString *string = [NSString stringWithFormat:@"This is default content body (id %d). is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",[CommonUtility pickRandom:30000]];
    
    
    
    return [string substringWithRange:NSMakeRange(0,16+[CommonUtility pickRandom:500])];
}
+ (void)killContent:(ContentInfo *)ci{
    // mark content for this user as killed
}
+ (void)spreadContent:(ContentInfo *)ci{
    // mark content for this user as spread
}

#pragma mark - Post content method
- (NSError *)isPostValid:(ContentInfo *)ci{
    // if empty body
    if([CommonUtility isEmptyString:ci.contentBody]){
        NSError *error =[CommonUtility getErrorWithDomain:kAppErrorDomainContent
                                                     code:kContentErrorPostEmpty
                                              description:@"Empty Post"
                                                   reason:@"Content body is empty"
                                               suggestion:@"Enter text and post"];
        return error;
    }
    // too short
    if([ci.contentBody length]<kContentPostLengthMin){
        NSError *error =[CommonUtility getErrorWithDomain:kAppErrorDomainContent
                                                     code:kContentErrorPostTooShort
                                              description:@"Post too short"
                                                   reason:@"Content body is too short"
                                               suggestion:@"Enter more text and post"];
        return error;
    }
    
    // too long
    if([ci.contentBody length]>kContentPostLengthMax){
        NSError *error =[CommonUtility getErrorWithDomain:kAppErrorDomainContent
                                                     code:kContentErrorPostTooLong
                                              description:@"Post too long"
                                                   reason:@"Content body is too long"
                                               suggestion:@"Shorten text and post"];
        return error;
    }

    // invalid category
    if((ci.categoryId<1)||((ci.categoryId>[[ContentManager getActiveCategoryList] count]))){
        NSError *error =[CommonUtility getErrorWithDomain:kAppErrorDomainContent
                                                     code:kContentErrorInvalidCategory
                                              description:@"Invalid Category"
                                                   reason:@"Category id invalid"
                                               suggestion:@"Please select a category"];
        return error;
    }
    
    // default : no error
    return nil;
}


#pragma mark - Utility methods
+ (NSArray *)getActiveCategoryList{
    return @[@"News",@"Gossip",@"Secret",@"Local"];
}
+ (NSString *)getCategoryTextForId:(ACMContentCategory)category{
    NSArray *cArray = [ContentManager getActiveCategoryList];
    if((category<1)||category>[cArray count]){
        return @"Other";
    }
    return [cArray objectAtIndex:category-1];
}

+ (ACMContentCategory)getCategoryIDForText:(NSString *)categoryText{
    NSArray *cArray = [ContentManager getActiveCategoryList];
    NSUInteger index= [cArray indexOfObject:[CommonUtility trimString:categoryText]];
    if(index==NSNotFound){
        return kContentCategoryOther;
    }
    
    return (ACMContentCategory) index+1;
}

@end
