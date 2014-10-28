//
//  ForgotPasswordViewHelper.h
//  WordOfMouthEngine
//
//  Created by Kevin Moy on 10/27/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppUIManager.h"

@interface ForgotPasswordViewHelper : NSObject

#pragma mark -  View Helper Methods: Views
+ (void)setView:(UIView *)view;

#pragma mark -  View Helper Methods: TextLabel
+ (UILabel *)getPageLabel;

#pragma mark -  View Helper Methods: TextField
+ (void)setEmailTextFiled:(UITextField *)textField withDelegate:(id)delegate;

#pragma mark -  View Helper Methods: Buttons
+ (UIButton *)getResetPasswordButton;
+ (UIButton *)getCancelButton;

@end
