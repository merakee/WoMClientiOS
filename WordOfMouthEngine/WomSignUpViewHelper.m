//
//  EmailSignInViewHelper.m
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 2/15/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import "WomSignUpViewHelper.h"

@implementation WomSignUpViewHelper

#pragma mark -  View Helper Methods: Views
+ (void)setView:(UIView *)view{
    // set app defaults
    [AppUIManager setUIView:view ofType:kAUCPriorityTypePrimary];
    view.backgroundColor = [UIColor whiteColor];
    //[UIColor colorWithPatternImage:[UIImage imageNamed:[CommonUtility adjustImageFileName:kAUCSignUpInBackgroundImage]]];
    
    
    // set custom textview properties
    
}

#pragma mark -  View Helper Methods: TextLabel
+ (UILabel *)getPageLabel{
    return [AppUIManager getUILabelWithText:@"Signup" font:kAUCFontFamilyPrimary ofSize:kAUCFontSizePageLabel color:kAUCColorTypeTextPrimary];
}


#pragma mark -  View Helper Methods: TextField
+ (void)setEmailTextFiled:(UITextField *)textField withDelegate:(id)delegate{
    // set app defaults
    [AppUIManager setTextField:textField placeholder:@"email"];
    textField.delegate=delegate;
    
    // set up key board
    textField.returnKeyType = UIReturnKeyDone;//UIReturnKeyJoin;
    textField.keyboardType = UIKeyboardTypeEmailAddress;
    
    // accessibilty
    [textField setAccessibilityIdentifier:@"Email"];
}
+ (void)setPasswordTextFiled:(UITextField *)textField withDelegate:(id)delegate{
    // set app defaults
    [AppUIManager setTextField:textField placeholder:@"password"];
    textField.delegate=delegate;
    textField.secureTextEntry = YES;

    
    // set up key board
    textField.returnKeyType = UIReturnKeyDone;//UIReturnKeyJoin;
    textField.keyboardType = UIKeyboardTypeEmailAddress;
    
    // accessibilty
    [textField setAccessibilityIdentifier:@"Password"];
}
+ (void)setPasswordConfirmationTextFiled:(UITextField *)textField withDelegate:(id)delegate{
    // set app defaults
    [AppUIManager setTextField:textField placeholder:@"password"];
    textField.delegate=delegate;
    textField.secureTextEntry = YES;
    
    
    // set up key board
    textField.returnKeyType = UIReturnKeyDone;//UIReturnKeyJoin;
    textField.keyboardType = UIKeyboardTypeEmailAddress;
    
    // accessibilty
    [textField setAccessibilityIdentifier:@"Password Confirmation"];
}

#pragma mark -  View Helper Methods: Buttons
+ (UIButton *)getSignUpButton{
//    UIButton *button =  [AppUIManager getTransparentUIButtonWithTitle:@"Signup"
//                                                                color:kAUCColorTypeTextSecondary
//                                                                 font:kAUCFontFamilyPrimary
//                                                                 size:kAUCFontSizeButtonSmall];
    
    UIButton *button =  [AppUIManager getTransparentUIButton];
    [button setImage:[UIImage imageNamed:kAUCSignupButtonImage] forState:UIControlStateNormal];
    [button setAccessibilityIdentifier:@"complete signup"];
    return button;
}
+ (UIButton *)getCancelButton{
    UIButton *button =  [AppUIManager getTransparentUIButton];
    [button setImage:[UIImage imageNamed:kAUCCancelButtonImage] forState:UIControlStateNormal];
    [button setAccessibilityIdentifier:@"Cancel"];
    return button;
}

@end
