//
//  ContentViewHelper.h
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 2/15/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppUIManager.h"

@interface ContentViewHelper : NSObject


#pragma mark -  View Helper Methods: Views
+ (void)setView:(UIView *)view;
+ (UIView *)getTextBackGroundView;

#pragma mark - View Helper Methods: Image Views
+ (UIImageView *)getUserImageView;

#pragma mark -  View Helper Methods: TextViews
+ (UITextView *)getContentTextViewWithDelegate:(id)delegate;

#pragma mark -  View Helper Methods: Buttons
+ (UIButton *)getSpreadButton;
+ (UIButton *)getKillButton;

#pragma mark - Text label mathods
+ (UILabel *)getTextLabelForSpreadCount;
+ (UILabel *)getTextLabelForTimeCount;

@end
