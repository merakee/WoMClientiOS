//
//  SignInViewController.m
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 2/15/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import "SignInViewController.h"
#import "SignInViewHelper.h"
#import "WomSignInViewController.h"
#import "WomSignUpViewController.h"
#import "AppDelegate.h"
#import "FlurryManager.h"

@implementation SignInViewController


#pragma mark -  View Life cycle Methods

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
    [super loadView];
    // view customization code
    [self setView];
    
}
- (void) viewDidLayoutSubviews {
    
    // add circular crop to image view
    // [AppUIManager setCircularCropToImageView:appLogoView];
    
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
    
    //    // set buttons
    //    googleButton = [SignInViewHelper getGoogleButton];
    //    [googleButton addTarget:self action:@selector(googleButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    //    [self.view addSubview:googleButton];
    //
    //    // set buttons
    //    facebookButton = [SignInViewHelper getFacebookButton];
    //    [facebookButton addTarget:self action:@selector(facebookButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    //    [self.view addSubview:facebookButton];
    //
    //    // set buttons
    //    twitterButton = [SignInViewHelper getTwitterButton];
    //    [twitterButton addTarget:self action:@selector(twitterButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    //    [self.view addSubview:twitterButton];
    
    // set lables
//    pageLabel = [SignInViewHelper getPageLabel];
//    [self.view addSubview:pageLabel];
    
    // set app logo view
    appLogoView = [SignInViewHelper getLogoView];
    [self.view addSubview:appLogoView];

//    // set buttons view
//    buttonsView = [SignInViewHelper getButtonsView];
//    [self.view addSubview:buttonsView];
    
    // set buttons
    signInButton = [SignInViewHelper getSignInButton];
    [signInButton addTarget:self action:@selector(signInButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:signInButton];
    
    // set buttons
    signUpButton = [SignInViewHelper getSignUpButton];
    [signUpButton addTarget:self action:@selector(signUpButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:signUpButton];
    
    
    // set buttons
    signInAsGuestButton = [SignInViewHelper getSignInAsGuestButton];
    [signInAsGuestButton addTarget:self action:@selector(signInAsGuestButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:signInAsGuestButton];
    
    //activity indicator view
    activityIndicator =[[UIActivityIndicatorView alloc] init];
    [AppUIManager addActivityIndicator:activityIndicator toView:self.view];
    
    // layout
    [self layoutView];
}

- (void)layoutView{
    // all view elements
    //NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(appLogoView,buttonsView,signInButton,signUpButton,signInAsGuestButton,activityIndicator);
    //NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(pageLabel,signInButton,signUpButton,signInAsGuestButton,activityIndicator);
    
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(appLogoView,signInButton,signUpButton,signInAsGuestButton,activityIndicator);
    
//    // images
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[appLogoView(234)]-40-[buttonsView]|"                                                                      options:0 metrics:nil views:viewsDictionary]];
//    
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[buttonsView]|"
//                                                                      options:0 metrics:nil views:viewsDictionary]];
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[appLogoView(192)]"
//                                                                      options:0 metrics:nil views:viewsDictionary]];
    // Center horizontally
    // Center
    //[AppUIManager horizontallyCenterElement:appLogoView inView:self.view];
    
    //
    //    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[googleButton]-|"
    //                                                                      options:0 metrics:nil views:viewsDictionary]];
    //    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[facebookButton]-|"
    //                                                                      options:0 metrics:nil views:viewsDictionary]];
    //    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[twitterButton]-|"
    //                                                                      options:0 metrics:nil views:viewsDictionary]];
    
    // page label
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[appLogoView(172)]"
                                                                      options:0 metrics:nil views:viewsDictionary]];
    [AppUIManager horizontallyCenterElement:appLogoView inView:self.view];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[appLogoView(215)]-35-[signUpButton]"
                                                                      options:0 metrics:nil views:viewsDictionary]];
    //buttons
    // [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-30-[appLogoView(50)]-50-[signInButton(42)]-25-[signUpButton(signInButton)]-50-[signInAsGuestButton(signInButton)]" options:0 metrics:nil views:viewsDictionary]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[signInButton(70)]"
                                                                      options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[signUpButton(126)]"
                                                                      options:0 metrics:nil views:viewsDictionary]];
    [AppUIManager horizontallyCenterElement:signUpButton inView:self.view];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[signInAsGuestButton(signInButton)]|"
                                                                      options:0 metrics:nil views:viewsDictionary]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[signInButton(92)]-50-|"
                                                                      options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[signUpButton(126)]-37-|"
                                                                      options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[signInAsGuestButton(signInButton)]-50-|"
                                                                      options:0 metrics:nil views:viewsDictionary]];
    

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
    //    self.navigationItem.backBarButtonItem =  [[UIBarButtonItem alloc]
    //                                              initWithTitle:@"Cancel"
    //                                              style:UIBarButtonItemStylePlain
    //                                              target:nil
    //                                              action:nil];
    
    
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
- (void)signInButtonPressed:(id)sender {
    // Analytics: Flurry
    [Flurry logEvent:[FlurryManager getEventName:kFAUserSessionSignIn]];
    // push wom Sign in controller
    WomSignInViewController *womsivc =[[WomSignInViewController   alloc] init];
    [self.navigationController pushViewController:womsivc animated:NO];
}

- (void)signUpButtonPressed:(id)sender {
    // Analytics: Flurry
    [Flurry logEvent:[FlurryManager getEventName:kFAUserSessionSignUp]];
    // push wom Sign up controller
    WomSignUpViewController *womsuvc =[[WomSignUpViewController   alloc] init];
    [self.navigationController pushViewController:womsuvc animated:NO];
}

- (void)signInAsGuestButtonPressed:(id)sender {
    // Analytics: Flurry
    [Flurry logEvent:[FlurryManager getEventName:kFAUserSessionGuestSignIn]];
    
    // sign in anonymous user
    [activityIndicator startAnimating];
    [[ApiManager sharedApiManager] signInUserWithUserTypeId:kAPIUserTypeAnonymous
                                                      email:nil
                                                   password:nil
                                                    success:^(void){
                                                        [activityIndicator stopAnimating];
                                                        [self actionsForSuccessfulAnonymusUserSignIn];
                                                    }failure:^(NSError * error){
                                                        // Analytics: Flurry
                                                        [Flurry logEvent:[FlurryManager getEventName:kFAUserSessionGuestSignInFailure] withParameters:@{@"Error": error}];
                                                        [activityIndicator stopAnimating];
                                                        [ApiErrorManager displayAlertWithError:error withDelegate:self];
                                                    }];
}

#pragma mark - Api Manager Post actions methods
- (void)actionsForSuccessfulAnonymusUserSignIn{
    // Analytics: Flurry
    [Flurry logEvent:[FlurryManager getEventName:kFAUserSessionGuestSignInSuccess]];
    // switch to content view
    [(AppDelegate *)[UIApplication sharedApplication].delegate setContentViewAsRootView];
}

@end
