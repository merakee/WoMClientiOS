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

#pragma mark -  View Helper Methods: TextField
+ (void)setEmailTextFiled:(UITextField *)textField withDelegate:(id)delegate{
    // set textField properties
    textField.backgroundColor = [UIColor whiteColor];
    textField.borderStyle= UITextBorderStyleLine;
        textField.placeholder = @"Email/Id";
    
    // textField.text=@"";
    //textField.attributedText =
    //textField.font = [UIFont fontWithName:kSIVTextFontName size:kSIVNameTextFontSize];
    textField.textColor =[UIColor darkGrayColor];//[UIColor colorWithHue:kCRDPrimaryHue saturation:0.0 brightness:1.0 alpha:1.0];
    
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
    // set textField properties
    textField.backgroundColor = [UIColor whiteColor];
    textField.borderStyle= UITextBorderStyleLine;
    textField.placeholder = @"Password";
    // textField.text=@"";
    //textField.attributedText =
    //textField.font = [UIFont fontWithName:kSIVTextFontName size:kSIVNameTextFontSize];
    textField.textColor =[UIColor darkGrayColor];//[UIColor colorWithHue:kCRDPrimaryHue saturation:0.0 brightness:1.0 alpha:1.0];
    
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
    UIButton *button  = [UIButton buttonWithType:UIButtonTypeCustom];
    // set image
    //[button setImage:[UIImage imageNamed:kLIVCGoogleButtonImage] forState:UIControlStateNormal];
    [button setTitle:@"Sign In" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor greenColor];
    // set button properties
    //button.frame = CGRectMake(20,200,160,90);
    // for auto layout
    [button setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    return button;
}
+ (UIButton *)getSignInAsGuestButton{
    UIButton *button  = [UIButton buttonWithType:UIButtonTypeCustom];
    // set image
    //[button setImage:[UIImage imageNamed:kLIVCGoogleButtonImage] forState:UIControlStateNormal];
    [button setTitle:@"Sign In As Guest" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor blueColor];
    // set button properties
    //button.frame = CGRectMake(20,200,160,90);
    // for auto layout
    [button setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    return button;
}

+ (UIButton *)getSignUpButton{
    UIButton *button  = [UIButton buttonWithType:UIButtonTypeCustom];
    // set image
    //[button setImage:[UIImage imageNamed:kLIVCGoogleButtonImage] forState:UIControlStateNormal];
    [button setTitle:@"Sign Up" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor lightGrayColor];
    // set button properties
    //button.frame = CGRectMake(20,200,160,90);
    // for auto layout
    [button setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    return button;
}

@end
