//
//  ContentViewHelper.h
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 2/15/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppUIManager.h"
#import "CVCircleDownCounter.h"
#import "ContentManager.h"

// images
static NSString *kAUCSpreadButtonImage =@"spread.png";
static NSString *kAUCKillButtonImage =@"kill.png";
static NSString *kAUCComposeButtonImage =@"newtopic_btn.png";
static NSString *kAUCSignInButtonImage =@"wom_content_signInButton.png";
static NSString *kAUCSignOutButtonImage =@"wom_content_signOutButton.png";
static NSString *kAUCPageLogoImage =@"nav_logo.png";

@interface ContentViewHelper : NSObject


#pragma mark -  View Helper Methods: Views
+ (void)setView:(UIView *)view;
+ (UIImageView *)getContentBackGroundView;
+ (void)updateContentBackGroundView:(UIView *)view forCategory:(kAPIContentCategory)category;
+ (UIImage *)getImageForContentBackGroudView;

#pragma mark - View Helper Methods: Image Views
+ (UIImageView *)getUserImageView;
+ (UIImageView *)getPageLogoImageView;

#pragma mark -  View Helper Methods: TextViews
+ (UITextView *)getContentTextViewWithDelegate:(id)delegate;
+ (NSAttributedString *)getAttributedText:(NSString *)text;


#pragma mark -  View Helper Methods: Buttons
+ (UIButton *)getSpreadButton;
+ (UIButton *)getKillButton;
+ (UIButton *)getComposeButton;
+ (UIButton *)getSignInOutButton;

#pragma mark - Text label mathods
+ (UILabel *)getTextLabelForSpreadCount;
+ (UILabel *)getTextLabelForTimeCount;

#pragma mark -  View Helper Methods: ProgressView
+ (CVCircleCounterView *)getCounterViewWithDelegate:(id)delegate;
@end
