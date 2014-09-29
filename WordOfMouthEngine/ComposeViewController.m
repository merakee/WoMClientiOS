//
//  AddContentViewController.m
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 2/15/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import "ComposeViewController.h"
#import "ComposeViewHelper.h"
#import "ApiManager.h"
#import "FlurryManager.h"

@implementation ComposeViewController

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
        photoManager.allowEditting = NO;
    }
    return self;
}

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
    // full screen view
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}
// Implement viewWillAppear method for setting up the display
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // clear category selection
    [self updateViewForCategory:kAPIContentCategoryNews];
    
    
    
    // hide navigation bar
    [self.navigationController setNavigationBarHidden:YES];
    
    
    // hide tabbar
    //[self setHidesBottomBarWhenPushed:YES];
    
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    // Analytics: Flurry
    [Flurry logEvent:[FlurryManager getEventName:kFAComposeSession] withParameters:nil timed:YES];
    // display key board
    [composeTextView becomeFirstResponder];
    [self textViewDidChange:composeTextView];
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // Analytics: Flurry
    [Flurry endTimedEvent:[FlurryManager getEventName:kFAComposeSession] withParameters:nil];
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

#pragma mark -  Local View Methods Implememtation
- (void)setView {
    // set view
    [ComposeViewHelper setView:self.view];
    
    // set navigation bar
    //[self setNavigationBar];
    
    // image view
    contentImageView = [ComposeViewHelper getContentImageView];
    [self.view addSubview:contentImageView];
    
    // set Category control
    //    categoryControl = [ComposeViewHelper getCategoryControl];
    //    [categoryControl addTarget:self action:@selector(selectedCategoryChanged:) forControlEvents:UIControlEventValueChanged];
    //    [self.view addSubview:categoryControl];
    
    // set TextView
    composeTextView = [ComposeViewHelper getComposeTextViewWithDelegate:self];
    [self.view addSubview:composeTextView];
    
    // place holder label
    placeHolderLabel = [ComposeViewHelper getPlaceHolderLabel];
    [self.view addSubview:placeHolderLabel];
    
    
    
    // buttons
    postButton = [ComposeViewHelper getPostButton];
    [postButton addTarget:self action:@selector(postContent:) forControlEvents:UIControlEventTouchUpInside];
    cameraOptionsButton = [ComposeViewHelper getCameraOptionsButton];
    [cameraOptionsButton addTarget:self action:@selector(showPhotoOptions:) forControlEvents:UIControlEventTouchUpInside];
    cancelButton = [ComposeViewHelper getCancelButton];
    [cancelButton addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:postButton ];
    [self.view addSubview:cameraOptionsButton];
    [self.view addSubview:cancelButton];
    
    
    //activity indicator view
    activityIndicator =[[UIActivityIndicatorView alloc] init];
    [AppUIManager addActivityIndicator:activityIndicator toView:self.view];
    
    
    
    // set photos options view
    //[self setPhotoOptionsView];
    
    // layout
    [self layoutView];
    
    // scroll adjustment
    //self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)layoutView{
    // all view elements
    //NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(categoryControl,composeTextView);
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(contentImageView, composeTextView,placeHolderLabel,postButton,cancelButton,cameraOptionsButton);
    
    // buttons
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[cancelButton(40)]"                                                                      options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[cancelButton(40)]"                                                                      options:0 metrics:nil views:viewsDictionary]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[postButton(107)]"
                                                                      options:0 metrics:nil views:viewsDictionary]];
    [AppUIManager horizontallyCenterElement:postButton inView:self.view];
    [self.view addConstraints:              [NSLayoutConstraint constraintsWithVisualFormat:@"V:[postButton(66)]-214-|"
                                                                                    options:0 metrics:nil views:viewsDictionary]];
    
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[cameraOptionsButton(107)]"
                                                                      options:0 metrics:nil views:viewsDictionary]];
    [AppUIManager horizontallyCenterElement:cameraOptionsButton inView:self.view];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[cameraOptionsButton(80)]"
                                                                      options:0 metrics:nil views:viewsDictionary]];
    
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[cameraOptionsButton]-4-[composeTextView]-4-[postButton]"
                                                                      options:0 metrics:nil views:viewsDictionary]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-24-[composeTextView]-24-|"
                                                                      options:0 metrics:nil views:viewsDictionary]];
    
    
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[contentImageView]|"
                                                                      options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[contentImageView]|"
                                                                      options:0 metrics:nil views:viewsDictionary]];
    
    // place holder label
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[placeHolderLabel(240)]"
                                                                      options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[placeHolderLabel(30)]-24-[postButton]"
                                                                      options:0 metrics:nil views:viewsDictionary]];
    [AppUIManager horizontallyCenterElement:placeHolderLabel inView:self.view];
}

- (void)setNavigationBar {
    //self.navigationItem.title =@"WoM";
    self.navigationItem.titleView = [AppUIManager getAppLogoViewForNavTitle];
    // set up navigation bar
    //    self.navigationItem.titleView = [[UIBarButtonItem alloc]
    //                                     initWithBarButtonSystemItem:UIBarButtonSystemItemCamera
    //                                     target:self
    //                                     action:@selector(addPicture:)];
    
    // right navigation button
    self.navigationItem.rightBarButtonItems = @[[[UIBarButtonItem alloc]
                                                 initWithBarButtonSystemItem:UIBarButtonSystemItemCamera
                                                 target:self
                                                 action:@selector(showPhotoOptions:)],
                                                [[UIBarButtonItem alloc]
                                                 initWithTitle:@"Post"
                                                 style:UIBarButtonItemStyleDone
                                                 target:self
                                                 action:@selector(postContent:)]
                                                ];
    [self.navigationItem.rightBarButtonItems[0] setAccessibilityIdentifier:@"Add Picture"];
    
    self.navigationItem.leftBarButtonItem =  [[UIBarButtonItem alloc]
                                              initWithBarButtonSystemItem:UIBarButtonSystemItemStop
                                              target:self
                                              action:@selector(goBack:)];
    
}

- (void)updateViewForCategory:(kAPIContentCategory)category{
    //[ComposeViewHelper updateCategoryControl:categoryControl forCategory:category];
    // composeTextView.backgroundColor =[AppUIManager getContentColorForCategory:category];
}
//- (void)setPhotoOptionsView{
//    photoOptionsView = [ComposeViewHelper getPhotoOptionView];
//    // add as subview and hide
//    [self.view addSubview:photoOptionsView];
//    photoOptionsView.hidden = YES;
//
//    // add buttons
//    albumButton = [ComposeViewHelper getAlbumButton];
//    [albumButton addTarget:self action:@selector(albumButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
//    [photoOptionsView addSubview:albumButton];
//
//    //    if([photoManager isCameraAvailable]){
//    cameraButton = [ComposeViewHelper getCameraButton];
//    [cameraButton  addTarget:self action:@selector(cameraButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
//    [photoOptionsView addSubview:cameraButton];
//    // layout
//    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(photoOptionsView,cameraButton,albumButton);
//
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[photoOptionsView(101)]"
//                                                                      options:0 metrics:nil views:viewsDictionary]];
//    [AppUIManager horizontallyCenterElement:photoOptionsView inView:self.view];
//
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-76-[photoOptionsView(111)]"
//                                                                      options:0 metrics:nil views:viewsDictionary]];
//
//
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[cameraButton]|"
//                                                                      options:0 metrics:nil views:viewsDictionary]];
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[albumButton]|"
//                                                                      options:0 metrics:nil views:viewsDictionary]];
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[albumButton(cameraButton)]-8-[cameraButton(30)]-16-|"
//                                                                      options:0 metrics:nil views:viewsDictionary]];
//    //    }
//    //    else{
//    //        NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(photoOptionsView,albumButton);
//    //        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(>=20)-[photoOptionsView(80)]|"
//    //                                                                          options:0 metrics:nil views:viewsDictionary]];
//    //
//    //        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-64-[photoOptionsView(30)]"
//    //                                                                          options:0 metrics:nil views:viewsDictionary]];
//    //        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-2-[albumButton]-2-|"
//    //                                                                          options:0 metrics:nil views:viewsDictionary]];
//    //        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-2-[albumButton]-2-|"
//    //                                                                          options:0 metrics:nil views:viewsDictionary]];
//    //    }
//}

- (void)disableKeyBoard{
    // disable keyboard
    [composeTextView resignFirstResponder];
}

#pragma mark - textview delegate methods
//- (BOOL) textViewShouldBeginEditing:(UITextView *)textView{
//    return YES;
//}
//- (void)textViewDidBeginEditing:(UITextView *)textView{
//    NSLog(@"....1...");
//    //if(textView.tag == 0) {
//        textView.text = @"";
//        // textView.textColor = [UIColor whiteColor];
//        textView.tag = 1;
//    //}
//}
- (void)textViewDidChange:(UITextView *)textView{
    long  textLength =[textView.text length];
    // place holder text
    if(( textLength== 0)&&(placeHolderLabel.isHidden)){
        placeHolderLabel.hidden=NO;
    }
    else if((textLength> 0)&&(!placeHolderLabel.isHidden)){
        placeHolderLabel.hidden=YES;
    }
    
    textLength =[[CommonUtility  trimString:textView.text ] length];
    
    // post button
    if((textLength < kAPIValidationContentMinLength)&&(postButton.isEnabled)){
        postButton.enabled=NO;
    }
    else if((textLength >= kAPIValidationContentMinLength)&&(!postButton.isEnabled)){
        postButton.enabled=YES;
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    // return key
    if([text isEqualToString:@"\n"]) {
        [self postContent:nil];
        return NO;
    }
    
    long totalLength = textView.text.length - range.length + text.length;
    
    if (totalLength>kAPIValidationContentMaxLength){
        return NO;
    }
    return YES;
}

//- (void)textViewDidEndEditing:(UITextView *)textView{
//
//}


#pragma mark - Button Action Methods
- (void)postContent:(id)sender {
    // Analytics: Flurry
    [Flurry logEvent:[FlurryManager getEventName:kFAComposePost]];
    
    // attempt to post content
    ApiContent *ci =[[ApiContent alloc] init];
    ci.contentText = [CommonUtility trimString:composeTextView.text];
    ci.categoryId = [NSNumber numberWithInteger: kAPIContentCategoryNews];
    //    if(categoryControl.selectedSegmentIndex==UISegmentedControlNoSegment){
    //        ci.categoryId = [NSNumber numberWithInteger: kAPIContentCategoryOther];
    //    }
    //    else{
    //        ci.categoryId = [NSNumber numberWithInteger:categoryControl.selectedSegmentIndex+1];
    //    }
    
    // disable post button
    postButton.enabled = NO;
    
    // post content
    [activityIndicator startAnimating];
    
    // post content user
    [activityIndicator startAnimating];
    [[ApiManager sharedApiManager] postContentWithCategoryId:(int)ci.categoryId.integerValue
                                                        text:ci.contentText
                                                       photo:contentImageView.image
                                                     success:^(ApiContent * content){
                                                         [activityIndicator stopAnimating];
                                                         [self actionsForSuccessfulPostContent];
                                                     }failure:^(NSError * error){
                                                         // Analytics: Flurry
                                                         [Flurry logEvent:[FlurryManager getEventName:kFAComposePostFailure] withParameters:@{@"Error":error}];
                                                         [activityIndicator stopAnimating];
                                                         [ApiErrorManager displayAlertWithError:error withDelegate:self];
                                                     }];
    
}

- (void)addPicture:(id)sender {
    
}
#pragma mark - Api Manager Post actions methods
- (void)actionsForSuccessfulPostContent{
    // Analytics: Flurry
    [Flurry logEvent:[FlurryManager getEventName:kFAComposePostSuccess]];
    //clear content
    [self clearViewAfterSuccessfulPostOrCancel];
    // display sucess
    //[CommonUtility displayAlertWithTitle:@"Post Successful"
    //                           message:@"Your content was posted sucessfully!" delegate:self];
    UIAlertView *alertView  = [[UIAlertView alloc] initWithTitle:@"Post Successful"
                                                          message:@""
                                                         delegate:self
                                                cancelButtonTitle:nil
                                                otherButtonTitles:nil];
    
    [alertView show];
    
    // dismiss autometically
    [self performSelector:@selector(dismissAlertView:) withObject:alertView afterDelay:1.0];
    
}
-(void)dismissAlertView:(UIAlertView *)alertView{
    [alertView dismissWithClickedButtonIndex:0 animated:YES];
}

- (void)clearViewAfterSuccessfulPostOrCancel{
    composeTextView.text=nil;
    contentImageView.image = nil;
}


- (void)goBack:(id)sender {
    // go back
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)cancelPost:(id)sender {
    // clear post
    [self clearViewAfterSuccessfulPostOrCancel];
    // go back to content view
    //self.tabBarController.selectedIndex = kCFVTabbarIndexContent;
}

#pragma mark - control events methods
- (void)selectedCategoryChanged:(id)sender{
    // update colors
    kAPIContentCategory category = (kAPIContentCategory) [(UISegmentedControl *)sender selectedSegmentIndex]+1;
    [self updateViewForCategory:category];
}

#pragma mark - Action sheet delegate method
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(actionSheet.tag==kAUCComposePhotoOptionsActionSheetTag){
        [self processPhotoOptionsActionSheet:(UIActionSheet*)actionSheet withIndex:buttonIndex];
        return;
    }
    //Button actions using delegate
    //int customButtonStartIndex = (actionSheet.cancelButtonIndex>=0) ? 1 : 0;
    //customButtonStartIndex += (actionSheet.destructiveButtonIndex>=0) ? 1 : 0;
    // int totalCustomButtons = actionSheet.numberOfButtons - customButtonStartIndex;
    
    // NSPLogBLog(@"bIndeX: %d cIndex:%d",buttonIndex,customButtonStartIndex);
    
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
    
    //    // NSPLogBLog(@"bIndeX: %d cIndex:%d",buttonIndex,customButtonStartIndex);
    //
    //    // check if cancelButton Pressed
    //    if(actionSheet.cancelButtonIndex==buttonIndex) {
    //        // NSPLogBLog(@"Action for C Button");
    //        [self clearViewAfterSuccessfulPostOrCancel];
    //    }
    //    else if(actionSheet.destructiveButtonIndex==buttonIndex) {
    //        //[busyIndicator startAnimating];
    //        //[self performSelector:@selector(setDefaultAutoPlan) withObject:nil afterDelay:kCRDPerformSelectorDelay];
    //        [self goBack:nil];
    //    }
    //    else{
    //        // get selected grade
    //    }
    
}
#pragma mark - Photo buttons
#pragma mark - popover controller method
- (void)showPhotoOptions:(id)sender{
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
                                           tag:kAUCComposePhotoOptionsActionSheetTag];
    
    
    //photoOptionsView.hidden = !photoOptionsView.hidden;
    // set the view to disappear
    //    if(photoOptionsView.hidden==NO){
    //        [UIView animateWithDuration:.5
    //                              delay:3
    //                            options:UIViewAnimationOptionCurveEaseOut
    //                         animations:^(void){
    //                             //photoOptionsView.alpha = .25;
    //                         }
    //                         completion:^(BOOL finished){
    //                             //photoOptionsView.hidden=YES;
    //                             //photoOptionsView.alpha = 1;
    //                         }];
    //
    //    }
}

- (void)cameraButtonPressed:(id)sender {
    // Analytics: Flurry
    [Flurry logEvent:[FlurryManager getEventName:kFAComposeCamera]];
    //photoOptionsView.hidden = YES;
    
    [self disableKeyBoard];
    // start image picker for camera
    //[AppUIManager dispatchBlock:^{[photoManager displayCamera]; } afterDelay:0.5];
    //[photoManager performSelector:@selector(displayCamera) withObject:nil afterDelay:0.3];
    [photoManager displayCamera];
}

- (void)albumButtonPressed:(id)sender {
    // Analytics: Flurry
    [Flurry logEvent:[FlurryManager getEventName:kFAComposeAlbum]];
    // photoOptionsView.hidden = YES;
    
    [self disableKeyBoard];
    // start image picker for camera
    //[AppUIManager dispatchBlock:^{[photoManager displayPhotoLibrary]; } afterDelay:0.5];
    //[photoManager performSelector:@selector(displayPhotoLibrary) withObject:nil afterDelay:0.3];
    [photoManager displayPhotoLibrary];
}


#pragma mark -  Image Processing Manager Delegate methods
- (void)photoCaptureCancelled {
    //[self photoDialogCancelAction];
}
- (void)photoCaptureDoneWithImage:(UIImage *)image {
    // set image view
    contentImageView.image = image;
}

@end
