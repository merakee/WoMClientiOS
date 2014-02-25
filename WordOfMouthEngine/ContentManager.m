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
+ (ContentInfo *)getContent{
    
    NSString  *body =[NSString stringWithFormat:@"This is default content body (id %d). This will hold the text for the content. Here is a link google.com. And here is more text",[CommonUtility pickRandom:30000]];
    ContentInfo *ci  =[[ContentInfo alloc] initWithBody:body
                                               authorId:1000
                                              timeStamp:@"default time stamp"
                                            spreadCount:500];
    
    return ci;
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
    
    // default : no error
    return nil;
}


@end
