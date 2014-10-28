//
//  ForgotPasswordViewHelper.m
//  WordOfMouthEngine
//
//  Created by Kevin Moy on 10/27/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import "ForgotPasswordViewHelper.h"

@implementation ForgotPasswordViewHelper

#pragma mark -  View Helper Methods: Views
+ (void)setView:(UIView *)view{
    // set app defaults
    [AppUIManager setUIView:view ofType:kAUCPriorityTypePrimary];
    view.backgroundColor = [UIColor whiteColor];
    // view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:[CommonUtility adjustImageFileName:kAUCSignUpInBackgroundImage]]];
    
    // set custom textview properties
    
}

#pragma mark -  View Helper Methods: TextLabel
+ (UILabel *)getPageLabel{
    return [AppUIManager getUILabelWithText:@"Reset Password" font:kAUCFontFamilyPrimary ofSize:30 color:kAUCColorTypeTextPrimary];
}

#pragma mark -  View Helper Methods: TextField
+ (void)setEmailTextFiled:(UITextField *)textField withDelegate:(id)delegate{
    // set app defaults
    [AppUIManager setTextField:textField placeholder:@"email"];
    textField.delegate=delegate;
    
    // set up key board
    textField.returnKeyType = UIReturnKeyDone;//UIReturnKeyGo;
    textField.keyboardType = UIKeyboardTypeEmailAddress;
    
    // accessibilty
    [textField setAccessibilityIdentifier:@"Email"];
}

#pragma mark -  View Helper Methods: Buttons
+ (UIButton *)getResetPasswordButton{
    //    UIButton *button =  [AppUIManager getTransparentUIButtonWithTitle:@"Login"
    //                                                                color:kAUCColorTypeTextSecondary
    //                                                                 font:kAUCFontFamilyPrimary
    //                                                                 size:kAUCFontSizeButtonSmall];
    UIButton *button =  [AppUIManager getTransparentUIButton];
    [button setImage:[UIImage imageNamed:kAUCLogInButtonImage] forState:UIControlStateNormal];
    [button setAccessibilityIdentifier:@"Login"];
    
    return button;
}


+ (UIButton *)getCancelButton{
    UIButton *button =  [AppUIManager getTransparentUIButton];
    [button setImage:[UIImage imageNamed:kAUCCancelButtonImage] forState:UIControlStateNormal];
    [button setAccessibilityIdentifier:@"Cancel"];
    return button;
}

@end
