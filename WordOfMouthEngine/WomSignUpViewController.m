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
    [WomSignUpViewHelper setView:self.view];
    
    // set navigation bar
    //[self setNavigationBar];
    // set lables
    pageLabel = [WomSignUpViewHelper getPageLabel];
    [self.view addSubview:pageLabel];
    
    
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
    
    // set buttons
    signUpButton = [WomSignUpViewHelper getSignUpButton];
    [signUpButton addTarget:self action:@selector(signUpButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:signUpButton];
    
    cancelButton = [WomSignUpViewHelper getCancelButton];
    [cancelButton addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelButton];
    
    //activity indicator view
    activityIndicator =[[UIActivityIndicatorView alloc] init];
    [AppUIManager addActivityIndicator:activityIndicator toView:self.view];
    
    // layout
    [self layoutView];
}

- (void)layoutView{
    // all view elements
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(emailField,passwordField,passwordConfirmationField,signUpButton,cancelButton,pageLabel);
    
    // labels
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[pageLabel(120)]"                                                                      options:0 metrics:nil views:viewsDictionary]];
    [AppUIManager horizontallyCenterElement:pageLabel inView:self.view];
    //[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[pageLabel(60)]-26-[emailField]"                                                                      options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-42-[pageLabel(60)]"                                                                      options:0 metrics:nil views:viewsDictionary]];
    
    
    // buttons
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[cancelButton(40)]"                                                                      options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[cancelButton(40)]"                                                                      options:0 metrics:nil views:viewsDictionary]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[signUpButton(40)]-10-|"                                                                      options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[signUpButton(40)]"                                                                      options:0 metrics:nil views:viewsDictionary]];
    
    
    // text fields
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-14-[emailField]-14-|"                                                                      options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-14-[passwordField]-14-|"                                                                      options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-14-[passwordConfirmationField]-14-|"                                                                      options:0 metrics:nil views:viewsDictionary]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[emailField(40)]-4-[passwordField(emailField)]-4-[passwordConfirmationField(emailField)]-218-|"
                                                                      options:0 metrics:nil views:viewsDictionary]]; // key board 216
    
    
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
        //[textField resignFirstResponder];
        [self signUpButtonPressed:nil];
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
