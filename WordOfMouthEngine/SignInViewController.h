//
//  SignInViewController.h
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 2/15/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ApiManager.h"

@interface SignInViewController : UIViewController{
    //UIButton           *googleButton;
    //UIButton           *facebookButton;
    //UIButton           *twitterButton;
    UIButton             *signInButton;
    UIButton             *signUpButton;
    UIButton             *signInAsGuestButton;
    
    UIActivityIndicatorView *activityIndicator;
    
    //UILabel              *pageLabel;
    UIImageView        *appLogoView;
    //UIImageView        *buttonsView;
}

@end
