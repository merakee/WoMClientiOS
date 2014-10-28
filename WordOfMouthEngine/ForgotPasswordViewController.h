//
//  ForgotPasswordViewController.h
//  WordOfMouthEngine
//
//  Created by Kevin Moy on 10/27/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppUIManager.h"

@interface ForgotPasswordViewController : UIViewController <UITextFieldDelegate>{
    UILabel            *pageLabel;
    UITextField        *emailField;
    UIButton           *resetPasswordButton;
    UIButton           *cancelButton;
    UIActivityIndicatorView *activityIndicator;
}
@end
