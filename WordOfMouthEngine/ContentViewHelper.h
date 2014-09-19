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
#import "AppAnimationManager.h"

// images
static NSString *kAUCSpreadButtonImage =@"spread-btn.png";
static NSString *kAUCKillButtonImage =@"kill-btn.png";
static NSString *kAUCComposeButtonImage =@"newtopic-btn.png";
static NSString *kAUCSignOutButtonImage =@"signout-nav-btn.png";
static NSString *kAUCPageLogoImage =@"logo-nav.png";

//static NSString *  kAUCContentBackgroundImage = @"content";

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
//+ (UILabel *)getTextLabelForSpreadCount;
//+ (UILabel *)getTextLabelForTimeCount;

#pragma mark -  View Helper Methods: ProgressView
+ (CVCircleCounterView *)getCounterViewWithDelegate:(id)delegate;

#pragma mark - Animation
+ (void)animateButtonWithSlideUpAndReturn:(UIButton *)button  withFinalAction:(void (^)())action;
+ (void)animateButtonWithSlideFromDown:(UIButton *)button  withFinalAction:(void (^)())action;
+ (void)animateButtonWithSlideFromDownAndUpShoot:(UIButton *)button  withFinalAction:(void (^)())action;
@end
