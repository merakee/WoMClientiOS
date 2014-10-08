//
//  SignInAndOutViewController.m
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 9/18/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import "SignInAndOutViewController.h"
#import "ContentViewHelper.h"
#import "ApiManager.h"
#import "AppDelegate.h"
#import "FlurryManager.h"

@implementation SignInAndOutViewController


- (void)viewDidLoad{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // view customization code
    [self setView];
    //self.modalPresentationStyle = UIModalTransitionStyleCoverVertical;//UIModalPresentationCurrentContext;
    self.modalPresentationStyle = UIModalPresentationFormSheet;
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // update sign in button title
    [self updateSignInOutButtonTitle];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setView {
    //self.view.frame =[[UIScreen mainScreen] applicationFrame];
    // sign in out view
    [ContentViewHelper setSignInAndOutView:self.view];
    
    dismissButton = [ContentViewHelper getDismissButton];
    [dismissButton  addTarget:self action:@selector(dismissButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dismissButton];
    
    signInOutButton = [ContentViewHelper getSignInOutButton];
    [signInOutButton addTarget:self action:@selector(signInOutButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:signInOutButton];
    
    //activity indicator view
    activityIndicator =[[UIActivityIndicatorView alloc] init];
    [AppUIManager addActivityIndicator:activityIndicator toView:self.view];
    
    // layout
    [self layoutView];
    
    // scroll adjustment
    //self.automaticallyAdjustsScrollViewInsets = NO;
    
}

- (void)layoutView{
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(signInOutButton,dismissButton);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[signInOutButton(80)]"
                                                                      options:0 metrics:nil views:viewsDictionary]];
    [AppUIManager horizontallyCenterElement:signInOutButton inView:self.view];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-40-[signInOutButton(80)]"
                                                                      options:0 metrics:nil views:viewsDictionary]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[dismissButton]|"
                                                                      options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[dismissButton]|"
                                                                      options:0 metrics:nil views:viewsDictionary]];
    
}

- (void)dismissSignInOutButtonView{
    [super dismissViewControllerAnimated:NO completion:^{}];
}

- (void)updateSignInOutButtonTitle{
    // left navigation button
    if([[ApiManager sharedApiManager] isAnonymousUser]){
        //self.navigationItem.leftBarButtonItem.title = @"Sign In";
        [signInOutButton setImage:[UIImage imageNamed:kAUCLogInMenuButtonImage] forState:UIControlStateNormal];
    }
    else{
        //self.navigationItem.leftBarButtonItem.title =@"Sign Out";
        [signInOutButton setImage:[UIImage imageNamed:kAUCSignOutButtonImage] forState:UIControlStateNormal];
    }
}

#pragma mark - Button Action Methods
- (void)signInOutButtonPressed:(id)sender {
    if(![[ApiManager sharedApiManager] isAnonymousUser]){
        // sign out user
        [activityIndicator startAnimating];
        [[ApiManager sharedApiManager] signOutUserSuccess:^(void){
            // Analytics: Flurry
            [Flurry logEvent:[FlurryManager getEventName:kFAUserSessionSignOut]];
            [activityIndicator stopAnimating];
            [self signedOutSuccessfully];
        }failure:^(NSError * error){
            [activityIndicator stopAnimating];
            //[ApiErrorManager displayAlertWithError:error withDelegate:self];
            // Do not display any error: just sign user out
            [self signedOutSuccessfully];
        }];
    }
    else{
        [self signedOutSuccessfully];
    }
}

- (void)dismissButtonPressed:(id)sender{
    [self dismissSignInOutButtonView];
}

#pragma mark - Session methods
- (void)signedOutSuccessfully{
    // clear content 
    [(AppDelegate *)[UIApplication sharedApplication].delegate  clearContents];
    
    [self dismissSignInOutButtonView];
    
    // go to sign in view
    [(AppDelegate *)[UIApplication sharedApplication].delegate  setSignInViewAsRootView];
}


@end
