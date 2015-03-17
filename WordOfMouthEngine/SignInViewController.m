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
#import "AppDelegate.h"
#import "FlurryManager.h"
#import "ForgotPasswordViewController.h"
#import "TutorialViewController.h"
#import "TermsViewController.h"
#import "AppAnimationManager.h"
#import "SettingsViewController.h"
#import "ContentViewController.h"

@interface SignInViewController ()  <UIPageViewControllerDataSource>
@end

@implementation SignInViewController
//@synthesize tutorialImages;
@synthesize counter;
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
    [self.navigationController.navigationBar setTranslucent:NO],
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
-(BOOL)prefersStatusBarHidden{
    return YES;
}

#pragma mark -  Local Methods Implememtation
- (void)setView {
    // set view
    [SignInViewHelper setView:self.view];
    
    // set navigation bar
    [self setNavigationBar];
    
    // page controller
    [self setPageView];
    [self setupPageControl];
    counter = 0;
    //    // set buttons
    //    googleButton = [SignInViewHelper getGoogleButton];
    //    [googleButton addTarget:self action:@selector(googleButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    //    [self.view addSubview:googleButton];
    //
    //    // set buttons
    //    facebookButton = [SignInViewHelper getFacebookButton];
    //    [facebookButton addTarget:self action:@selector(facebookButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    //    [self.view addSubview:facebookButton];

    //    // set buttons
    //    twitterButton = [SignInViewHelper getTwitterButton];
    //    [twitterButton addTarget:self action:@selector(twitterButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    //    [self.view addSubview:twitterButton];
    
    // set buttons
    signInButton = [SignInViewHelper getSignInButton];
    [signInButton addTarget:self action:@selector(signInLoginButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
   // [self.view addSubview:signInButton];
    
    signInAsGuestButton = [SignInViewHelper getSignInAsGuestButton];
    [signInAsGuestButton addTarget:self action:@selector(signInAsGuestButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
  //  [self.view addSubview:signInAsGuestButton];
    
//    termsButton = [SignInViewHelper getTermsButton];
//    [termsButton addTarget:self action:@selector(termsButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:termsButton];
    
    //activity indicator view
    activityIndicator =[[UIActivityIndicatorView alloc] init];
    [AppUIManager addActivityIndicator:activityIndicator toView:self.view];
    
  //  [self.view bringSubviewToFront:pageControl];
    // layout
    [self layoutView];
    
}

- (void)layoutView{
    // all view elements
    //NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(appLogoView,buttonsView,signInButton,signUpButton,signInAsGuestButton,activityIndicator);
    
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(activityIndicator,pageViewControllerView);

    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[pageViewControllerView]|"
                                                                      options:0 metrics:nil views:viewsDictionary]];
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[pageViewControllerView(300)]"
//                                                                      options:0 metrics:nil views:viewsDictionary]];

    // buttons
    
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[signInAsGuestButton]"
//                                                                     options:0 metrics:nil views:viewsDictionary]];
//    [AppUIManager horizontallyCenterElement:signInAsGuestButton inView:self.view];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[pageViewControllerView]|"
                                                                      options:0 metrics:nil views:viewsDictionary]];
   
    
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[termsButton(34)]-5-|"
//                                                                      options:0 metrics:nil views:viewsDictionary]];
    
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[signInButton]"
//                                                                      options:0 metrics:nil views:viewsDictionary]];
//     [AppUIManager horizontallyCenterElement:signInButton inView:self.view];
    
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[signInButton(30)]-10-|"
//                                                                      options:0 metrics:nil views:viewsDictionary]];
    
        // login label
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-70-[loginLabel(130)]"
//                                                                      options:0 metrics:nil views:viewsDictionary]];
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[loginLabel(30)]-10-|"
//                                                                      options:0 metrics:nil views:viewsDictionary]];
    
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[termsButton(100)]" options:0 metrics:nil views:viewsDictionary]];
//    [AppUIManager horizontallyCenterElement:termsButton inView:self.view];
    
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[signInButton]-40-[termsButton(40)]" options:0 metrics:nil views:viewsDictionary]];
    // page controller
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[pageController]-10-|"
//                                                                      options:0 metrics:nil views:viewsDictionary]];
}

- (void)setNavigationBar {
    // app settings
    [AppUIManager setNavbar:self.navigationController.navigationBar];
    
    // set up navigation bar
   // self.navigationItem.title = @"Sign In";
    
    
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
- (void)signInLoginButtonPressed:(id)sender {
    // Analytics: Flurry
    [Flurry logEvent:[FlurryManager getEventName:kFAUserSessionSignIn]];
    // push wom Sign in controller
    WomSignInViewController *womsivc =[[WomSignInViewController alloc] init];
    [self.navigationController pushViewController:womsivc animated:NO];
}

//- (void)signUpButtonPressed:(id)sender {
//    // Analytics: Flurry
//    [Flurry logEvent:[FlurryManager getEventName:kFAUserSessionSignUp]];
//    // push wom Sign up controller
//    WomSignUpViewController *womsuvc =[[WomSignUpViewController   alloc] init];
//    [self.navigationController pushViewController:womsuvc animated:NO];
//}

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

- (void)termsButtonPressed:(id)sender {
    [Flurry logEvent:[FlurryManager getEventName:kFAUserSessionTerms]];
    //Go to terms view controller
    TermsViewController *tvc = [[TermsViewController alloc] init];
    [self.navigationController pushViewController:tvc animated:NO];
}
#pragma mark - Tutorial Page View

- (void)setPageView
{
    tutorialImages = @[@"slide-1.png",
                       @"slide-2.png",
                       @"slide-3.png",
                       @"slide-4.png"];

//    UIPageViewController *pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    pageViewController.dataSource = self;
    pageViewController.delegate = self;
    if([tutorialImages count])
    {
        NSArray *startingViewControllers = @[[self itemControllerForIndex: 0]];
        [pageViewController setViewControllers: startingViewControllers
                                 direction: UIPageViewControllerNavigationDirectionForward
                                  animated: NO
                                completion: nil];
    }
//    TutorialViewController *initialViewController = [self viewControllerAtIndex:0];
//    
//    NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
//    
//    [pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
//    pageViewController.view.frame = self.view.bounds;
    pageViewController.view.clipsToBounds = YES;
     pageViewController.view.contentMode = UIViewContentModeScaleAspectFit;
  //  self.view.frame = self.view.bounds;
//   [pageViewController.view setFrame:CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, screenW, screenH*2/3)];

    [self addChildViewController:pageViewController];
    pageViewControllerView = pageViewController.view;
    [pageViewControllerView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:pageViewControllerView];
    [pageViewController didMoveToParentViewController:self];
}
//- (TutorialViewController *)viewControllerAtIndex:(NSUInteger)index {
//    
////    TutorialViewController *tvc = [[TutorialViewController alloc] initWithNibName:@"TutorialViewController" bundle:nil];
//    TutorialViewController *tvc = [[TutorialViewController alloc] init];
//    tvc.index = index;
//    
//    return tvc;
//    
//}

- (void) setupPageControl
{
    pageControl = [UIPageControl appearance];
    [[UIPageControl appearance] setPageIndicatorTintColor: [UIColor lightGrayColor]];
    [[UIPageControl appearance] setCurrentPageIndicatorTintColor: [UIColor darkGrayColor]];
   //  [[UIPageControl appearance] setFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
}

- (UIViewController *)pageViewController: (UIPageViewController *) pageViewController viewControllerBeforeViewController:(UIViewController *) viewController
{
    TutorialViewController *itemController = (TutorialViewController *) viewController;
    
    if (itemController.index > 0)
    {
        return [self itemControllerForIndex: itemController.index-1];
    }
    
   // return [self itemControllerForIndex:3];
    return nil;
}


- (UIViewController *)pageViewController: (UIPageViewController *) pageViewController viewControllerAfterViewController:(UIViewController *) viewController
{
    TutorialViewController *itemController = (TutorialViewController *) viewController;
    NSLog(@"Item index: %lu",(long)itemController.index);
    NSLog(@"Counter: %d", counter);
    if (itemController.index == 0 && counter == 0)
    {
        counter = 1;
        return [self itemControllerForIndex: itemController.index+1];
    }
    if (itemController.index == 0 && counter == 2){
        SettingsViewController *svc =[[SettingsViewController alloc] init];
        [self.navigationController pushViewController:svc animated:NO];
    }
    if (itemController.index == 0 && counter == 1)
    {
        NSLog(@"guest");
        // Analytics: Flurry
        [Flurry logEvent:[FlurryManager getEventName:kFAUserSessionGuestSignIn]];
        
        // sign in anonymous user
        [activityIndicator startAnimating];
        [[ApiManager sharedApiManager] signInUserWithUserTypeId:kAPIUserTypeAnonymous
                                                          email:nil
                                                       password:nil
                                                        success:^(void){
                                                            // return [self itemControllerForIndex:itemController.index+1];
                                                            [activityIndicator stopAnimating];
                                                            [self actionsForSuccessfulAnonymusUserSignIn];
                                                        }failure:^(NSError * error){
                                                            // Analytics: Flurry
                                                            [Flurry logEvent:[FlurryManager getEventName:kFAUserSessionGuestSignInFailure] withParameters:@{@"Error": error}];
                                                            [activityIndicator stopAnimating];
                                                            [ApiErrorManager displayAlertWithError:error withDelegate:self];
                                                        }];
        
       // return [self itemControllerForIndex: itemController.index+1];
    }
    
    if (itemController.index == 0 && counter == 1)
    {
    //    NSLog(@"settings");
        counter = 2;
        return [self itemControllerForIndex: itemController.index+1];
    }
   
    if (itemController.index+1 < [tutorialImages count])
    {
    //    NSLog(@"%lu",(long)tutorialImages.count);
        return [self itemControllerForIndex: itemController.index+1];
       
    }
    // Loop pageviewcontroller
    return [self itemControllerForIndex:0];
    
   // return nil;
}

- (TutorialViewController *) itemControllerForIndex: (NSUInteger) itemIndex
{
    if (itemIndex < [tutorialImages count])
    {
        TutorialViewController *tutorialViewController = [[TutorialViewController alloc] init];
        tutorialViewController.index = itemIndex;
        tutorialViewController.imageName = tutorialImages[itemIndex];
        return tutorialViewController;
    }
    return nil;
}

- (TutorialViewController *)viewControllerAtIndex:(NSUInteger)index {
    
    TutorialViewController *childViewController = [[TutorialViewController alloc] initWithNibName:@"TutorialPageViewController" bundle:nil];
    childViewController.index = index;
    return childViewController;
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    // The number of items reflected in the page indicator.
    return [tutorialImages count];
}


- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    // The selected item reflected in the page indicator.
//    if([pageViewController.viewControllers count] == 0) {
//        return 0;
//    }
//    else {
//        // grab pageindex from pageviewcontroller.viewcontrollers.
//    }
     return 0;
}

#pragma mark - Api Manager Post actions methods
- (void)actionsForSuccessfulAnonymusUserSignIn{
    // Analytics: Flurry
    [Flurry logEvent:[FlurryManager getEventName:kFAUserSessionGuestSignInSuccess]];
    // switch to content view
    [(AppDelegate *)[UIApplication sharedApplication].delegate setContentViewAsRootView];
    //ContentViewController *cvc = [[ContentViewController alloc] init];
    
}

@end
