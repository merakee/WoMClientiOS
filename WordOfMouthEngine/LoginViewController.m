//
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 2/15/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginViewHelper.h"
#import "AppDelegate.h"
#import "FlurryManager.h"
#import "TermsViewController.h"

@implementation LoginViewController

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

- (BOOL)prefersStatusBarHidden {
    return YES;
}
#pragma mark -  Local Methods Implememtation
- (void)setView {
    // set view
    [LoginViewHelper setView:self.view];
    
    // set navigation bar
   // [self setNavigationBar];
    // set lables
    
    //text Fileds
    emailField =[[UITextField alloc] init];
    [LoginViewHelper setEmailTextFiled:emailField withDelegate:self];
    [self.view addSubview:emailField];
    
    passwordField =[[UITextField alloc] init];
    [LoginViewHelper setPasswordTextFiled:passwordField withDelegate:self];
    [self.view addSubview:passwordField];
    
    
//    passwordConfirmationField =[[UITextField alloc] init];
//    [WomSignUpViewHelper setPasswordConfirmationTextFiled:passwordConfirmationField withDelegate:self];
//    [self.view addSubview:passwordConfirmationField];
    
    // set buttons
    signUpButton = [LoginViewHelper getSignUpButton];
    [signUpButton addTarget:self action:@selector(signUpButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:signUpButton];
    
    cancelButton = [LoginViewHelper getCancelButton];
    [cancelButton addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelButton];
    
    forgotPasswordButton = [LoginViewHelper getForgotPasswordButton];
    [forgotPasswordButton addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgotPasswordButton];
    
    //activity indicator view
    activityIndicator =[[UIActivityIndicatorView alloc] init];
    [AppUIManager addActivityIndicator:activityIndicator toView:self.view];
    
    lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 44, self.view.bounds.size.width, 1)];
    lineView.backgroundColor = [CommonUtility getColorFromHSBACVec:kAUCColorLineView];
    [self.view addSubview:lineView];
    
    titleImage = [LoginViewHelper getTitleImage];
    [self.view addSubview:titleImage];
    
    // layout
    [self layoutView];
}

- (void)layoutView{
    // all view elements
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(emailField,passwordField,signUpButton,cancelButton, forgotPasswordButton, titleImage);
    
    // buttons
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[cancelButton(44)]"                                                                      options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[cancelButton(44)]"                                                                      options:0 metrics:nil views:viewsDictionary]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[signUpButton(27)]-15-|"                                                                      options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[signUpButton(44)]"                                                                      options:0 metrics:nil views:viewsDictionary]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[titleImage(44)]"                                                                      options:0 metrics:nil views:viewsDictionary]];
     [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[titleImage(37)]"                                                                      options:0 metrics:nil views:viewsDictionary]];
    [AppUIManager horizontallyCenterElement:titleImage inView:self.view];
    
    // text fields
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[emailField]|"                                                                      options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[passwordField]|"                                                                      options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-100-[emailField(60)]-8-[passwordField(60)]-26-[forgotPasswordButton]"                                                                      options:0 metrics:nil views:viewsDictionary]];
    [AppUIManager horizontallyCenterElement:forgotPasswordButton inView:self.view];
    
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-14-[passwordConfirmationField]-14-|"                                                                      options:0 metrics:nil views:viewsDictionary]];
    
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[emailField(40)]-4-[passwordField(emailField)]-4-[passwordConfirmationField(emailField)]-218-|"
//                                                                      options:0 metrics:nil views:viewsDictionary]]; // key board 216
    
    
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
    self.navigationItem.backBarButtonItem =  [[UIBarButtonItem alloc]
                                              initWithBarButtonSystemItem:UIBarButtonSystemItemStop
                                              target:nil
                                              action:nil];
    
    
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
    // go back to previous view
    [self.navigationController popViewControllerAnimated:NO];
  
//        [Flurry logEvent:[FlurryManager getEventName:kFAUserSessionTerms]];
//        //Go to terms view controller
//        TermsViewController *tvc = [[TermsViewController alloc] init];
//        [self.navigationController pushViewController:tvc animated:NO];
    
}
- (void)signUpButtonPressed:(id)sender {
    // sign up user
    [activityIndicator startAnimating];
        [[ApiManager sharedApiManager] signUpUserWithUserTypeId:kAPIUserTypeWom
                                                          email:emailField.text
                                                       password:passwordField.text
                                           passwordConfirmation:passwordField.text
                                                       nickname:@" "
                                                         avatar:nil
                                                            bio:@" "
                                                       hometown:@" "
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
