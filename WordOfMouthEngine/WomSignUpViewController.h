//
//  EmailSignInViewController.h
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 2/15/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ApiManager.h"

@interface WomSignUpViewController : UIViewController<UITextFieldDelegate>{
    UILabel            *pageLabel;
    UITextField        *emailField;
    UITextField        *passwordField;
    UITextField        *passwordConfirmationField;
    UIButton           *signUpButton;
    UIButton           *cancelButton;
    UIActivityIndicatorView *activityIndicator;
}

@end
