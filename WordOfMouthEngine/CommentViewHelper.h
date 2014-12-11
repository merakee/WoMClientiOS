//
//  CommentViewHelper.h
//  WordOfMouthEngine
//
//  Created by Kevin Moy on 11/11/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppUIManager.h"
#import "ApiContent.h"
#import "CustomLilkeButton.h"

static NSString *kAURSendButtonImage = @"send-btn.png";
static NSString *kAUREmptyLikeImage = @"reply-heart-empty.png";
static NSString *kAURFilledLikeImage = @"reply-heart-full.png";
static NSString *kAURCloseButtonImage = @"close-btn.png";

@interface CommentViewHelper : NSObject

+ (void)setView:(UIView *)view;
+ (UIButton *)      getSendButton;
+ (CustomLilkeButton *)      getCellButton;
+ (UILabel *)       getCellText;
+ (UILabel *)       getLikeCount;
+ (UITextView *)    getCommentText:(id)delegate;

+ (UIButton *)      getCancelButton;

@property (nonatomic, strong) UILabel *getDescriptionLabel;
@end
