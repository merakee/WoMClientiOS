//
//  SignInViewHelper.m
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 2/15/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import "SignInViewHelper.h"

@implementation SignInViewHelper



#pragma mark -  View Helper Methods: Views
+ (void)setView:(UIView *)view{
    // set app defaults
    [AppUIManager setUIView:view ofType:kAUCPriorityTypePrimary];
    //view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:[CommonUtility adjustImageFileName:kAUCSigninOptionsBackgroundImage]]];
    view.backgroundColor = [UIColor whiteColor];
    
    // set custom view properties
    //[view setAccessibilityIdentifier:@"Sign in options View"];
    //[view setIsAccessibilityElement:YES];
}

#pragma mark -  View Helper Methods: UIImages
+ (UIImageView *)getLogoView{
    UIImageView *iv =[[UIImageView alloc] initWithImage:[UIImage imageNamed:kAUCSigninOptionsLogoImage]];
    // defautl setting
    [AppUIManager setImageView:iv];
    return iv;
}
//+ (UIImageView *)getButtonsView{
//    UIImageView *iv =[[UIImageView alloc] initWithImage:[UIImage imageNamed:kAUCSigninOptionsButtonsImage]];
//    // defautl setting
//    [AppUIManager setImageView:iv];
//    return iv;
//}

#pragma mark - Labels
//+ (UILabel *)getPageLabel{
//    return [AppUIManager getUILabelWithText:@"Spark" font:kAUCFontFamilyPrimary ofSize:kAUCFontSizePageLabel color:kAUCColorTypeTextPrimary];
//}
#pragma mark -  View Helper Methods: Buttons
//+ (UIButton *)getGoogleButton{
//    return [AppUIManager setButtonWithTitle:@"Sign in with Google" ofType:kAUCPriorityTypeSecondary];
//}
//+ (UIButton *)getFacebookButton{
//    return [AppUIManager setButtonWithTitle:@"Sign in with Facebook" ofType:kAUCPriorityTypeSecondary];
//}
//
//+ (UIButton *)getTwitterButton{
//    return [AppUIManager setButtonWithTitle:@"Sign in with Twitter" ofType:kAUCPriorityTypeSecondary];
//}
+ (UIButton *)getSignInButton{
    //   return [AppUIManager setButtonWithTitle:@"Sign in" ofType:kAUCPriorityTypeSecondary];
//    UIButton *button =[AppUIManager getTransparentUIButtonWithTitle:@"Login"
//                                                              color:kAUCColorTypeTextSecondary
//                                                               font:kAUCFontFamilyPrimary
//                                                               size:kAUCFontSizeButtonNormal];
    
    UIButton *button =  [AppUIManager getTransparentUIButton];
    [button setImage:[UIImage imageNamed:kAUCSignInButtonImage] forState:UIControlStateNormal];
    
    [button setAccessibilityIdentifier:@"Sign in"];
    return button;
}
+ (UIButton *)getSignUpButton{
    // return [AppUIManager setButtonWithTitle:@"Sign up" ofType:kAUCPriorityTypeSecondary];
//    UIButton *button =[AppUIManager getTransparentUIButtonWithTitle:@"Signup"
//                                                              color:kAUCColorTypeTextSecondary
//                                                               font:kAUCFontFamilyPrimary
//                                                               size:kAUCFontSizeButtonLarge];
//    
    UIButton *button =  [AppUIManager getTransparentUIButton];
    [button setImage:[UIImage imageNamed:kAUCSignUpButtonImage] forState:UIControlStateNormal];
    
    [button setAccessibilityIdentifier:@"Sign up"];
    return button;
}
+ (UIButton *)getSignInAsGuestButton{
    //return [AppUIManager setButtonWithTitle:@"Sign in as Guest" ofType:kAUCPriorityTypeSecondary];
//    UIButton *button =[AppUIManager getTransparentUIButtonWithTitle:@"Guest"
//                                                              color:kAUCColorTypeTextSecondary
//                                                               font:kAUCFontFamilyPrimary
//                                                               size:kAUCFontSizeButtonNormal];
    
    UIButton *button =  [AppUIManager getTransparentUIButton];
    [button setImage:[UIImage imageNamed:kAUCGuestButtonImage] forState:UIControlStateNormal];
    
    [button setAccessibilityIdentifier:@"Sign in as Guest"];
    return button;
}
@end
