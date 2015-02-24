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
#import "CustomContentView.h"

@interface CommentViewHelper : NSObject

+ (void)setView:(UIView *)view;
+ (UIButton *)      getSendButton;
+ (CustomLilkeButton *)      getCellButton;
+ (UILabel *)       getCellText;
+ (UILabel *)       getLikeCount;
+ (UITextView *)    getCommentText:(id)delegate;
+ (UIButton *)      getCancelButton;
+ (UIButton *)      getTouchLike;
+ (CustomContentView *)     getContentView;

@property (nonatomic, strong) UILabel *getDescriptionLabel;
@end
