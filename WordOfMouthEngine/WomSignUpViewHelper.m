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
    
    // set custom textview properties
    
}

#pragma mark -  View Helper Methods: TextLabel
+ (UILabel *)getPageLabel{
    UILabel *label = [[UILabel alloc] init];
    [AppUIManager setUILabel:label];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:kAUCFontFamilySecondary size:60];
    label.textColor = [CommonUtility getColorFromHSBACVec:kAUCColorTextTeal];
    
    label.text = @"Signup";
    return label;
}


#pragma mark -  View Helper Methods: TextField
+ (void)setEmailTextFiled:(UITextField *)textField withDelegate:(id)delegate{
    // set app defaults
    //[AppUIManager setTextField:textField ofType:kAUCPriorityTypePrimary];
    
    // cutom settings
    // set textField properties
    //textField.backgroundColor = [UIColor whiteColor];
    //textField.borderStyle= UITextBorderStyleLine;
    textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"email" attributes:@{NSForegroundColorAttributeName:[CommonUtility getColorFromHSBACVec:kAUCColorGray]}];
    // textField.placeholder = @"email";
    
    // textField.text=@"";
    //textField.attributedText =
    textField.font = [UIFont fontWithName:kAUCFontFamilySecondary size:kAUCFontSizeTextField];
    textField.textColor =[CommonUtility getColorFromHSBACVec:kAUCColorLightTeal];
    //textField.textColor =[UIColor darkGrayColor];//[UIColor colorWithHue:kCRDPrimaryHue saturation:0.0 brightness:1.0 alpha:1.0];
    textField.textAlignment = NSTextAlignmentCenter;
    
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
    
    // set border
    [AppUIManager setBottomBorder:textField withColor:[CommonUtility getColorFromHSBACVec:kAUCColorLightTeal]];
    
    // for auto layout
    [textField setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    // accessibilty
    [textField setAccessibilityIdentifier:@"Email"];
}
+ (void)setPasswordTextFiled:(UITextField *)textField withDelegate:(id)delegate{
    // set app defaults
    //[AppUIManager setTextField:textField ofType:kAUCPriorityTypePrimary];
    
    // cutom settings
    // set textField properties
    //textField.backgroundColor = [UIColor whiteColor];
    //textField.borderStyle= UITextBorderStyleLine;
    textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"password" attributes:@{NSForegroundColorAttributeName:[CommonUtility getColorFromHSBACVec:kAUCColorGray]}];
    
    // textField.text=@"";
    //textField.attributedText =
    textField.font = [UIFont fontWithName:kAUCFontFamilySecondary size:kAUCFontSizeTextField];
    textField.textColor =[CommonUtility getColorFromHSBACVec:kAUCColorLightTeal];
    //textField.textColor =[UIColor darkGrayColor];//[UIColor colorWithHue:kCRDPrimaryHue saturation:0.0 brightness:1.0 alpha:1.0];
    textField.textAlignment = NSTextAlignmentCenter;
    
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
    textField.keyboardType = UIKeyboardTypeEmailAddress;
    
    // set left view
    // UILabel *label = [[UILabel alloc] init];
    //label.text = @"Email";
    //textField.leftView = label;
    
    // set border
    [AppUIManager setBottomBorder:textField withColor:[CommonUtility getColorFromHSBACVec:kAUCColorLightTeal]];
    
    // for auto layout
    [textField setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    // accessibilty
    [textField setAccessibilityIdentifier:@"Password"];
}
+ (void)setPasswordConfirmationTextFiled:(UITextField *)textField withDelegate:(id)delegate{
    // set app defaults
    //[AppUIManager setTextField:textField ofType:kAUCPriorityTypePrimary];
    
    // cutom settings
    // set textField properties
    //textField.backgroundColor = [UIColor whiteColor];
    //textField.borderStyle= UITextBorderStyleLine;
    textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"password" attributes:@{NSForegroundColorAttributeName:[CommonUtility getColorFromHSBACVec:kAUCColorGray]}];
    // textField.placeholder = @"email";
    
    // textField.text=@"";
    //textField.attributedText =
    textField.font = [UIFont fontWithName:kAUCFontFamilySecondary size:kAUCFontSizeTextField];
    textField.textColor =[CommonUtility getColorFromHSBACVec:kAUCColorLightTeal];
    //textField.textColor =[UIColor darkGrayColor];//[UIColor colorWithHue:kCRDPrimaryHue saturation:0.0 brightness:1.0 alpha:1.0];
    textField.textAlignment = NSTextAlignmentCenter;
    
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
    textField.keyboardType = UIKeyboardTypeEmailAddress;
    
    // set left view
    // UILabel *label = [[UILabel alloc] init];
    //label.text = @"Email";
    //textField.leftView = label;
    
    // set border
    [AppUIManager setBottomBorder:textField withColor:[CommonUtility getColorFromHSBACVec:kAUCColorLightTeal]];
    
    // for auto layout
    [textField setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    // accessibilty
    [textField setAccessibilityIdentifier:@"Password Confirmation"];
}

#pragma mark -  View Helper Methods: Buttons
+ (UIButton *)getSignUpButton{
    UIButton *button =  [AppUIManager setButtonWithTitle:@"complete signup" ofType:kAUCPriorityTypePrimary];
    [button.titleLabel setFont:[UIFont fontWithName:kAUCFontFamilySecondary  size:kAUCFontSizePrimary]];
    button.backgroundColor = [CommonUtility getColorFromHSBACVec:kAUCColorLightTeal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
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
