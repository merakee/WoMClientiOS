//
//  ContentManager.h
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 2/13/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContentInfo.h"
#import "LocalContentDatabase.h"

#define kAppErrorDomainContent  @"ContentErrorDomain"

typedef enum {
    kContentErrorNone=0,
    kContentErrorPostEmpty,
    kContentErrorPostTooShort,
    kContentErrorPostTooLong,
    kContentErrorPostInvalid,
} ACMContentErrorCode;

typedef enum {
    kContentCetegoryOther=0,
    kContentCetegoryNews,
    kContentCetegoryGossip,
    kContentCetegorySecret,
    kContentCetegoryLocal,
} ACMContentCategory;

static const int kContentPostLengthMin = 5;
static const int kContentPostLengthMax = 500;


@protocol ContentManagerDelegate <NSObject>
@required
-(void)contentPostedSuccessfully;
-(void)contentPostFailedWithError:(NSError *)error;
@optional

@end


@interface ContentManager : NSObject{
    LocalContentDatabase  *localContentDatabase;
}

@property (assign, nonatomic) id <ContentManagerDelegate>  delegate;

#pragma mark -  instance Methods
- (void)postContent:(ContentInfo *)ci;

#pragma mark - Content methods
- (ContentInfo *)getContent;
+ (void)killContent:(ContentInfo *)ci;
+ (void)spreadContent:(ContentInfo *)ci;

@end
