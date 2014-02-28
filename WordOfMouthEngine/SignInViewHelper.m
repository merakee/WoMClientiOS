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
    
    // set custom view properties
    
}
#pragma mark -  View Helper Methods: Buttons
+ (UIButton *)getGoogleButton{
    return [AppUIManager setButtonWithTitle:@"Sign in with Google" ofType:kAUCPriorityTypeSecondary];
}
+ (UIButton *)getFacebookButton{
    return [AppUIManager setButtonWithTitle:@"Sign in with Facebook" ofType:kAUCPriorityTypeSecondary];
}

+ (UIButton *)getTwitterButton{
    return [AppUIManager setButtonWithTitle:@"Sign in with Twitter" ofType:kAUCPriorityTypeSecondary];
}
+ (UIButton *)getEmailButton{
    return [AppUIManager setButtonWithTitle:@"Sign in with WoM" ofType:kAUCPriorityTypePrimary];
}
+ (UIButton *)getSignInAsGuestButton{
    return [AppUIManager setButtonWithTitle:@"Sign in as Guest" ofType:kAUCPriorityTypeSecondary];
}
@end
