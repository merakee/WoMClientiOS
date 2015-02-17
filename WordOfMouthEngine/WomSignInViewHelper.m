//
//  EmailSignInViewHelper.m
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 2/15/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import "WomSignInViewHelper.h"

@implementation WomSignInViewHelper



#pragma mark -  View Helper Methods: Views
+ (void)setView:(UIView *)view{
    // set app defaults
    [AppUIManager setUIView:view ofType:kAUCPriorityTypePrimary];
    view.backgroundColor = [CommonUtility getColorFromHSBACVec:kAUCColorLoginBackground];
}

#pragma mark -  View Helper Methods: TextLabel
+ (UILabel *)getPageLabel{
    return [AppUIManager getUILabelWithText:@"Login" font:kAUCFontFamilyPrimary ofSize:kAUCFontSizePageLabel color:kAUCColorTypeTextPrimary];
}
#pragma mark - View Helper Methods: ImageViews
+ (UIImageView *)getProfileImageView{
    UIImageView *contentImageView =[[UIImageView alloc] init];
    contentImageView.contentMode = UIViewContentModeScaleAspectFill;
    [contentImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    contentImageView.clipsToBounds = YES;
    return contentImageView;
}
+ (UIImageView *)getTitleImage{
    UIImageView *imageView =[[UIImageView alloc] init];
    // set app defaults
    [imageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    imageView.image = [UIImage imageNamed:kAUCSignupTitleImage];
    return imageView;
}

+ (UIImageView *)getFullExperienceImage{
    UIImageView *imageView =[[UIImageView alloc] init];
    // set app defaults
    [imageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    imageView.image = [UIImage imageNamed:kAUCFullExperienceImage];
    return imageView;
}
#pragma mark -  View Helper Methods: TextField
+ (void)setEmailTextFiled:(UITextField *)textField withDelegate:(id)delegate{
    // set app defaults
    [AppUIManager setTextField:textField placeholder:@"email"];
    textField.delegate=delegate;
    textField.backgroundColor = [CommonUtility getColorFromHSBACVec:kAUCColorLoginField];
    textField.textAlignment= NSTextAlignmentCenter;
    // set up key board
    textField.returnKeyType = UIReturnKeyNext;
  //  textField.returnKeyType = UIReturnKeyDone;//UIReturnKeyGo;
    textField.keyboardType = UIKeyboardTypeEmailAddress;
    textField.textColor = [CommonUtility getColorFromHSBACVec:kAUCColorLoginTextField];
    // accessibilty
    [textField setAccessibilityIdentifier:@"Email"];
}
+ (void)setPasswordTextFiled:(UITextField *)textField withDelegate:(id)delegate{
    // set app defaults
    [AppUIManager setTextField:textField placeholder:@"password"];
    textField.delegate=delegate;
    textField.backgroundColor = [CommonUtility getColorFromHSBACVec:kAUCColorLoginField];
    textField.secureTextEntry = YES;
    textField.textAlignment= NSTextAlignmentCenter;
    
    // set up key board
    textField.returnKeyType = UIReturnKeyDone;// UIReturnKeyGo;
   // textField.keyboardType = UIKeyboardTypeEmailAddress;
    textField.textColor = [CommonUtility getColorFromHSBACVec:kAUCColorLoginTextField];
    // accessibilty
    [textField setAccessibilityIdentifier:@"Password"];
}

+ (void)setNicknameTextFiled:(UITextField *)textField withDelegate:(id)delegate{
    // set app defaults
    [AppUIManager setTextField:textField placeholder:@"Nickname"];
    textField.delegate=delegate;
    textField.backgroundColor = [CommonUtility getColorFromHSBACVec:kAUCColorLoginField];
    textField.textAlignment= NSTextAlignmentCenter;
    
    // set up key board
    textField.returnKeyType = UIReturnKeyDone;// UIReturnKeyGo;
    // textField.keyboardType = UIKeyboardTypeEmailAddress;
    textField.textColor = [CommonUtility getColorFromHSBACVec:kAUCColorLoginTextField];
    // accessibilty
    [textField setAccessibilityIdentifier:@"Nickname"];
}


#pragma mark -  View Helper Methods: Buttons
+ (UIButton *)getNextButton{
    UIButton *button =  [AppUIManager getTransparentUIButton];
    [button setImage:[UIImage imageNamed:kAUCNextButtonImage] forState:UIControlStateNormal];
    [button setAccessibilityIdentifier:@"Next"];
    return button;
}
+ (UIButton *)getSignInButton{
    UIButton *button =  [AppUIManager getTransparentUIButton];
    [button setImage:[UIImage imageNamed:kAUCLogInButtonImage] forState:UIControlStateNormal];
    [button setAccessibilityIdentifier:@"Login"];
    return button;
}

+ (UIButton *)getCancelButton{
    UIButton *button =  [AppUIManager getTransparentUIButton];
    [button setImage:[UIImage imageNamed:kAUCCancelButtonImage] forState:UIControlStateNormal];
    [button setFrame:CGRectMake(0, 0, 40, 40)];
    [button setAccessibilityIdentifier:@"Cancel"];
    return button;
}

+ (UIButton *)getResetPasswordButton{
    UIButton *button =  [AppUIManager getTransparentUIButton];
    [button setImage:[UIImage imageNamed:kAUCCancelButtonImage] forState:UIControlStateNormal];
    [button setAccessibilityIdentifier:@"Reset"];
    return button;
}
+ (UIButton *)getDoneButton{
    UIButton *button =  [AppUIManager getTransparentUIButton];
    [button setImage:[UIImage imageNamed:kAUCDoneButtonImage] forState:UIControlStateNormal];
    [button setAccessibilityIdentifier:@"Signup"];
    return button;
}
+ (UIButton *)getCameraButton{
    UIButton *button =  [AppUIManager getTransparentUIButton];
    [button setImage:[UIImage imageNamed:kAUCCameraButtonImage] forState:UIControlStateNormal];
    [button setAccessibilityIdentifier:@"Camera"];
    [button setTranslatesAutoresizingMaskIntoConstraints:NO];
    return button;
}
@end
