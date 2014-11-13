//
//  RepliesViewHelper.h
//  WordOfMouthEngine
//
//  Created by Kevin Moy on 11/10/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppUIManager.h"
#import "ApiContent.h"

// images
static NSString *kAUCXButtonImage = @"reply-X.png";
static NSString *kAUCSendButtonImage = @"reply-send-btn.png";

@interface RepliesViewHelper : NSObject

+ (void)setView:(UIView *)view;

#pragma mark - Scroll View helper
+ (UIScrollView *)getScrollView;

#pragma mark -  View Helper Methods: TextViews
+ (UITextView *)getRepliesTextViewWithDelegate:(id)delegate;

#pragma mark - View Helper Methods: Button Methods
+ (UIButton *)getBackButton;
+ (UIButton *)getSendButton;

#pragma mark -  View Helper Methods: Labels
+ (UILabel *)getPlaceHolderLabel;

@end