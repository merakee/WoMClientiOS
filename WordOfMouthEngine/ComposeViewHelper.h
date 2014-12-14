//
//  ComposeViewHelper.h
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 2/15/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppUIManager.h"
#import "ApiContent.h"

//static const float kPhotoOptionsViewLayout[4]={150,60,120,60};

// images
static NSString *kAUCPostButtonImage =@"post-active-btn.png";
static NSString *kAUCPostInactiveButtonImage =@"post-inactive-btn.png";
static NSString *kAUCCameraOptionsButtonImage =@"cam-btn.png";
static NSString *kAUCComposeSpreadButtonImage = @"compose-spread-btn.png";
static NSString *kAUCDeleteImageButtonImage = @"delete-img-btn.png";
static NSString *kAUCBackButtonImage =@"back-btn.png";
static NSString *kAUCKeyboardButtonImage =@"keyboard-icon.png";
static NSString *kAUCKeyboardActiveButtonImage = @"keyboard-active-icon.png";
static NSString *kAUCTextColorButtonImage = @"text-color-icon.png";
static NSString *kAUCTextColorActiveButtonImage = @"text-color-icon-active.png";
static NSString *kAUCCheckIconButtonImage = @"check-icon.png";
static NSString *kAUCClearIconButtonImage = @"clear-icon.png";

//static NSString *kAUCCancelButtonImage =@"";
static const NSInteger kAUCComposePhotoOptionsActionSheetTag = 231;

@interface ComposeViewHelper : NSObject

#pragma mark -  View Helper Methods: Views
+ (void)setView:(UIView *)view;

#pragma mark - ImageView
+ (UIImageView *)getContentImageView;

#pragma mark -  View Helper Methods: Segmented control
//+ (UISegmentedControl *)getCategoryControl;
//+ (void)updateCategoryControl:(UISegmentedControl *)sControl forCategory:(kAPIContentCategory)category;

#pragma mark -  View Helper Methods: Buttons
+ (UIButton *)getCancelButton;
+ (UIButton *)getPostButton;
+ (UIButton *)getCameraOptionsButton;
+ (UIButton *)getBackButton;
+ (UIButton *)getDoneButton;
+ (UIButton *)getRemoveImageButton;

#pragma mark -  View Helper Methods: Labels
+ (UILabel *)getPlaceHolderLabel;
+ (UILabel *)getPlaceHolderLabel2;
+ (UILabel *)getCharacterCountLabel;

#pragma mark -  View Helper Methods: TextViews
+ (UITextView *)getComposeTextViewWithDelegate:(id)delegate;

#pragma mark - photo options view
//+ (UIView *)getPhotoOptionView;
+ (UIButton *)getCameraButton;
+ (UIButton *)getAlbumButton;

#pragma mark - toolbar buttons
+ (UIButton *)getImageButton;
+ (UIButton *)getTextButton;
+ (UIButton *)getFilterButton;

#pragma mark - input accessory buttons
+ (UIButton *)getXButton;
+ (UIButton *)getCheckButton;
+ (UIButton *)getTextColorButton;
+ (UIButton *)getKeyboardButton;

#pragma mark - text color buttons
+ (UIButton *)getColor1;
+ (UIButton *)getColor2;
+ (UIButton *)getColor3;
+ (UIButton *)getColor4;
+ (UIButton *)getColor5;
+ (UIButton *)getColor6;
+ (UIButton *)getColor7;
+ (UIButton *)getColor8;


#pragma mark - Toolbars
//+ (UIToolbar *)getKeyboardToolbar;

@end
