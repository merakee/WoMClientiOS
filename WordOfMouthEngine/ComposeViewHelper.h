//
//  ComposeViewHelper.h
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 2/15/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppUIManager.h"

static const float kPhotoOptionsViewLayout[4]={150,60,120,60};

@interface ComposeViewHelper : NSObject

#pragma mark -  View Helper Methods: Views
+ (void)setView:(UIView *)view;

#pragma mark -  View Helper Methods: Segmented control
+ (UISegmentedControl *)getCategoryControl;
+ (void)updateCategoryControl:(UISegmentedControl *)sControl forCategory:(kAPIContentCategory)category;

#pragma mark -  View Helper Methods: Buttons

#pragma mark -  View Helper Methods: TextViews
+ (UITextView *)getComposeTextViewWithDelegate:(id)delegate;

#pragma mark - photo options view
+ (UIView *)getPhotoOptionView;
+ (UIButton *)getCameraButton;
+ (UIButton *)getAlbumButton;

@end
