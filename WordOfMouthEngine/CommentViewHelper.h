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
#import "CustomLikeButton.h"
#import "CustomContentView.h"
#import "CustomFavoriteButton.h"
@interface CommentViewHelper : NSObject


+ (void)setView:(UIView *)view;
+ (UIView *)getNavigationShadow;

#pragma mark - Buttons
+ (UIButton *)      getSendButton;
+ (CustomLikeButton *)      getCellButton;
+ (UIButton *)      getCancelButton;
+ (UIButton *)      getShareButton;
+ (UIButton *)      getReportButton;
+ (CustomFavoriteButton *) getFavoriteButton;

#pragma mark - Content Data
+ (UILabel *)       getLikeCount;
+ (UITextView *)    getCommentText:(id)delegate;
+ (UILabel *)       getCellText;
+ (UIButton *)      getTouchLike;
+ (CustomContentView *)     getContentView;

#pragma mark - User Data
+ (UILabel *)       getNickname;
+ (UIImageView *)   getProfilePic;

#pragma mark - Custom Content Table Cell
+ (UIView *)        getCommentCountView;
+ (UILabel *)       getCommentCount;
@property (nonatomic, strong) UILabel *getDescriptionLabel;
@end
