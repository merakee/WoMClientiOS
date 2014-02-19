//
//  ContentManager.h
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 2/13/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContentInfo.h"


@protocol ContentManagerDelegate <NSObject>
@required
-(void)contentPostedSuccessfully;
@optional

@end


@interface ContentManager : NSObject{

}

@property (assign, nonatomic) id <ContentManagerDelegate>  delegate;

#pragma mark -  instance Methods
- (void)postContent:(ContentInfo *)ci;
    
#pragma mark - Content methods
+ (ContentInfo *)getContent;
+ (void)killContent:(ContentInfo *)ci;
+ (void)spreadContent:(ContentInfo *)ci;

@end
