//
//  EmailSignInViewController.m
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 2/15/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import "WomSignInViewController.h"
#import "WomSignInViewHelper.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "FlurryManager.h"
#import "ForgotPasswordViewController.h"
#import "Signup2ViewController.h"

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
 //   [self.navigationController setNavigationBarHidden:YES];
    
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
    [WomSignInViewHelper setView:self.view];
    
    // set navigation bar
   // [[self navigationController] setNavigationBarHidden:NO animated:YES];
   // [self setNavigationBar];
    
    // set lables
//    pageLabel = [WomSignInViewHelper getPageLabel];
//    [self.view addSubview:pageLabel];
    
    // set buttons
    signInButton = [WomSignInViewHelper getSignInButton];
    [signInButton addTarget:self action:@selector(signInButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:signInButton];
    
    nextButton = [WomSignInViewHelper getNextButton];
    [nextButton addTarget:self action:@selector(signUpButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextButton];
   //nextButton.enabled = NO;
   
    // go back
    cancelButton = [WomSignInViewHelper getCancelButton];
    [cancelButton addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelButton];
    
//    resetPasswordButton = [WomSignInViewHelper getResetPasswordButton];
//    [resetPasswordButton addTarget:self action:@selector(resetPasswordButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:resetPasswordButton];

    
    //text Fields
    emailField =[[UITextField alloc] init];
    [WomSignInViewHelper setEmailTextFiled:emailField withDelegate:self];
    [self.view addSubview:emailField];
    
    passwordField =[[UITextField alloc] init];
    [WomSignInViewHelper setPasswordTextFiled:passwordField withDelegate:self];
    [self.view addSubview:passwordField];
    
    
    //activity indicator view
    activityIndicator =[[UIActivityIndicatorView alloc] init];
    [AppUIManager addActivityIndicator:activityIndicator toView:self.view];
    
    lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 44, self.view.bounds.size.width, 1)];
    lineView.backgroundColor = [CommonUtility getColorFromHSBACVec:kAUCColorLineView];
    [self.view addSubview:lineView];
    
    titleImage = [WomSignInViewHelper getTitleImage];
    [self.view addSubview:titleImage];

    fullExperienceImage = [WomSignInViewHelper getFullExperienceImage];
    [self.view addSubview:fullExperienceImage];
    // layout
    [self layoutView];
}

- (void)layoutView{
    // all view elements
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(emailField,passwordField,signInButton, nextButton, cancelButton, titleImage, fullExperienceImage);

    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[titleImage(44)]"                                                                      options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[titleImage(46)]"                                                                      options:0 metrics:nil views:viewsDictionary]];
    [AppUIManager horizontallyCenterElement:titleImage inView:self.view];
    
    // buttons
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[cancelButton(44)]"                                                                      options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[cancelButton(44)]"                                                                      options:0 metrics:nil views:viewsDictionary]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[nextButton(45)]-15-|"                                                                      options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[nextButton(44)]"                                                                      options:0 metrics:nil views:viewsDictionary]];
    
    // text fields
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[emailField]|"                                                                      options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[passwordField]|"                                                                      options:0 metrics:nil views:viewsDictionary]];
    
 // keyboard 216
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-69-[fullExperienceImage(23)]-25-[emailField(60)]-8-[passwordField(emailField)]-28-[signInButton(26)]"
                                                                      options:0 metrics:nil views:viewsDictionary]];
    
    [AppUIManager horizontallyCenterElement:fullExperienceImage inView:self.view];
    [AppUIManager horizontallyCenterElement:signInButton inView:self.view];
}

- (void)setNavigationBar {
    // set up navigation bar
    
    // right navigation button
    /*self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
     initWithBarButtonSystemItem:UIBarButtonSystemItemCompose
     target:self
     action:@selector(goToAddContentView:)];
     
     */

   // UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:cancelButton];
  //  self.navigationItem.leftBarButtonItem = leftBarButton;
    
  //  self.navigationItem.title = @"Sign Up";
    
//    [[UINavigationBar appearance] setTranslucent:NO];
//    
//    [[UINavigationBar appearance] setShadowImage:[UIImage new]];
//    [[UINavigationBar appearance] setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
}



#pragma mark - TextField Delegate Protocal
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
//    if ((textField == emailField) || (textField == passwordField) ){
//        //[textField resignFirstResponder];
//        [self signInButtonPressed:nil];
//        return NO;
//    }
    if (textField == passwordField) {
        [textField resignFirstResponder];
       // [self signInButtonPressed:nil];
        return NO;
    } else if (textField == emailField) {
        [passwordField becomeFirstResponder];
            }
    return YES;
}


#pragma mark - Button Action Methods
- (void)goBack:(id)sender {
    // go back
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)signInButtonPressed:(id)sender {
    // push wom Sign up controller
        LoginViewController *womsuvc =[[LoginViewController alloc] init];
        [self.navigationController pushViewController:womsuvc animated:NO];
    
    // sign in user
//    [activityIndicator startAnimating];
//    [[ApiManager sharedApiManager] signInUserWithUserTypeId:kAPIUserTypeWom
//                                                      email:emailField.text
//                                                   password:passwordField.text
//                                                    success:^(void){
//                                                        [activityIndicator stopAnimating];
//                                                        [self actionsForSuccessfulUserSignIn];
//                                                    }
//                                                    failure:^(NSError * error){
//                                                        // Analytics: Flurry
//                                                        [Flurry logEvent:[FlurryManager getEventName:kFAUserSessionSignInFailure] withParameters:@{@"Error": error}];
//                                                        [activityIndicator stopAnimating];
//                                                        [ApiErrorManager displayAlertWithError:error withDelegate:self];
//                                                    }];
}
- (void)signUpButtonPressed:(id)sender {
    // sign up user
    [activityIndicator startAnimating];
    Signup2ViewController *su2vc =[[Signup2ViewController alloc] init];
    [self.navigationController pushViewController:su2vc animated:NO];
    
    
//    [[ApiManager sharedApiManager] signUpUserWithUserTypeId:kAPIUserTypeWom
//                                                      email:emailField.text
//                                                   password:passwordField.text
//                                       passwordConfirmation:passwordField.text
//                                                    success:^(void){
//                                                        [activityIndicator stopAnimating];
//                                                        [self actionsForSuccessfulUserSignUp];
//                                                    }failure:^(NSError * error){
//                                                        // Analytics: Flurry
//                                                        [Flurry logEvent:[FlurryManager getEventName:kFAUserSessionSignUpFailure] withParameters:@{@"Error": error}];
//                                                        [activityIndicator stopAnimating];
//                                                        [ApiErrorManager displayAlertWithError:error withDelegate:self];
//                                                    }];
}

- (void)resetPasswordButtonPressed:(id)sender {
    ForgotPasswordViewController *passvc = [[ForgotPasswordViewController alloc] init];
    [self.navigationController pushViewController:passvc animated:NO];
}

#pragma mark - Api Manager Post actions methods
- (void)actionsForSuccessfulUserSignIn{
    // Analytics: Flurry
    [Flurry logEvent:[FlurryManager getEventName:kFAUserSessionSignInSuccess]];
    // switch to content view
    [(AppDelegate *)[UIApplication sharedApplication].delegate setContentViewAsRootView];
}

- (void)actionsForSuccessfulUserSignUp{
    // Analytics: Flurry
    [Flurry logEvent:[FlurryManager getEventName:kFAUserSessionSignUpSuccess]];
    // switch to content view
    [(AppDelegate *)[UIApplication sharedApplication].delegate setContentViewAsRootView];
}


@end
