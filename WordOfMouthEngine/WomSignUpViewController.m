//
//  WomSignUpViewController.m
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 2/15/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import "WomSignUpViewController.h"
#import "WomSignUpViewHelper.h"
#import "AppDelegate.h"
#import "FlurryManager.h"

@implementation WomSignUpViewController

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
    [WomSignUpViewHelper setView:self.view];
    
    // set navigation bar
    [self setNavigationBar];
    
    // set buttons
    signUpButton = [WomSignUpViewHelper getSignUpButton];
    [signUpButton addTarget:self action:@selector(signUpButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:signUpButton];
    
    //text Fileds
    emailField =[[UITextField alloc] init];
    [WomSignUpViewHelper setEmailTextFiled:emailField withDelegate:self];
    [self.view addSubview:emailField];
    
    passwordField =[[UITextField alloc] init];
    [WomSignUpViewHelper setPasswordTextFiled:passwordField withDelegate:self];
    [self.view addSubview:passwordField];
    
    
    passwordConfirmationField =[[UITextField alloc] init];
    [WomSignUpViewHelper setPasswordConfirmationTextFiled:passwordConfirmationField withDelegate:self];
    [self.view addSubview:passwordConfirmationField];
    
    //activity indicator view
    activityIndicator =[[UIActivityIndicatorView alloc] init];
    [AppUIManager addActivityIndicator:activityIndicator toView:self.view];
    
    // layout
    [self layoutView];
}

- (void)layoutView{
    // all view elements
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(emailField,passwordField,passwordConfirmationField,signUpButton);
    
    // buttons
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-76-[emailField(36)]-12-[passwordField(emailField)]-12-[passwordConfirmationField(emailField)]-12-[signUpButton(emailField)]"                                                                      options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[emailField]-|"                                                                      options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[passwordField]-|"                                                                      options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[passwordConfirmationField]-|"                                                                      options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[signUpButton]-|"                                                                      options:0 metrics:nil views:viewsDictionary]];
    
    
}

- (void)setNavigationBar {
    // set up navigation bar
    self.navigationItem.title = @"Sign Up";
    
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
    if ((textField == emailField) || (textField == passwordField) || (textField == passwordConfirmationField)){
        [textField resignFirstResponder];
        return NO;
    }
    return YES;
}


#pragma mark - Button Action Methods
- (void)goBack:(id)sender {
    // go back
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)signUpButtonPressed:(id)sender {
    // sign up user
    [activityIndicator startAnimating];
    [[ApiManager sharedApiManager] signUpUserWithUserTypeId:kAPIUserTypeWom
                                                      email:emailField.text
                                                   password:passwordField.text
                                       passwordConfirmation:passwordConfirmationField.text
                                                    success:^(void){
                                                        [activityIndicator stopAnimating];
                                                        [self actionsForSuccessfulUserSignUp];
                                                    }failure:^(NSError * error){
                                                        // Analytics: Flurry
                                                        [Flurry logEvent:[FlurryManager getEventName:kFAUserSessionSignUpFailure] withParameters:@{@"Error": error}];
                                                        [activityIndicator stopAnimating];
                                                        [ApiErrorManager displayAlertWithError:error withDelegate:self];
                                                    }];
    
}

#pragma mark - Api Manager Post actions methods
- (void)actionsForSuccessfulUserSignUp{
    // Analytics: Flurry
    [Flurry logEvent:[FlurryManager getEventName:kFAUserSessionSignUpSuccess]];
    // switch to content view
    [(AppDelegate *)[UIApplication sharedApplication].delegate setContentViewAsRootView];
}


@end
