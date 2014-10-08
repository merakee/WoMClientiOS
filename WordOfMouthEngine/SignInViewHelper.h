//
//  SignInViewHelper.h
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 2/15/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppUIManager.h"

// SignIn Images
/*
static NSString *  kLIVCGoogleButtonImage   =  @"SocialSignin_Google.png";
static NSString *  kLIVCFacebookButtonImage   =  @"SocialSignin_Facebook.png";
static NSString *  kLIVCTwitterButtonImage  =   @"SocialSignin_Twitter.png";
static NSString *  kLIVCEmailButtonImage    = @"SocialSignin_Email.png";
*/

static NSString *  kAUCSigninOptionsLogoImage = @"launch-logo.png";
static NSString *  kAUCSignUpButtonImage  = @"signup-btn.png";
static NSString *  kAUCSignInButtonImage  = @"login-btn.png";
static NSString *  kAUCGuestButtonImage  = @"guest-btn.png";


@interface SignInViewHelper : NSObject


#pragma mark -  View Helper Methods: Views
+ (void)setView:(UIView *)view;

#pragma mark - Labels
//+ (UILabel *)getPageLabel;

#pragma mark -  View Helper Methods: UIImages
+ (UIImageView *)getLogoView;
//+ (UIImageView *)getButtonsView;



#pragma mark -  View Helper Methods: Buttons
//+ (UIButton *)getGoogleButton;
//+ (UIButton *)getFacebookButton;
//+ (UIButton *)getTwitterButton;
+ (UIButton *)getSignInButton;
+ (UIButton *)getSignUpButton;
+ (UIButton *)getSignInAsGuestButton;
@end
