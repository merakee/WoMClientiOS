//
//  ForgotPasswordViewController.m
//  WordOfMouthEngine
//
//  Created by Kevin Moy on 10/27/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import "ForgotPasswordViewController.h"
#import "ForgotPasswordViewHelper.h"
#import "AppDelegate.h"
#import "FlurryManager.h"

@interface ForgotPasswordViewController ()

@end

@implementation ForgotPasswordViewController

- (void)loadView {
    [super loadView];
    // view customization code
    [self setView];
}

- (void)viewDidLoad {
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
    //   [self.navigationController setNavigationBarHidden:YES];
    
    // display key board
    //[emailField becomeFirstResponder];
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
    [ForgotPasswordViewHelper setView:self.view];
    
    // set navigation bar
    //[self setNavigationBar];
    
    // set labels
    pageLabel = [ForgotPasswordViewHelper getPageLabel];
    [self.view addSubview:pageLabel];
    
    // set buttons
    resetPasswordButton = [ForgotPasswordViewHelper getResetPasswordButton];
    [resetPasswordButton addTarget:self action:@selector(resetPasswordButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:resetPasswordButton];
    
    cancelButton = [ForgotPasswordViewHelper getCancelButton];
    [cancelButton addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelButton];
    
    
    //text Fileds
    emailField =[[UITextField alloc] init];
    [ForgotPasswordViewHelper setEmailTextFiled:emailField withDelegate:self];
    [self.view addSubview:emailField];
    
    
    //activity indicator view
    activityIndicator =[[UIActivityIndicatorView alloc] init];
    [AppUIManager addActivityIndicator:activityIndicator toView:self.view];
    
    // layout
    [self layoutView];

}

- (void)layoutView{
    // all view elements
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(pageLabel,emailField,resetPasswordButton,cancelButton);
    
    // labels
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[pageLabel(200)]"                                                                      options:0 metrics:nil views:viewsDictionary]];
    
    [AppUIManager horizontallyCenterElement:pageLabel inView:self.view];
    //[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[pageLabel(60)]-26-[emailField]"                                                                      options:0 metrics:nil views:viewsDictionary]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-42-[pageLabel(60)]"                                                                      options:0 metrics:nil views:viewsDictionary]];
    
    
    
    // buttons
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[cancelButton(40)]"                                                                      options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[cancelButton(40)]"                                                                      options:0 metrics:nil views:viewsDictionary]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[resetPasswordButton(40)]-10-|"                                                                      options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[resetPasswordButton(40)]"                                                                      options:0 metrics:nil views:viewsDictionary]];
    
    
    // text fields
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-14-[emailField]-14-|"                                                                      options:0 metrics:nil views:viewsDictionary]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-100-[emailField(40)]"
                                                                      options:0 metrics:nil views:viewsDictionary]]; // key board 216
}

#pragma mark - Button Action Methods
- (void)goBack:(id)sender {
    // go back
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)resetPasswordButtonPressed:(id)sender {
    // Reset the password
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                    message:@"An email to reset your password has been sent."
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];

    [self.navigationController popViewControllerAnimated:NO];
}

@end
