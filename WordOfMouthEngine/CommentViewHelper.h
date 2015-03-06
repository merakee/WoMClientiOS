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

#pragma mark - Buttons
+ (UIButton *)      getSendButton;
+ (CustomLilkeButton *)      getCellButton;
+ (UIButton *)      getCancelButton;
+ (UIButton *)      getShareButton;
+ (UIButton *)      getReportButton;

#pragma mark - Content Data
+ (UILabel *)       getLikeCount;
+ (UITextView *)    getCommentText:(id)delegate;
+ (UILabel *)       getCellText;
+ (UIButton *)      getTouchLike;
+ (CustomContentView *)     getContentView;

#pragma mark - User Data
+ (UILabel *)       getNickname;
+ (UIImageView *)   getProfilePic;

@property (nonatomic, strong) UILabel *getDescriptionLabel;
@end
