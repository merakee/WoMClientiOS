//
//  EmailSignInViewHelper.m
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 2/15/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import "LoginViewHelper.h"

@implementation LoginViewHelper

#pragma mark -  View Helper Methods: Views
+ (void)setView:(UIView *)view{
    // set app defaults
    [AppUIManager setUIView:view ofType:kAUCPriorityTypePrimary];
    view.backgroundColor = [CommonUtility getColorFromHSBACVec:kAUCColorLoginBackground];
    //[UIColor colorWithPatternImage:[UIImage imageNamed:[CommonUtility adjustImageFileName:kAUCSignUpInBackgroundImage]]];
    
    // set custom textview properties
    
}

#pragma mark -  View Helper Methods: TextLabel
+ (UILabel *)getPageLabel{
    // Label at top of the page
    return [AppUIManager getUILabelWithText:@"Signup" font:kAUCFontFamilyPrimary ofSize:kAUCFontSizePageLabel color:kAUCColorTypeTextPrimary];
}

#pragma mark - View Helper Methods: ImageViews
+ (UIImageView *)getTitleImage{
    UIImageView *imageView =[[UIImageView alloc] init];
    // set app defaults
    [imageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    imageView.image = [UIImage imageNamed:kAUCLoginTitleImage];
    return imageView;

}

#pragma mark -  View Helper Methods: TextField
+ (void)setEmailTextFiled:(UITextField *)textField withDelegate:(id)delegate{
    // set app defaults
    [AppUIManager setTextField:textField placeholder:@"email"];
    textField.delegate=delegate;
    
    textField.backgroundColor = [CommonUtility getColorFromHSBACVec:kAUCColorLoginField];
    // set up key board
    textField.returnKeyType = UIReturnKeyDone;//UIReturnKeyJoin;
    textField.keyboardType = UIKeyboardTypeEmailAddress;
    textField.textAlignment= NSTextAlignmentCenter;
    textField.textColor = [CommonUtility getColorFromHSBACVec:kAUCColorLoginTextField];
    // accessibilty
    [textField setAccessibilityIdentifier:@"Email"];
}
+ (void)setPasswordTextFiled:(UITextField *)textField withDelegate:(id)delegate{
    // set app defaults
    [AppUIManager setTextField:textField placeholder:@"password"];
    textField.delegate=delegate;
    textField.secureTextEntry = YES;
    textField.backgroundColor = [CommonUtility getColorFromHSBACVec:kAUCColorLoginField];
    
    // set up key board
    textField.returnKeyType = UIReturnKeyDone;//UIReturnKeyJoin;
    textField.keyboardType = UIKeyboardTypeEmailAddress;
    textField.textAlignment= NSTextAlignmentCenter;
    textField.textColor = [CommonUtility getColorFromHSBACVec:kAUCColorLoginTextField];
    
    // accessibilty
    [textField setAccessibilityIdentifier:@"Password"];
}
//+ (void)setPasswordConfirmationTextFiled:(UITextField *)textField withDelegate:(id)delegate{
//    // set app defaults
//    [AppUIManager setTextField:textField placeholder:@"password"];
//    textField.delegate=delegate;
//    textField.secureTextEntry = YES;
//    
//    
//    // set up key board
//    textField.returnKeyType = UIReturnKeyDone;//UIReturnKeyJoin;
//    textField.keyboardType = UIKeyboardTypeEmailAddress;
//    
//    // accessibilty
//    [textField setAccessibilityIdentifier:@"Password Confirmation"];
//}

#pragma mark -  View Helper Methods: Buttons
+ (UIButton *)getSignUpButton{
    UIButton *button =  [AppUIManager getTransparentUIButton];
    [button setImage:[UIImage imageNamed:kAUCGoButtonImage] forState:UIControlStateNormal];
    [button setAccessibilityIdentifier:@"Signup"];
    return button;
}

+ (UIButton *)getCancelButton{
    UIButton *button =  [AppUIManager getTransparentUIButton];
    [button setImage:[UIImage imageNamed:kAUCCancelButtonImage] forState:UIControlStateNormal];
    [button setAccessibilityIdentifier:@"Cancel"];
    return button;
}

+ (UIButton *)getForgotPasswordButton{
    UIButton *button =  [AppUIManager getTransparentUIButton];
    [button setImage:[UIImage imageNamed:kAUCForgotPasswordImage] forState:UIControlStateNormal];
    [button setAccessibilityIdentifier:@"Forgot Password"];
    return button;
}
@end
