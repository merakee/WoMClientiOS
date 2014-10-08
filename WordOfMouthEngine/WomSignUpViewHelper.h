//
//  EmailSignInViewHelper.h
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 2/15/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppUIManager.h"

static NSString *kAUCSignupButtonImage =@"signup-nav-btn.png";

@interface WomSignUpViewHelper : NSObject


#pragma mark -  View Helper Methods: Views
+ (void)setView:(UIView *)view;

#pragma mark -  View Helper Methods: TextLabel
+ (UILabel *)getPageLabel;

#pragma mark -  View Helper Methods: TextField
+ (void)setEmailTextFiled:(UITextField *)textField withDelegate:(id)delegate;
+ (void)setPasswordTextFiled:(UITextField *)textField withDelegate:(id)delegate;
+ (void)setPasswordConfirmationTextFiled:(UITextField *)textField withDelegate:(id)delegate;

#pragma mark -  View Helper Methods: Buttons
+ (UIButton *)getSignUpButton;
+ (UIButton *)getCancelButton;
@end
