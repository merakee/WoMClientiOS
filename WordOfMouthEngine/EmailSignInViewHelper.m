//
//  EmailSignInViewHelper.m
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 2/15/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import "EmailSignInViewHelper.h"

@implementation EmailSignInViewHelper



#pragma mark -  View Helper Methods: Views
+ (void)setView:(UIView *)view{
    // set app defaults
    [AppUIManager setUIView:view ofType:kAUCPriorityTypePrimary];
    
    // set custom textview properties
    
}

#pragma mark -  View Helper Methods: TextField
+ (void)setEmailTextFiled:(UITextField *)textField withDelegate:(id)delegate{
    // set app defaults
    [AppUIManager setTextField:textField ofType:kAUCPriorityTypePrimary];
    
    // cutom settings
    // set textField properties
    //textField.backgroundColor = [UIColor whiteColor];
    //textField.borderStyle= UITextBorderStyleLine;
    textField.placeholder = @"Email/Id";
    
    // textField.text=@"";
    //textField.attributedText =
    //textField.font = [UIFont fontWithName:kSIVTextFontName size:kSIVNameTextFontSize];
    //textField.textColor =[UIColor darkGrayColor];//[UIColor colorWithHue:kCRDPrimaryHue saturation:0.0 brightness:1.0 alpha:1.0];
    
    textField.secureTextEntry = NO;
    textField.delegate=delegate;
    
    // text shadow: use layer property (UIField)
    //textField.layer.shadowColor = [HEXCOLOR (kCRDShadowWhiteColor) CGColor];
    //textField.layer.shadowColor = [HEXCOLOR (kCRDTextDropShadowColor) CGColor];
    // textField.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    // textField.layer.shadowOpacity = 0.6f;
    // textField.layer.shadowRadius = 0.0f;
    
    // set up key board
    //textField.returnKeyType = UIReturnKeyDone;
    textField.keyboardType = UIKeyboardTypeEmailAddress;
    
    // set left view
    // UILabel *label = [[UILabel alloc] init];
    //label.text = @"Email";
    //textField.leftView = label;
    
    // for auto layout
    [textField setTranslatesAutoresizingMaskIntoConstraints:NO];
}
+ (void)setPasswordTextFiled:(UITextField *)textField withDelegate:(id)delegate{
    // set app defaults
    [AppUIManager setTextField:textField ofType:kAUCPriorityTypePrimary];
    
    // cutom settings
    // set textField properties
    //textField.backgroundColor = [UIColor whiteColor];
    //textField.borderStyle= UITextBorderStyleLine;
    textField.placeholder = @"Password";
    // textField.text=@"";
    //textField.attributedText =
    //textField.font = [UIFont fontWithName:kSIVTextFontName size:kSIVNameTextFontSize];
    //textField.textColor =[UIColor darkGrayColor];//[UIColor colorWithHue:kCRDPrimaryHue saturation:0.0 brightness:1.0 alpha:1.0];
    
    textField.secureTextEntry = YES;
    textField.delegate=delegate;
    
    // text shadow: use layer property (UIField)
    //textField.layer.shadowColor = [HEXCOLOR (kCRDShadowWhiteColor) CGColor];
    //textField.layer.shadowColor = [HEXCOLOR (kCRDTextDropShadowColor) CGColor];
    // textField.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    // textField.layer.shadowOpacity = 0.6f;
    // textField.layer.shadowRadius = 0.0f;
    
    // set up key board
    //textField.returnKeyType = UIReturnKeyDone;
    textField.keyboardType = UIKeyboardTypeAlphabet;
    
    
    // set left view
    // UILabel *label = [[UILabel alloc] init];
    // label.text = @"Password";
    // textField.leftView = label;
    
    // for auto layout
    [textField setTranslatesAutoresizingMaskIntoConstraints:NO];
}


#pragma mark -  View Helper Methods: Buttons
+ (UIButton *)getSignInButton{
    return [AppUIManager setButtonWithTitle:@"Sign in" ofType:kAUCPriorityTypePrimary];
}


+ (UIButton *)getSignUpButton{
    return [AppUIManager setButtonWithTitle:@"Sign up" ofType:kAUCPriorityTypeSecondary];
}

@end
