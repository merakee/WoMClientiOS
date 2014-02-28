//
//  SignInViewHelper.h
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 2/15/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppUIManager.h"

@interface SignInViewHelper : NSObject

// SignIn Images
#define kLIVCGoogleButtonImage     @"SocialSignin_Google.png"
#define kLIVCFacebookButtonImage     @"SocialSignin_Facebook.png"
#define kLIVCTwitterButtonImage     @"SocialSignin_Twitter.png"
#define kLIVCEmailButtonImage     @"SocialSignin_Email.png"


#pragma mark -  View Helper Methods: Views
+ (void)setView:(UIView *)view;

#pragma mark -  View Helper Methods: Buttons
+ (UIButton *)getGoogleButton;
+ (UIButton *)getFacebookButton;
+ (UIButton *)getTwitterButton;
+ (UIButton *)getEmailButton;
+ (UIButton *)getSignInAsGuestButton;
@end
