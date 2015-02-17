//
//  Signup2ViewController.m
//  WordOfMouthEngine
//
//  Created by Kevin Moy on 2/10/15.
//  Copyright (c) 2015 Bijit Halder. All rights reserved.
//

#import "Signup2ViewController.h"
#import "AppUIManager.h"
#import "WomSignInViewHelper.h"
#import "FlurryManager.h"
#import "ApiManager.h"


@implementation Signup2ViewController

- (id)init
{
    if (self = [super init]) {
        // set tab bar
        // self.tabBarItem = [[UITabBarItem alloc]
        //                   initWithTitle:@"Post"
        //                  image:[UIImage imageNamed:kAUCCoreFunctionTabbarImageCompose]
        //                 tag:kCFVTabbarIndexCompose];
        photoManager = [[ImageProcessingManager alloc] init];
        photoManager.delegate =self;
        photoManager.viewController = self;
        photoManager.allowEditting = YES;
    }
    return self;
}

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
    [nicknameField becomeFirstResponder];
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

- (void)setView {
    // set view
    [WomSignInViewHelper setView:self.view];
    
    nicknameField =[[UITextField alloc] init];
    [WomSignInViewHelper setNicknameTextFiled:nicknameField withDelegate:self];
    [self.view addSubview:nicknameField];
    
    // set buttons
    doneButton = [WomSignInViewHelper getDoneButton];
    [doneButton addTarget:self action:@selector(signUpButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:doneButton];
    
    // go back
    cancelButton = [WomSignInViewHelper getCancelButton];
    [cancelButton addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelButton];
    
    lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 44, self.view.bounds.size.width, 1)];
    lineView.backgroundColor = [CommonUtility getColorFromHSBACVec:kAUCColorLineView];
    [self.view addSubview:lineView];
    
    // title image
    titleImage = [WomSignInViewHelper getTitleImage];
    [self.view addSubview:titleImage];
    
    // profile picture
    profileImageView = [WomSignInViewHelper getProfileImageView];
    [self.view addSubview:profileImageView];
    
    [self setupHorizontalScrollView];
    [self layoutView];
}

- (void)layoutView{
    // all view elements
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(cancelButton, nicknameField, titleImage, doneButton, imageScrollview, cameraButton, profileImageView);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[titleImage(44)]"                                                                      options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[titleImage(46)]"                                                                      options:0 metrics:nil views:viewsDictionary]];
    [AppUIManager horizontallyCenterElement:titleImage inView:self.view];
    
    // buttons
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[cancelButton(44)]"                                                                      options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[cancelButton(44)]"                                                                      options:0 metrics:nil views:viewsDictionary]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[doneButton(45)]-15-|"                                                                      options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[doneButton(44)]"                                                                      options:0 metrics:nil views:viewsDictionary]];

    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[nicknameField]|"
        options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-64-[imageScrollview(110)]-25-[nicknameField(80)]-25-[profileImageView(50)]"
                                                                      options:0 metrics:nil views:viewsDictionary]];
                               
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[imageScrollview]|"
                                                                      options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[profileImageView]|"
                                                                      options:0 metrics:nil views:viewsDictionary]];
    [imageScrollview addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[cameraButton(100)]|"
                                                                            options:0 metrics:nil views:viewsDictionary]];
    [imageScrollview addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-50-[cameraButton]"
                                                                            options:0 metrics:nil views:viewsDictionary]];
    //[AppUIManager horizontallyCenterElement:cameraButton inView:imageScrollview];
}

- (void)setupHorizontalScrollView{
    imageScrollview = [[UIScrollView alloc] init];
    [imageScrollview setTranslatesAutoresizingMaskIntoConstraints:NO];
    imageScrollview.delegate = self;
    [imageScrollview setBackgroundColor:[UIColor greenColor]];
    [imageScrollview setCanCancelContentTouches:YES];
    //imageScrollview.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    [imageScrollview setContentSize:CGSizeMake(50, 200)];
    //imageScrollview.clipsToBounds = NO;
    imageScrollview.scrollEnabled = YES;
    imageScrollview.pagingEnabled = YES;
    imageScrollview.userInteractionEnabled = YES;
    imageScrollview.exclusiveTouch = YES;
    imageScrollview.delaysContentTouches = YES;
    [self.view addSubview:imageScrollview];
    
    cameraButton = [WomSignInViewHelper getCameraButton];
    [cameraButton addTarget:self action:@selector(showPhotoOptions:) forControlEvents:UIControlEventTouchUpInside];
    [imageScrollview addSubview:cameraButton];
//    NSUInteger nimages = 0;
//    for (; ; nimages++){
//    //   NSString *imageName = [NSString stringWithFormat:@"image%d.png", (nimages+1)];
//         NSString *imageName = [NSString stringWithFormat:@"image%lu.jpg", (nimages + 1)];
//        UIImage *image = [UIImage imageNamed:imageName];
//        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
//        [imageScrollview addSubview:imageView];
//    }
    
    
}

#pragma mark - Button Action Methods
- (void)goBack:(id)sender {
    // go back
    [self.navigationController popViewControllerAnimated:NO];
    //  [self.navigationController popViewControllerAnimated:TRUE];
}

- (void)signUpButtonPressed:(id)sender {
    // sign up user
   // [activityIndicator startAnimating];
//    [[ApiManager sharedApiManager]
//                                                      email:emailField.text
//                                                   password:passwordField.text
//                                       passwordConfirmation:passwordConfirmationField.text
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
- (void)showPhotoOptions:(id)sender{
    NSLog(@"pressed");
    
    // Analytics: Flurry
    [Flurry logEvent:[FlurryManager getEventName:kFAComposePhoto]];
    
    // if there is no camera
    if(![photoManager isCameraAvailable]){
        //[self albumButtonPressed:nil];
        //return;
    }
    
    // action sheet
    [CommonUtility displayActionSheetWithTitle:nil
                                  cancelButton:@"Cancel"
                             destructiveButton:nil
                                 customButtons:@[@"Camera",@"Photos"]
                                      delegate:self
                                           tag:kAUCProfilePhotoOptionsActionSheetTag];
    
    //[photoManager displayPhotoLibrary];
}
#pragma mark - Action sheet delegate method
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(actionSheet.tag==kAUCProfilePhotoOptionsActionSheetTag){
        [self processPhotoOptionsActionSheet:(UIActionSheet*)actionSheet withIndex:buttonIndex];
        return;
    }
    
    // check if cancelButton Pressed
    if(actionSheet.cancelButtonIndex==buttonIndex) {
        // NSPLogBLog(@"Action for C Button");
        [self clearViewAfterSuccessfulPostOrCancel];
    }
    else if(actionSheet.destructiveButtonIndex==buttonIndex) {
        //[busyIndicator startAnimating];
        //[self performSelector:@selector(setDefaultAutoPlan) withObject:nil afterDelay:kCRDPerformSelectorDelay];
        [self goBack:nil];
    }
    else{
        // get selected grade
    }
    
}
- (void)clearViewAfterSuccessfulPostOrCancel{
}
- (void)willPresentActionSheet:(UIActionSheet *)actionSheet{
    [actionSheet.subviews enumerateObjectsUsingBlock:^(UIView *subview, NSUInteger idx, BOOL *stop) {
        if ([subview isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)subview;
            button.titleLabel.textColor = [AppUIManager  getColorOfType:kAUCColorTypeTextPrimary];
            NSString *buttonText = button.titleLabel.text;
            if ([buttonText isEqualToString:NSLocalizedString(@"Cancel", nil)]) {
                [button setTitleColor:[AppUIManager  getColorOfType:kAUCColorTypeTextQuinary] forState:UIControlStateNormal];
            }
        }
    }];
}
- (void)processPhotoOptionsActionSheet:(UIActionSheet*)actionSheet withIndex:(NSInteger)buttonIndex{
    //Button actions using delegate
    int customButtonStartIndex = (actionSheet.cancelButtonIndex>=0) ? 1 : 0;
    customButtonStartIndex += (actionSheet.destructiveButtonIndex>=0) ? 1 : 0;
    //int totalCustomButtons = actionSheet.numberOfButtons - customButtonStartIndex;
    
    if(customButtonStartIndex==buttonIndex){
        // Camera Button
        [self cameraButtonPressed:nil];
    }
    if(customButtonStartIndex+1==buttonIndex){
        // Camera Button
        [self albumButtonPressed:nil];
    }
}

- (void)cameraButtonPressed:(id)sender {
    // Analytics: Flurry
    [Flurry logEvent:[FlurryManager getEventName:kFAComposeCamera]];
    //photoOptionsView.hidden = YES;

    // start image picker for camera
    //[AppUIManager dispatchBlock:^{[photoManager displayCamera]; } afterDelay:0.5];
    //[photoManager performSelector:@selector(displayCamera) withObject:nil afterDelay:0.3];
    [photoManager displayCamera];
}

- (void)albumButtonPressed:(id)sender {
    // Analytics: Flurry
    [Flurry logEvent:[FlurryManager getEventName:kFAComposeAlbum]];
    // photoOptionsView.hidden = YES;
    
    // start image picker for camera
    //[AppUIManager dispatchBlock:^{[photoManager displayPhotoLibrary]; } afterDelay:0.5];
    //[photoManager performSelector:@selector(displayPhotoLibrary) withObject:nil afterDelay:0.3];
    NSLog(@"1");
    [photoManager displayPhotoLibrary];
     NSLog(@"2");
}

- (void)photoCaptureCancelled {
    //[self photoDialogCancelAction];
}
- (void)photoCaptureDoneWithImage:(UIImage *)image {
    // set image view
//    [self cropImageToSquare:image];
    profileImageView.image = image;
}

@end
