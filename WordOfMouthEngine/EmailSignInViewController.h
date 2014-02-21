//
//  EmailSignInViewController.h
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 2/15/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SessionManager.h"

@interface EmailSignInViewController : UIViewController<UITextFieldDelegate,SessionManagerDelegate>{
    UITextField        *emailField;
    UITextField        *passwordField;
    UIButton           *SignInButton;
    UIButton           *signUpButton;
    UIButton           *signInAsGuestButton;
}

@end
