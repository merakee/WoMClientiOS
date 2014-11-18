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
 //   [self.navigationController setNavigationBarHidden:YES];
    
    
    // hide tabbar
    //[self setHidesBottomBarWhenPushed:YES];
    
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    // Analytics: Flurry
    [Flurry logEvent:[FlurryManager getEventName:kFAComposeSession] withParameters:nil timed:YES];
    // display key board
//    [composeTextView becomeFirstResponder];
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
    
    // call Keyboard Notification
  //  [self registerForKeyboardNotifications];
    
    // set up scroll View
//    scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0,0,320,380)];
//    scrollView.showsVerticalScrollIndicator=YES;
//    scrollView.scrollEnabled=YES;
//    scrollView.userInteractionEnabled=YES;
//    scrollView.contentSize=CGSizeMake(320, 400);
//    scrollView.backgroundColor = [UIColor redColor];
  
 //   [self createInputAccessoryView];

    // set view
    [ComposeViewHelper setView:self.view];
    
    // set navigation bar
    [self setNavigationBar];
     self.navigationController.toolbarHidden = YES;
   // [self.view addSubview:scrollView];
    

    
    // image view
    contentImageView = [ComposeViewHelper getContentImageView];
 //   [scrollView addSubview:contentImageView];
   [self.view addSubview:contentImageView];

    // set Category control
    //    categoryControl = [ComposeViewHelper getCategoryControl];
    //    [categoryControl addTarget:self action:@selector(selectedCategoryChanged:) forControlEvents:UIControlEventValueChanged];
    //    [self.view addSubview:categoryControl];
    
    // set TextView
    composeTextView = [ComposeViewHelper getComposeTextViewWithDelegate:self];
    [contentImageView addSubview:composeTextView];
    
    // place holder label
    placeHolderLabel = [ComposeViewHelper getPlaceHolderLabel];
    [self.view addSubview:placeHolderLabel];
    
    
    // buttons
//    postButton = [ComposeViewHelper getPostButton];
//    [postButton addTarget:self action:@selector(postContent:) forControlEvents:UIControlEventTouchUpInside];
    cameraOptionsButton = [ComposeViewHelper getCameraOptionsButton];
    [cameraOptionsButton addTarget:self action:@selector(showPhotoOptions:) forControlEvents:UIControlEventTouchUpInside];
    
    
//    cancelButton = [ComposeViewHelper getCancelButton];
//    [cancelButton addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    
//    [self.view addSubview:postButton];
//    [self.view addSubview:cameraOptionsButton];
//    [self.view addSubview:cancelButton];
    
    
    //activity indicator view
    activityIndicator =[[UIActivityIndicatorView alloc] init];
    [AppUIManager addActivityIndicator:activityIndicator toView:self.view];
    
    
    // set photos options view
    //[self setPhotoOptionsView];
    
    // Set toolbar
    [self setToolBar];
    
    // Set webView
    [self loadWebView];
    
    // layout
    [self layoutView];
    
    // scroll adjustment
    //self.automaticallyAdjustsScrollViewInsets = NO;
   
}

- (void)layoutView{
    // all view elements
    //NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(categoryControl,composeTextView);
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(contentImageView, composeTextView,placeHolderLabel, composeToolBar);
    
    // buttons
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[cancelButton(40)]"                                                                      options:0 metrics:nil views:viewsDictionary]];
//    
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[cancelButton(40)]"                                                                      options:0 metrics:nil views:viewsDictionary]];
    
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[postButton(107)]"
//                                                                      options:0 metrics:nil views:viewsDictionary]];
//    [AppUIManager horizontallyCenterElement:postButton inView:self.view];
//    [self.view addConstraints:              [NSLayoutConstraint constraintsWithVisualFormat:@"V:[postButton(66)]-214-|"
//                                                                                    options:0 metrics:nil views:viewsDictionary]];
    
//    
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[cameraOptionsButton(50)]"
//                                                                      options:0 metrics:nil views:viewsDictionary]];
//    [AppUIManager horizontallyCenterElement:cameraOptionsButton inView:self.view];
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[cameraOptionsButton(50)]-20-[composeTextView]"
//                                                                      options:0 metrics:nil views:viewsDictionary]];
    
    
    [contentImageView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-4-[composeTextView]-218-|"
                                                                      options:0 metrics:nil views:viewsDictionary]];
    
    [contentImageView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-24-[composeTextView]-24-|"
                                                                      options:0 metrics:nil views:viewsDictionary]];
    
    
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[contentImageView]|"
                                                                      options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[contentImageView]|"
                                                                      options:0 metrics:nil views:viewsDictionary]];

    // place holder label
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[placeHolderLabel(240)]"
                                                                      options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[placeHolderLabel(30)]"
                                                                      options:0 metrics:nil views:viewsDictionary]];
    [AppUIManager horizontallyCenterElement:placeHolderLabel inView:self.view];
    
    // compose tool bar
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[composeToolBar(320)]"
                                                                      options:0 metrics:nil views:viewsDictionary]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[composeToolBar(50)]-5-|"
                                                                                    options:0 metrics:nil views:viewsDictionary]];
    
}

- (void)setNavigationBar {
    //self.navigationItem.title =@"WoM";
//    self.navigationItem.titleView = [AppUIManager getAppLogoViewForNavTitle];
    // set up navigation bar
    //    self.navigationItem.titleView = [[UIBarButtonItem alloc]
    //                                     initWithBarButtonSystemItem:UIBarButtonSystemItemCamera
    //                                     target:self
    //                                     action:@selector(addPicture:)];
    
    // right navigation button
//    self.navigationItem.rightBarButtonItems = @[[[UIBarButtonItem alloc]
//                                                 initWithBarButtonSystemItem:UIBarButtonSystemItemCamera
//                                                 target:self
//                                                 action:@selector(showPhotoOptions:)],
//                                                [[UIBarButtonItem alloc]
//                                                 initWithTitle:@"Post"
//                                                 style:UIBarButtonItemStyleDone
//                                                 target:self
//                                                 action:@selector(postContent:)]
//                                                ];
    
    // character count label
    characterCount = [ComposeViewHelper getCharacterCountLabel];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
    [button setFrame:CGRectMake(0, 0, 65, 42)];
 //   [button setFrame:CGRectMake(0, 0, 45, 25)];
    [button addSubview:characterCount];
    
    UIBarButtonItem *characterButton = [[UIBarButtonItem alloc]initWithCustomView:button];
 //   [self.navigationController.navigationItem setRightBarButtonItem:characterButton];
 //   self.navigationItem.title = characterCount;
    
    self.navigationItem.rightBarButtonItems = @[[[UIBarButtonItem alloc]
                                                 initWithTitle:@"Post"
                                                 style:UIBarButtonItemStyleDone
                                                 target:self
                                                 action:@selector(postContent:)],
                                                characterButton];


    [self.navigationItem.rightBarButtonItems[0] setAccessibilityIdentifier:@"Add Picture"];
    
    self.navigationItem.leftBarButtonItem =  [[UIBarButtonItem alloc]
                                              initWithBarButtonSystemItem:UIBarButtonSystemItemStop
                                              target:self
                                              action:@selector(goBack:)];
}
- (void)setToolBar {
    
    float screenW = [CommonUtility getScreenWidth];
    //   infoToolBar = [[UIToolbar alloc] init];
    composeToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, screenW, 50)];
    //    infoToolBar = [[UIToolbar alloc] init];
    //   infoToolBar.frame = CGRectMake(0,  44, self.view.frame.size.width, 44);
    composeToolBar.backgroundColor = [UIColor clearColor];
    composeToolBar.tintColor = [UIColor orangeColor];
    composeToolBar.translucent = YES;
    // Make toolbar clear
    [composeToolBar setTranslatesAutoresizingMaskIntoConstraints:NO];
    [composeToolBar setBackgroundImage:[UIImage new]
                 forToolbarPosition:UIBarPositionAny
                         barMetrics:UIBarMetricsDefault];
    [composeToolBar setShadowImage:[UIImage new]
             forToolbarPosition:UIToolbarPositionAny];
    
    textButton = [ComposeViewHelper getTextButton];
    [textButton addTarget:self action:@selector(textButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    imageButton = [ComposeViewHelper getImageButton];
    [imageButton addTarget:self action:@selector(imageButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    filterButton = [ComposeViewHelper getFilterButton];
    [filterButton addTarget:self action:@selector(filterButtonPressed:) forControlEvents:UIControlEventTouchUpInside];

    UIBarButtonItem *flexibleSpace =  [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];

//    textBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(textButtonPressed:)];
    textBarButton = [[UIBarButtonItem alloc] initWithCustomView:textButton];
   imageBarButton = [[UIBarButtonItem alloc] initWithCustomView:imageButton];
    filterBarButton = [[UIBarButtonItem alloc] initWithCustomView:filterButton];

    NSArray *buttonItems = [NSArray arrayWithObjects:textBarButton, flexibleSpace, imageBarButton, flexibleSpace, filterBarButton, nil];
    [composeToolBar setItems:buttonItems];
    [self.view addSubview:composeToolBar];
    
}
//- (void)registerForKeyboardNotifications {
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(createAccessoryView:)
//                                                 name:UIKeyboardDidShowNotification
//                                               object:nil];
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(keyboardWillBeHidden:)
//                                                 name:UIKeyboardWillHideNotification
//                                               object:nil];
//}
//
//- (void)deregisterFromKeyboardNotifications {
//    [[NSNotificationCenter defaultCenter] removeObserver:self
//                                                    name:UIKeyboardDidHideNotification
//                                                  object:nil];
//    
//    [[NSNotificationCenter defaultCenter] removeObserver:self
//                                                    name:UIKeyboardWillHideNotification
//                                                  object:nil];
//}
- (void)createAccessoryView{
    
    float screenW = [CommonUtility getScreenWidth];
    keyboardToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, screenW, 50)];
//    accView = [[UIView alloc] initWithFrame:CGRectMake(10.0, 300, 320.0, 40.0)];

    keyboardToolBar.backgroundColor = [UIColor clearColor];
    keyboardToolBar.tintColor = [UIColor orangeColor];
    keyboardToolBar.translucent = YES;
    // Make toolbar clear
    [keyboardToolBar setTranslatesAutoresizingMaskIntoConstraints:NO];
    [keyboardToolBar setBackgroundImage:[UIImage new]
                    forToolbarPosition:UIBarPositionAny
                            barMetrics:UIBarMetricsDefault];
    [keyboardToolBar setShadowImage:[UIImage new]
                forToolbarPosition:UIToolbarPositionAny];
    
    [composeTextView becomeFirstResponder];
    [accView setBackgroundColor:[UIColor lightGrayColor]];
   
    xButton = [ComposeViewHelper getXButton];
    checkButton = [ComposeViewHelper getCheckButton];
    backgroundButton = [ComposeViewHelper getBackgroundButton];
      // [self.view addSubview:accView];
//    [accView addSubview:xButton];
//    [accView addSubview:checkButton];
//    [accView addSubview:backgroundButton];
//    
//     [composeTextView setInputAccessoryView:accView];
    
    xBarButton = [[UIBarButtonItem alloc] initWithCustomView:xButton];
    checkBarButton = [[UIBarButtonItem alloc] initWithCustomView:checkButton];
    backgroundBarButton = [[UIBarButtonItem alloc] initWithCustomView:backgroundButton];
    
    UIBarButtonItem *flexibleSpace =  [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    NSArray *buttonItems = [NSArray arrayWithObjects:xBarButton, flexibleSpace, checkBarButton, flexibleSpace, backgroundBarButton, nil];
     [keyboardToolBar setItems:buttonItems];
}

- (void)loadWebView{
    webView= [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, 500,300)];
    searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    searchTextField.backgroundColor = [UIColor redColor];
    NSString *searchString = searchTextField.text;
    NSString *urlAddress = [NSString stringWithFormat:@"http://www.google.com/search?q=%@",searchString];
    NSURL *url = [NSURL URLWithString:urlAddress];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [webView loadRequest:requestObj];
   // [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlAddress]];
   // [self.view addSubview:webView];
   // [self.view addSubview:searchTextField];
    
}
    
- (void)searchImage{
    NSString *searchString = searchTextField.text;
    NSString *urlAddress = [NSString stringWithFormat:@"http://www.google.com/search?q=%@",searchString];
    NSURL *url = [NSURL URLWithString:urlAddress];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [webView loadRequest:requestObj];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlAddress]];
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
    composeTextView.inputAccessoryView = nil;
}
#pragma mark - Input Accessory View

- (void)cancelText{
    [composeTextView resignFirstResponder];
}
//- (void)createInputAccessoryView{
//    inputAccView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 200.0, 310.0, 40.0)];
//    [inputAccView setBackgroundColor:[UIColor yellowColor]];
//    [inputAccView setAlpha: 0.8];
//    [self.view addSubview:inputAccView];
//    cancelButton = [ComposeViewHelper getCancelButton];
//    doneButton = [ComposeViewHelper getDoneButton];
//    [cancelButton addTarget:self action:@selector(disableKeyBoard) forControlEvents:UIControlEventTouchUpInside];
//    [doneButton addTarget:self action:@selector(disableKeyBoard) forControlEvents:UIControlEventTouchUpInside];
//    [inputAccView addSubview:cancelButton];
//    [inputAccView addSubview:doneButton];
//    NSLog(@"input");
//
//}


#pragma mark - Keyboard Notifications

//- (void)registerForKeyboardNotifications
//{
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(keyboardWasShown:)
//                                                 name:UIKeyboardDidShowNotification object:nil];
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(keyboardWillBeHidden:)
//                                                 name:UIKeyboardWillHideNotification object:nil];
//}
//
//- (void)keyboardWasShown:(NSNotification*)aNotification
//{
//
//    NSDictionary* info = [aNotification userInfo];
//    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
//    
//    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
//    scrollView.contentInset = contentInsets;
//    scrollView.scrollIndicatorInsets = contentInsets;
//    
//    
//    // If active text field is hidden by keyboard, scroll it so it's visible
//    // Your app might not need or want this behavior.
//    CGRect aRect = self.view.frame;
//    aRect.size.height -= kbSize.height;
//    CGPoint origin = composeTextView.frame.origin;
//    origin.y -= scrollView.contentOffset.y;
//    if (!CGRectContainsPoint(aRect, origin) ) {
//        CGPoint scrollPoint = CGPointMake(0.0, composeTextView.frame.origin.y-(aRect.size.height));
//        [scrollView setContentOffset:scrollPoint animated:YES];
//    }
//}
//
//- (void)keyboardWillBeHidden:(NSNotification*)aNotification
//{
//    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
//    scrollView.contentInset = contentInsets;
//    scrollView.scrollIndicatorInsets = contentInsets;
//}

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

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
   // [composeTextView resignFirstResponder];
    [composeTextView setInputAccessoryView:keyboardToolBar];
   // [composeTextView becomeFirstResponder];
   return YES;
}

- (void)textViewDidChange:(UITextView *)textView{
    long  textLength =[textView.text length];
    int maxLength = 200;
    long charLeft = maxLength - [textView.text length];
//    NSString *substring = [NSString stringWithString:composeTextView];
    
    //   Add swipe gesture
    panRecognized = [[UIPanGestureRecognizer alloc]
                     initWithTarget:self
                     action:@selector(panRecognized:)];
    
    [panRecognized setMinimumNumberOfTouches:1];
    [panRecognized setMaximumNumberOfTouches:1];

    [[self view] addGestureRecognizer:panRecognized];
    
    // place holder text
    if(( textLength == 0)&&(placeHolderLabel.isHidden)){
        placeHolderLabel.hidden=NO;
        characterCount.text = [NSString stringWithFormat:@"%ld", charLeft];
    }
    else if((textLength> 0)&&(!placeHolderLabel.isHidden)){
        placeHolderLabel.hidden=YES;
    }
      // Update remaining characters
    if (textLength >0){
        characterCount.text = [NSString stringWithFormat:@"%ld", charLeft];
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
//        [self postContent:nil];
       

       [composeTextView resignFirstResponder];
        return YES;
    }
    
    long totalLength = textView.text.length - range.length + text.length;
    
    if (totalLength>kAPIValidationContentMaxLength){
        return NO;
    }
    return YES;
}

- (void)panRecognized:(UIPanGestureRecognizer *)sender
{

    float screenH = [CommonUtility getScreenHeight];
    CGPoint distance = [sender translationInView:self.view];

    if (sender.state == UIGestureRecognizerStateEnded) {
        [sender cancelsTouchesInView];
         NSLog(@"Swiped at %f", distance.y);
        if (distance.y > (screenH / 10)) {
            [self disableKeyBoard];
        }
    }
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
    
    // Go back after successful post
    [self.navigationController popViewControllerAnimated:NO];
//    [ContentViewController self.view];
    //[ContentViewController setView];
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

- (void)textButtonPressed:(id)sender {
    [self createAccessoryView];
          NSLog(@"text pressed");
}

- (void)imageButtonPressed:(id)sender {
    NSLog(@"image pressed");
}

- (void)filterButtonPressed:(id)sender {
    NSLog(@"filter pressed");
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
   
    //[photoManager displayPhotoLibrary];
    
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
