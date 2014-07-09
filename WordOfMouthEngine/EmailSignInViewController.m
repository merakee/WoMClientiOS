//
//  EmailSignInViewController.m
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 2/15/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import "EmailSignInViewController.h"
#import "EmailSignInViewHelper.h"
#import "AppDelegate.h"


@implementation EmailSignInViewController

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
    [self.navigationController setNavigationBarHidden:NO];
    
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
    [EmailSignInViewHelper setView:self.view];
    
    // set navigation bar
    [self setNavigationBar];
    
    
    // set buttons
    SignInButton = [EmailSignInViewHelper getSignInButton];
    [SignInButton addTarget:self action:@selector(SignInButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:SignInButton];
    
    // set buttons
    signUpButton = [EmailSignInViewHelper getSignUpButton];
    [signUpButton addTarget:self action:@selector(signUpButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:signUpButton];
    
    //text Fileds
    emailField =[[UITextField alloc] init];
    [EmailSignInViewHelper setEmailTextFiled:emailField withDelegate:self];
    [self.view addSubview:emailField];
    
    passwordField =[[UITextField alloc] init];
    [EmailSignInViewHelper setPasswordTextFiled:passwordField withDelegate:self];
    [self.view addSubview:passwordField];
    
    
    // layout
    [self layoutView];
}

- (void)layoutView{
    // all view elements
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(emailField,passwordField,SignInButton,signUpButton);
    
    // buttons
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-100-[emailField(36)]-12-[passwordField(emailField)]-24-[SignInButton(emailField)]-80-[signUpButton(emailField)]"                                                                      options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[emailField]-|"                                                                      options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[passwordField]-|"                                                                      options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[SignInButton]-|"                                                                      options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[signUpButton]-|"                                                                      options:0 metrics:nil views:viewsDictionary]];
    
    
}

- (void)setNavigationBar {
    // set up navigation bar
    self.navigationItem.title = @"WoM Sign In";
    
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


#pragma mark - TextField Delegate Protocal
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ((textField == emailField) || (textField == passwordField) ){
        [textField resignFirstResponder];
        return NO;
    }
    return YES;
}


#pragma mark - Button Action Methods
- (void)SignInButtonPressed:(id)sender {
    // set up session manager
    [ApiManager sharedApiManager].delegate= self;
    [[ApiManager sharedApiManager] signInUserWithUserTypeId:kAPIUserTypeWom email:emailField.text andPassword:passwordField.text];
}

- (void)signUpButtonPressed:(id)sender {
    [CommonUtility displayAlertWithTitle:@"Not Active" message:@"Please sign in with guest account" delegate:self];
}

#pragma mark - Session Manager delegate protocal method
- (void)apiManagerUserSignUpFailedWithError:(NSError *)error{
    [CommonUtility displayAlertWithTitle:error.localizedDescription message:error.localizedRecoverySuggestion delegate:self];
}
- (void)apiManagerDidSignUpUser:(id)responseObject{
    // switch to content view
    [(AppDelegate *)[UIApplication sharedApplication].delegate setCoreFunctionViewAsRootView];
    
}


@end
