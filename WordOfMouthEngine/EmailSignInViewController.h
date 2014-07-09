//
//  EmailSignInViewController.h
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 2/15/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ApiManager.h"

@interface EmailSignInViewController : UIViewController<UITextFieldDelegate,ApiManagerDelegate>{
    UITextField        *emailField;
    UITextField        *passwordField;
    UIButton           *SignInButton;
    UIButton           *signUpButton;

}

@end
