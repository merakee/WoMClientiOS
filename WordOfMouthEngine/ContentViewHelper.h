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
static NSString *kAUCMapButtonImage =@"mapicon.jpeg";
static NSString *kAUCSpreadButtonImage =@"spread-btn.png";
static NSString *kAUCSpreadButtonFilledImage= @"spread-btn-full.png";
static NSString *kAUCKillButtonImage =@"kill-btn.png";
static NSString *kAUCKillButtonFilledImage= @"kill-btn-full.png";
static NSString *kAUCComposeButtonImage =@"compose.png";
static NSString *kAUCSignOutButtonImage =@"logout-menu.png";
static NSString *kAUCLogInMenuButtonImage =@"signup-menu.png";
static NSString *kAUCPageLogoImage =@"logo-nav.png";
static NSString *kAUCShareButtonImage =@"share-btn.png";
static NSString *kAUCReplyButtonImage =@"reply-btn.png";
static NSString *kAUCReportButtonImage =@"flag-btn.png";
static NSString *kAUCSettingsButtonImage =@"profile-btn.png";
static NSString *kAUCContentLoadingImage =@"content-loading";
static NSString *kAUCAlertOnImage = @"alert-on.png";
static NSString *kAUCSpreadIcon = @"spread-icon.png";

//static NSString *  kAUCContentBackgroundImage = @"content";

@interface ContentViewHelper : NSObject


#pragma mark -  View Helper Methods: Views
+ (void)setView:(UIView *)view;
+ (UIImageView *)getContentBackGroundView;
+ (void)updateContentBackGroundView:(UIView *)view forCategory:(kAPIContentCategory)category;
+ (UIImage *)getImageForContentBackGroudView;
+ (void)setSignInAndOutView:(UIView *)view;
+ (void)setAnimationView:(UIView *)view withSpead:(UIImageView *)spreadView andKill:(UIImageView *)killView;

#pragma mark - View Helper Methods: Image Views
+ (UIImageView *)getUserImageView;
+ (UIImageView *)getPageLogoImageView;
+ (UIImageView *)getSpreadIcon;
+ (UIImageView *)getBlurredImage;

#pragma mark -  View Helper Methods: TextViews
+ (UITextView *)getContentTextViewWithDelegate:(id)delegate;
+ (NSAttributedString *)getAttributedText:(NSString *)text;


#pragma mark -  View Helper Methods: Buttons
+ (UIButton *)getSpreadButton;
+ (UIButton *)getKillButton;
+ (UIButton *)getPageLogoButton;
+ (UIButton *)getSignInOutButton;
+ (UIButton *)getDismissButton;
+ (UIButton *)getRepliesButton;
+ (UIButton *)getMapButton;
+ (UIButton *)getShareButton;
+ (UIButton *)getProfilePic;
+ (UIButton *)getNicknameButton;
+ (UIButton *)getNotificationButton;


#pragma mark - Text label mathods
//+ (UILabel *)getTextLabelForSpreadCount;
//+ (UILabel *)getTextLabelForTimeCount;
+ (UILabel *)getNicknameLabel;

#pragma mark -  View Helper Methods: ProgressView
+ (CVCircleCounterView *)getCounterViewWithDelegate:(id)delegate;

#pragma mark - Animation
+ (void)animateViewsForContentDisplay:(NSArray *)views withFinalAction:(void (^)())action;
+ (void)animateViews:(NSArray *)views forUserResponse:(BOOL)response withFinalAction:(void (^)())action;
//+ (void)animateButtonWithSlideUpAndReturn:(UIButton *)button  withFinalAction:(void (^)())action;
//+ (void)animateButtonWithSlideFromDown:(UIButton *)button  withFinalAction:(void (^)())action;
//+ (void)animateButtonWithSlideFromDownAndUpShoot:(UIButton *)button  withFinalAction:(void (^)())action;

#pragma mark - Toolbar Buttons
+ (UIButton *)getReportButton;
+ (UIButton *)getViewsImage;
+ (UIButton *)getCommentImage;
+ (UILabel *)getSpreadsCount;
+ (UILabel *)getCommentsCount;

#pragma mark - Navigation Buttons
+ (UIButton *)getSettingsButton;
+ (UIButton *)getComposeButton;

#pragma mark - Utility Method
+ (NSString *)convertCommentCount:(NSNumber *)count;
+ (NSString *)convertSpreadCount:(NSNumber *)count;
@end
