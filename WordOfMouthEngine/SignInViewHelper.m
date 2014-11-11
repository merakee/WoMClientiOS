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
    // default setting
    [AppUIManager setImageView:iv];
    return iv;
}
//+ (UIImageView *)getButtonsView{
//    UIImageView *iv =[[UIImageView alloc] initWithImage:[UIImage imageNamed:kAUCSigninOptionsButtonsImage]];
//    // default setting
//    [AppUIManager setImageView:iv];
//    return iv;
//}

#pragma mark -  View Helper Methods: TextViews
+ (UILabel *)getDescriptionLabel{
    UILabel *dLabel =[[UILabel alloc] init];
    dLabel.backgroundColor = [UIColor clearColor];
    dLabel.text=@"Break outside your social network";
    dLabel.font = [UIFont fontWithName:kAUCFontFamilySecondary size:kAUCFontSizeDescriptionText];
    dLabel.textColor = [AppUIManager getColorOfType:kAUCColorTypeTextStroke];
    dLabel.textAlignment = NSTextAlignmentCenter;
    
  //  dLabel.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.45];//[UIColor whiteColor];
  //  dLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
    //phLabel.shadowRadius = 4.0f;
    
    
    [dLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    // accessibilty
    [dLabel setAccessibilityIdentifier:@"Description Label"];
    
    return dLabel;
}
+ (UILabel *)getLoginLabel{
    UILabel *lLabel =[[UILabel alloc] init];
    lLabel.backgroundColor = [UIColor clearColor];
    lLabel.text=@"Already a member?";
    lLabel.font = [UIFont fontWithName:kAUCFontFamilySecondary size:kAUCFontSizeLoginText];
    lLabel.textColor =[AppUIManager getColorOfType:kAUCColorTypeTextStroke];//[AppUIManager getColorOfType:kAUCColorTypeTextQuinary];
    lLabel.textAlignment = NSTextAlignmentCenter;
    
    //  dLabel.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.45];//[UIColor whiteColor];
    //  dLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
    //phLabel.shadowRadius = 4.0f;
    
    [lLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    // accessibilty
    [lLabel setAccessibilityIdentifier:@"Login Label"];
    
    return lLabel;
}


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
+ (UIButton *)getTermsButton{
    UIButton *button =  [AppUIManager getTransparentUIButton];
    [button setImage:[UIImage imageNamed:kAUCCancelButtonImage] forState:UIControlStateNormal];
    [button setAccessibilityIdentifier:@"Terms"];
    return button;
}
@end
