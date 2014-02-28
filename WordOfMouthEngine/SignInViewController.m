//
//  SignInViewController.m
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 2/15/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import "SignInViewController.h"
#import "SignInViewHelper.h"
#import "EmailSignInViewController.h"
#import "AppDelegate.h"

@implementation SignInViewController


#pragma mark -  View Life cycle Methods

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
    [super loadView];
    // view customization code
    [self setView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

// Implement viewWillAppear method for setting up the display
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // hide navigation bar
    [self.navigationController setNavigationBarHidden:YES];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (BOOL)shouldAutorotate{
    return  YES;
}
- (NSUInteger)supportedInterfaceOrientations{
    return [AppUIManager getSupportedOrentation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -  Local Methods Implememtation
- (void)setView {
    // set view
    [SignInViewHelper setView:self.view];
    
    // set navigation bar
    [self setNavigationBar];
    
    // set buttons
    googleButton = [SignInViewHelper getGoogleButton];
    [googleButton addTarget:self action:@selector(googleButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:googleButton];
    
    // set buttons
    facebookButton = [SignInViewHelper getFacebookButton];
    [facebookButton addTarget:self action:@selector(facebookButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:facebookButton];
    
    // set buttons
    twitterButton = [SignInViewHelper getTwitterButton];
    [twitterButton addTarget:self action:@selector(twitterButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:twitterButton];
    
    // set buttons
    emailButton = [SignInViewHelper getEmailButton];
    [emailButton addTarget:self action:@selector(emailButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:emailButton];
    
    // set buttons
    signInAsGuestButton = [SignInViewHelper getSignInAsGuestButton];
    [signInAsGuestButton addTarget:self action:@selector(signInAsGuestButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:signInAsGuestButton];
    
    
    // set app logo view
    appLogoView = [AppUIManager getAppLogoView];
    [self.view addSubview:appLogoView];
    
    // layout
    [self layoutView];
}

- (void)layoutView{
    // all view elements
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(appLogoView,googleButton,facebookButton,twitterButton,emailButton,signInAsGuestButton);
    
    // buttons
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-30-[appLogoView(50)]-20-[googleButton(42)]-12-[facebookButton(googleButton)]-12-[twitterButton(googleButton)]-75-[emailButton(googleButton)]-24-[signInAsGuestButton(googleButton)]"                                                                      options:0 metrics:nil views:viewsDictionary]];
    
    // Center horizontally
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[appLogoView(50)]"                                                                      options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:appLogoView
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.0
                                                           constant:0.0]];
    
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[googleButton]-|"                                                                      options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[facebookButton]-|"                                                                      options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[twitterButton]-|"                                                                      options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[emailButton]-|"                                                                      options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[signInAsGuestButton]-|"                                                                      options:0 metrics:nil views:viewsDictionary]];
    
}

- (void)setNavigationBar {
    // app settings
    [AppUIManager setNavbar:self.navigationController.navigationBar];
    
    // set up navigation bar
    self.navigationItem.title = @"Sign In";
    
    // right navigation button
    /*self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
     initWithBarButtonSystemItem:UIBarButtonSystemItemCompose
     target:self
     action:@selector(goToAddContentView:)];
     
     */
    
    
    // set up back button for the child view
    self.navigationItem.backBarButtonItem =  [[UIBarButtonItem alloc]
                                              initWithTitle:@"Cancel"
                                              style:UIBarButtonItemStylePlain
                                              target:nil
                                              action:nil];
    
    
}


#pragma mark - Button Action Methods
- (void)googleButtonPressed:(id)sender {
    [CommonUtility displayAlertWithTitle:@"Not Active" message:@"Please sign in with email" delegate:self];
}

- (void)facebookButtonPressed:(id)sender {
    [CommonUtility displayAlertWithTitle:@"Not Active" message:@"Please sign in with email" delegate:self];
}
- (void)twitterButtonPressed:(id)sender {
    [CommonUtility displayAlertWithTitle:@"Not Active" message:@"Please sign in with email" delegate:self];
}
- (void)emailButtonPressed:(id)sender {
    // push email view controller
    EmailSignInViewController *emlivc =[[EmailSignInViewController   alloc] init];
    [self.navigationController pushViewController:emlivc animated:NO];
}

- (void)signInAsGuestButtonPressed:(id)sender {
    // set up session manager
    [SessionManager sharedSessionManager].delegateSignIn = self;
    [[SessionManager sharedSessionManager] SignInAsGuest];
}

#pragma mark - Session Manager delegate protocal method
- (void)signedInFailedWithErrors:(NSError *)error{
    [CommonUtility displayAlertWithTitle:error.localizedDescription message:error.localizedRecoverySuggestion delegate:self];
}
- (void)signedInSuccessfullyWithUser:(UserInfo *)user{
    // switch to content view
    [(AppDelegate *)[UIApplication sharedApplication].delegate setCoreFunctionViewAsRootView];
    
}

@end
