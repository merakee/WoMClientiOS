//
//  EmailSignInViewController.m
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 2/15/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import "WomSignInViewController.h"
#import "WomSignInViewHelper.h"
#import "WomSignUpViewController.h"
#import "AppDelegate.h"
#import "FlurryManager.h"

@implementation WomSignInViewController

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
    
    // display key board
    [emailField becomeFirstResponder];
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
    [WomSignInViewHelper setView:self.view];
    
    // set navigation bar
    //[self setNavigationBar];
    
    // set lables
    pageLabel = [WomSignInViewHelper getPageLabel];
    [self.view addSubview:pageLabel];
    
    // set buttons
    signInButton = [WomSignInViewHelper getSignInButton];
    [signInButton addTarget:self action:@selector(signInButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:signInButton];
    
    cancelButton = [WomSignInViewHelper getCancelButton];
    [cancelButton addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelButton];
    
    
    //text Fileds
    emailField =[[UITextField alloc] init];
    [WomSignInViewHelper setEmailTextFiled:emailField withDelegate:self];
    [self.view addSubview:emailField];
    
    passwordField =[[UITextField alloc] init];
    [WomSignInViewHelper setPasswordTextFiled:passwordField withDelegate:self];
    [self.view addSubview:passwordField];
    
    
    //activity indicator view
    activityIndicator =[[UIActivityIndicatorView alloc] init];
    [AppUIManager addActivityIndicator:activityIndicator toView:self.view];
    
    
    // layout
    [self layoutView];
}

- (void)layoutView{
    // all view elements
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(pageLabel,emailField,passwordField,signInButton,cancelButton);
    
    // labels
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[pageLabel(120)]"                                                                      options:0 metrics:nil views:viewsDictionary]];
    [AppUIManager horizontallyCenterElement:pageLabel inView:self.view];
    //[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[pageLabel(60)]-26-[emailField]"                                                                      options:0 metrics:nil views:viewsDictionary]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-42-[pageLabel(60)]"                                                                      options:0 metrics:nil views:viewsDictionary]];
    
    
    
    // buttons
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[cancelButton(40)]"                                                                      options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[cancelButton(40)]"                                                                      options:0 metrics:nil views:viewsDictionary]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[signInButton(40)]-10-|"                                                                      options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[signInButton(40)]"                                                                      options:0 metrics:nil views:viewsDictionary]];
    
    
    // text fields
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-14-[emailField]-14-|"                                                                      options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-14-[passwordField]-14-|"                                                                      options:0 metrics:nil views:viewsDictionary]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[emailField(40)]-4-[passwordField(emailField)]-218-|"
                                                                      options:0 metrics:nil views:viewsDictionary]]; // key board 216
}

- (void)setNavigationBar {
    // set up navigation bar
    self.navigationItem.title = @"Sign In";
    
    // right navigation button
    /*self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
     initWithBarButtonSystemItem:UIBarButtonSystemItemCompose
     target:self
     action:@selector(goToAddContentView:)];
     
     */
    
    
    // go back
    self.navigationItem.leftBarButtonItem =  [[UIBarButtonItem alloc]
                                              initWithBarButtonSystemItem:UIBarButtonSystemItemStop
                                              target:self
                                              action:@selector(goBack:)];
    
    
}



#pragma mark - TextField Delegate Protocal
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ((textField == emailField) || (textField == passwordField) ){
        //[textField resignFirstResponder];
        [self signInButtonPressed:nil];
        return NO;
    }
    return YES;
}


#pragma mark - Button Action Methods
- (void)goBack:(id)sender {
    // go back
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)signInButtonPressed:(id)sender {
    // sign in user
    [activityIndicator startAnimating];
    [[ApiManager sharedApiManager] signInUserWithUserTypeId:kAPIUserTypeWom
                                                      email:emailField.text
                                                   password:passwordField.text
                                                    success:^(void){
                                                        [activityIndicator stopAnimating];
                                                        [self actionsForSuccessfulUserSignIn];
                                                    }
                                                    failure:^(NSError * error){
                                                        // Analytics: Flurry
                                                        [Flurry logEvent:[FlurryManager getEventName:kFAUserSessionSignInFailure] withParameters:@{@"Error": error}];
                                                        [activityIndicator stopAnimating];
                                                        [ApiErrorManager displayAlertWithError:error withDelegate:self];
                                                    }];
}

- (void)signUpButtonPressed:(id)sender {
    // push wom Sign up controller
    WomSignUpViewController *womsuvc =[[WomSignUpViewController   alloc] init];
    [self.navigationController pushViewController:womsuvc animated:NO];
}

#pragma mark - Api Manager Post actions methods
- (void)actionsForSuccessfulUserSignIn{
    // Analytics: Flurry
    [Flurry logEvent:[FlurryManager getEventName:kFAUserSessionSignInSuccess]];
    // switch to content view
    [(AppDelegate *)[UIApplication sharedApplication].delegate setContentViewAsRootView];
}


@end
