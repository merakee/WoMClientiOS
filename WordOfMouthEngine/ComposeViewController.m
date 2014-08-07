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
    
    // display key board
    [composeTextView becomeFirstResponder];
    
    
    // hide tabbar
    //[self setHidesBottomBarWhenPushed:YES];
    
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

#pragma mark -  Local View Methods Implememtation
- (void)setView {
    // set view
    [ComposeViewHelper setView:self.view];
    
    // set navigation bar
    [self setNavigationBar];
    
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
    
    
    //activity indicator view
    activityIndicator =[[UIActivityIndicatorView alloc] init];
    [AppUIManager addActivityIndicator:activityIndicator toView:self.view];
    
    
    
    // set photos options view
    [self setPhotoOptionsView];
    
    // layout
    [self layoutView];
    
    // scroll adjustment
    //self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)layoutView{
    // all view elements
    //NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(categoryControl,composeTextView);
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(contentImageView, composeTextView);
    // text filed
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[composeTextView(>=100)]-|"
                                                                      options:0 metrics:nil views:viewsDictionary]];
    //[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[categoryControl(>=100)]-|"
    //                                                                options:0 metrics:nil views:viewsDictionary]];
    //[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-68-[categoryControl]-8-[composeTextView]-218-|"
    //                                                                 options:0 metrics:nil views:viewsDictionary]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-68-[composeTextView]-218-|"
                                                                      options:0 metrics:nil views:viewsDictionary]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[contentImageView]|"
                                                                      options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-64-[contentImageView]|"
                                                                      options:0 metrics:nil views:viewsDictionary]];
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
    [self.navigationItem.rightBarButtonItems[0] setAccessibilityLabel:@"Add Picture"];
    
    self.navigationItem.leftBarButtonItem =  [[UIBarButtonItem alloc]
                                              initWithBarButtonSystemItem:UIBarButtonSystemItemStop
                                              target:self
                                              action:@selector(goBack:)];
    
}

- (void)updateViewForCategory:(kAPIContentCategory)category{
    //[ComposeViewHelper updateCategoryControl:categoryControl forCategory:category];
    composeTextView.backgroundColor =[AppUIManager getContentColorForCategory:category];
}
- (void)setPhotoOptionsView{
    photoOptionsView = [ComposeViewHelper getPhotoOptionView];
    // add as subview and hide
    [self.view addSubview:photoOptionsView];
    photoOptionsView.hidden = YES;
    
    // add buttons
    albumButton = [ComposeViewHelper getAlbumButton];
    [albumButton addTarget:self action:@selector(albumButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [photoOptionsView addSubview:albumButton];
    
    if([photoManager isCameraAvailable]){
        cameraButton = [ComposeViewHelper getCameraButton];
        [cameraButton  addTarget:self action:@selector(cameraButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [photoOptionsView addSubview:cameraButton];
        // layout
        NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(photoOptionsView,cameraButton,albumButton);
        
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(>=20)-[photoOptionsView(80)]|"
                                                                          options:0 metrics:nil views:viewsDictionary]];
        
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-64-[photoOptionsView(60)]"
                                                                          options:0 metrics:nil views:viewsDictionary]];
        
        
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-2-[cameraButton]-2-|"
                                                                          options:0 metrics:nil views:viewsDictionary]];
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-2-[albumButton]-2-|"
                                                                          options:0 metrics:nil views:viewsDictionary]];
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-2-[cameraButton(30)]-4-[albumButton(cameraButton)]-2-|"
                                                                          options:0 metrics:nil views:viewsDictionary]];
    }
    else{
        NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(photoOptionsView,albumButton);
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(>=20)-[photoOptionsView(80)]|"
                                                                          options:0 metrics:nil views:viewsDictionary]];
        
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-64-[photoOptionsView(30)]"
                                                                          options:0 metrics:nil views:viewsDictionary]];
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-2-[albumButton]-2-|"
                                                                          options:0 metrics:nil views:viewsDictionary]];
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-2-[albumButton]-2-|"
                                                                          options:0 metrics:nil views:viewsDictionary]];
    }
}
#pragma mark - Button Action Methods
- (void)postContent:(id)sender {
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
                                                         [activityIndicator stopAnimating];
                                                         [ApiErrorManager displayAlertWithError:error withDelegate:self];
                                                     }];
    
}

- (void)addPicture:(id)sender {
    
}
#pragma mark - Api Manager Post actions methods
- (void)actionsForSuccessfulPostContent{
    //clear content
    [self clearViewAfterSuccessfulPostOrCancel];
    // display sucess
    [CommonUtility displayAlertWithTitle:@"Post Successful"
                                 message:@"Your content was posted sucessfully!" delegate:self];
    
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

#pragma mark - Photo buttons
#pragma mark - popover controller method
- (void)showPhotoOptions:(id)sender{
    photoOptionsView.hidden = !photoOptionsView.hidden;
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
    photoOptionsView.hidden = YES;
    // start image picker for camera
    [photoManager displayCamera];
}

- (void)albumButtonPressed:(id)sender {
    photoOptionsView.hidden = YES;
    // start image picker for camera
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
