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
long  textLength;

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
    [self.navigationController setNavigationBarHidden:YES];
    // Analytics: Flurry
    [Flurry logEvent:[FlurryManager getEventName:kFAComposeSession] withParameters:nil timed:YES];
    // display key board
    [self textViewDidChange:composeTextView];
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
   // [self.navigationController setToolbarHidden:NO];
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

-(BOOL)prefersStatusBarHidden{
    return YES;
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
    self.navigationController.navigationBar.hidden = NO;
//    self.navigationController.toolbarHidden = YES;
   // [self.view addSubview:scrollView];
    

    
    // image view
    contentImageView = [ComposeViewHelper getContentImageView];
   [self.view addSubview:contentImageView];
  //  contentImageView.backgroundColor = [UIColor redColor];
    // set Category control
    //    categoryControl = [ComposeViewHelper getCategoryControl];
    //    [categoryControl addTarget:self action:@selector(selectedCategoryChanged:) forControlEvents:UIControlEventValueChanged];
    //    [self.view addSubview:categoryControl];
    
//    postButton = [ComposeViewHelper getPostButton];
//    [postButton addTarget:self action:@selector(postContent:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:postButton];
//    
//    cancelButton = [ComposeViewHelper getCancelButton];
//    [cancelButton addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:cancelButton];
    
    // set TextView
    composeTextView = [ComposeViewHelper getComposeTextViewWithDelegate:self];
    [contentImageView addSubview:composeTextView];
    //composeTextView.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    //[composeTextView addObserver:self forKeyPath:@"contentSize" options:(NSKeyValueObservingOptionNew) context:NULL];
    
    
    // place holder label
//    composeTextView.backgroundColor = [UIColor redColor];
    placeHolderLabel = [ComposeViewHelper getPlaceHolderLabel];
    [composeTextView addSubview:placeHolderLabel];
    placeHolderLabel2 = [ComposeViewHelper getPlaceHolderLabel2];
    [composeTextView addSubview:placeHolderLabel2];
//    contentImageView.backgroundColor = [UIColor redColor];
    deleteImage = [ComposeViewHelper getRemoveImageButton];
    [deleteImage addTarget:self action:@selector(removeImage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:deleteImage];
    deleteImage.hidden = YES;
    
    // buttons
//    postButton = [ComposeViewHelper getPostButton];
//    [postButton addTarget:self action:@selector(postContent:) forControlEvents:UIControlEventTouchUpInside];
    cameraOptionsButton = [ComposeViewHelper getCameraOptionsButton];
    [cameraOptionsButton addTarget:self action:@selector(showPhotoOptions:) forControlEvents:UIControlEventTouchUpInside];
    
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
    paraStyle = [NSMutableParagraphStyle new];
    paraStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paraStyle.alignment = NSTextAlignmentCenter;
    
    // Set default toolbar
    [self defaultToolBar];
    
    // Set colors
    color1 = [ComposeViewHelper getColor1];
    [color1 addTarget:self action:@selector(color1Pressed:) forControlEvents:UIControlEventTouchUpInside];
    color2 = [ComposeViewHelper getColor2];
    [color2 addTarget:self action:@selector(color2Pressed:) forControlEvents:UIControlEventTouchUpInside];
    color3 = [ComposeViewHelper getColor3];
    [color3 addTarget:self action:@selector(color3Pressed:) forControlEvents:UIControlEventTouchUpInside];
    color4 = [ComposeViewHelper getColor4];
    [color4 addTarget:self action:@selector(color4Pressed:) forControlEvents:UIControlEventTouchUpInside];
    color5 = [ComposeViewHelper getColor5];
    [color5 addTarget:self action:@selector(color5Pressed:) forControlEvents:UIControlEventTouchUpInside];
    color6 = [ComposeViewHelper getColor6];
    [color6 addTarget:self action:@selector(color6Pressed:) forControlEvents:UIControlEventTouchUpInside];
    color7 = [ComposeViewHelper getColor7];
    [color7 addTarget:self action:@selector(color7Pressed:) forControlEvents:UIControlEventTouchUpInside];
    color8 = [ComposeViewHelper getColor8];
    [color8 addTarget:self action:@selector(color8Pressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [color1 setTranslatesAutoresizingMaskIntoConstraints:NO];
    [color2 setTranslatesAutoresizingMaskIntoConstraints:NO];
    [color3 setTranslatesAutoresizingMaskIntoConstraints:NO];
    [color4 setTranslatesAutoresizingMaskIntoConstraints:NO];
    [color5 setTranslatesAutoresizingMaskIntoConstraints:NO];
    [color6 setTranslatesAutoresizingMaskIntoConstraints:NO];
    [color7 setTranslatesAutoresizingMaskIntoConstraints:NO];
    [color8 setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    
    [self.view addSubview:color1];
    [self.view addSubview:color2];
    [self.view addSubview:color3];
    [self.view addSubview:color4];
    [self.view addSubview:color5];
    [self.view addSubview:color6];
    [self.view addSubview:color7];
    [self.view addSubview:color8];
    [self addColorKeyboardToolBar];
    [self.view addSubview:colorKeyboardToolBar];
    
    colorKeyboardToolBar.hidden = YES;
    color1.hidden = YES;
    color2.hidden = YES;
    color3.hidden = YES;
    color4.hidden = YES;
    color5.hidden = YES;
    color6.hidden = YES;
    color7.hidden = YES;
    color8.hidden = YES;
    
    // layout
    [self layoutView];
    
    [self addGesture];
    // scroll adjustment
    //self.automaticallyAdjustsScrollViewInsets = NO;
   
}

- (void)layoutView{
    // all view elements
    //NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(categoryControl,composeTextView);
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(contentImageView, composeTextView,placeHolderLabel, placeHolderLabel2, textButton, imageButton, deleteImage, postButton, cancelButton, colorKeyboardToolBar, color1, color2, color3, color4, color5, color6, color7, color8);
    
    // buttons
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[cancelButton(44)]"                                                                      options:0 metrics:nil views:viewsDictionary]];
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-15-[cancelButton(33)]"                                                                      options:0 metrics:nil views:viewsDictionary]];
    
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[postButton(44)]|"                                                                      options:0 metrics:nil views:viewsDictionary]];
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-15-[postButton(44)]"                                                                      options:0 metrics:nil views:viewsDictionary]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-14-[deleteImage(33)]"                                                                      options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-347-[deleteImage(33)]"                                                                      options:0 metrics:nil views:viewsDictionary]];
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
  
    [contentImageView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[composeTextView(150)]"
                                                                      options:0 metrics:nil views:viewsDictionary]];
    
    [AppUIManager verticallyCenterElement:composeTextView inView:contentImageView];

    [contentImageView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-24-[composeTextView]-24-|"
                                                                      options:0 metrics:nil views:viewsDictionary]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[postButton(61)]-15-|"
                                                                      options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[cancelButton(40)]"
                                                                      options:0 metrics:nil views:viewsDictionary]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[contentImageView]|"
                                                                      options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[postButton(40)]-[contentImageView]"
                                                                      options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[cancelButton(40)]-[contentImageView]"
                                                                      options:0 metrics:nil views:viewsDictionary]];
    
    // content image view height
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:contentImageView
                                                      attribute:NSLayoutAttributeHeight
                                                      relatedBy:NSLayoutRelationEqual
                                                         toItem:contentImageView
                                                      attribute:NSLayoutAttributeWidth
                                                     multiplier:1.0
                                                       constant:0.0]];
    

    // place holder label
    [composeTextView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[placeHolderLabel(240)]"
                                                                      options:0 metrics:nil views:viewsDictionary]];
    [composeTextView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[placeHolderLabel]-5-[placeHolderLabel2]|"
                                                                      options:0 metrics:nil views:viewsDictionary]];
    [composeTextView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[placeHolderLabel2(240)]"
                                                                            options:0 metrics:nil views:viewsDictionary]];
  
    [AppUIManager horizontallyCenterElement:placeHolderLabel inView:composeTextView];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[textButton(56)]-43-[imageButton(56)]-78-|"
                                                                      options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[textButton(57)]-40-|"
                                                                                    options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[imageButton(57)]-40-|"
                                                                      options:0 metrics:nil views:viewsDictionary]];
    
    // Color constraints
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[colorKeyboardToolBar(43)]-6-[color1(71)]-11-[color5(71)]-20-|"                                                                      options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[colorKeyboardToolBar(43)]-6-[color2(71)]-11-[color6(71)]-20-|"                                                                      options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[colorKeyboardToolBar(43)]-6-[color3(71)]-11-[color7(71)]-20-|"                                                                      options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[colorKeyboardToolBar(43)]-6-[color4(71)]-11-[color8(71)]-20-|"                                                                      options:0 metrics:nil views:viewsDictionary]];
    
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[colorKeyboardToolBar]|"                                                                      options:0 metrics:nil views:viewsDictionary]];
    
    // color buttons
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-3-[color1(71)]-10-[color2(71)]-10-[color3(71)]-10-[color4(71)]"                                                                      options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-3-[color5(71)]-10-[color6(71)]-10-[color7(71)]-10-[color8(71)]"                                                                      options:0 metrics:nil views:viewsDictionary]];
    //[super layoutSubviews];
}

- (void)setNavigationBar {
    
    postButton = [ComposeViewHelper getPostButton];
    [postButton addTarget:self action:@selector(postContent:) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:postButton];
//    self.navigationItem.rightBarButtonItem = rightBarButton;
    [self.view addSubview:postButton];
    postButton.enabled = NO;
    
    cancelButton = [ComposeViewHelper getCancelButton];
    [cancelButton addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelButton];
//    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:cancelButton];
//    self.navigationItem.leftBarButtonItem = leftBarButton;
//    
//    [[UINavigationBar appearance] setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    
    // character count label
//    characterCount = [ComposeViewHelper getCharacterCountLabel]; 
//    
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    [button addTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
//    [button setFrame:CGRectMake(0, 0, 40, 40)];
//    [button addSubview:characterCount];
//    
//    UIBarButtonItem *characterButton = [[UIBarButtonItem alloc]initWithCustomView:button];
// 
//    
//    self.navigationItem.rightBarButtonItems = @[[[UIBarButtonItem alloc]
//                                                 initWithTitle:@"Post"
//                                                 style:UIBarButtonItemStyleDone
//                                                 target:self
//                                                 action:@selector(postContent:)],
//                                                characterButton];
//
//
//    [self.navigationItem.rightBarButtonItems[0] setAccessibilityIdentifier:@"Add Picture"];
    
//    self.navigationItem.leftBarButtonItem =  [[UIBarButtonItem alloc]
//                                              initWithBarButtonSystemItem:UIBarButtonSystemItemStop
//                                              target:self
//                                              action:@selector(goBack:)];
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

#pragma mark - Bottom ToolBar Buttons
- (void)setToolBar {
    composeToolBar = [[UIToolbar alloc] init];
    
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
    [self.view addSubview:textButton];
    
    imageButton = [ComposeViewHelper getImageButton];
    [imageButton addTarget:self action:@selector(imageButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:imageButton];
    
    filterButton = [ComposeViewHelper getFilterButton];
    [filterButton addTarget:self action:@selector(filterButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
//    UIBarButtonItem *flexibleSpace =  [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    //    textBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(textButtonPressed:)];
//    textBarButton = [[UIBarButtonItem alloc] initWithCustomView:textButton];
//    imageBarButton = [[UIBarButtonItem alloc] initWithCustomView:imageButton];
//    filterBarButton = [[UIBarButtonItem alloc] initWithCustomView:filterButton];
    
//    NSArray *mainButtonItems = [NSArray arrayWithObjects:flexibleSpace, textBarButton, flexibleSpace, imageBarButton, flexibleSpace, nil];
//    [composeToolBar setItems:mainButtonItems];
//    [self.view addSubview:composeToolBar];
}

- (void)textButtonPressed:(id)sender {
    [self keyboardOptions];
    placeHolderLabel.hidden=YES;
     placeHolderLabel2.hidden=YES;
  //  deleteImage.hidden = NO;
}

- (void)imageButtonPressed:(id)sender {
    [self imageOptions];
  //  deleteImage.hidden = YES;
}

- (void)filterButtonPressed:(id)sender {
    [self filterOptions];
}

#pragma mark - Keyboard Toolbar Options
- (void)defaultToolBar{
    xButton = [ComposeViewHelper getXButton];
    [xButton addTarget:self action:@selector(cancelText:) forControlEvents:UIControlEventTouchUpInside];
    checkButton = [ComposeViewHelper getCheckButton];
    [checkButton addTarget:self action:@selector(confirmText:) forControlEvents:UIControlEventTouchUpInside];
    backgroundButton = [ComposeViewHelper getTextColorButton];
    [backgroundButton addTarget:self action:@selector(getTextColor:) forControlEvents:UIControlEventTouchUpInside];
    keyboardButton = [ComposeViewHelper getKeyboardButton];
    [keyboardButton addTarget:self action:@selector(keyboardButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    xBarButton = [[UIBarButtonItem alloc] initWithCustomView:xButton];
    checkBarButton = [[UIBarButtonItem alloc] initWithCustomView:checkButton];
    backgroundBarButton = [[UIBarButtonItem alloc] initWithCustomView:backgroundButton];
    keyboardBarButton = [[UIBarButtonItem alloc] initWithCustomView:keyboardButton];
    
    UIBarButtonItem *flexibleSpace =  [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    buttonItems = [NSArray arrayWithObjects:xBarButton, flexibleSpace, backgroundBarButton, flexibleSpace, keyboardBarButton, flexibleSpace, checkBarButton, nil];
    
}
- (void)addKeyboardToolBar{
    [self defaultToolBar];
    keyboardToolBar = [[UIToolbar alloc] init];
    keyboardToolBar.translucent = YES;
    // Make toolbar clear
    [keyboardToolBar setTranslatesAutoresizingMaskIntoConstraints:NO];
    [keyboardToolBar setBackgroundImage:[UIImage new]
                     forToolbarPosition:UIBarPositionAny
                             barMetrics:UIBarMetricsDefault];
    [keyboardToolBar setShadowImage:[UIImage new]
                 forToolbarPosition:UIToolbarPositionAny];
     keyboardToolBar.backgroundColor = [UIColor whiteColor];
     keyboardToolBar.tintColor = [[UIColor clearColor] colorWithAlphaComponent:0.6];
  
    [keyboardToolBar setItems:buttonItems];
}

- (void)keyboardOptions{
    //  composeTextView.backgroundColor = [UIColor redColor];
    [self addKeyboardToolBar];
    [composeTextView becomeFirstResponder];
}
- (void)addColorKeyboardToolBar{
    [self defaultToolBar];
    colorKeyboardToolBar = [[UIToolbar alloc] init];
    
    colorKeyboardToolBar.backgroundColor = [UIColor whiteColor];
   // colorKeyboardToolBar.tintColor = [UIColor orangeColor];
    colorKeyboardToolBar.translucent = YES;
    // Make toolbar clear
    [colorKeyboardToolBar setTranslatesAutoresizingMaskIntoConstraints:NO];
//    [colorKeyboardToolBar setBackgroundImage:[UIImage new]
//                          forToolbarPosition:UIBarPositionAny
//                                  barMetrics:UIBarMetricsDefault];
//    [colorKeyboardToolBar setShadowImage:[UIImage new]
//                      forToolbarPosition:UIToolbarPositionAny];
    [colorKeyboardToolBar setItems:buttonItems];
}
- (void)getTextColor:(id)sender {
    [composeTextView endEditing:YES];
    
    colorKeyboardToolBar.hidden = NO;
    color1.hidden = NO;
    color2.hidden = NO;
    color3.hidden = NO;
    color4.hidden = NO;
    color5.hidden = NO;
    color6.hidden = NO;
    color7.hidden = NO;
    color8.hidden = NO;
//    colorKeyboardToolBar.backgroundColor = [UIColor greenColor];
    textButton.hidden = YES;
    imageButton.hidden = YES;
}

- (void)keyboardButtonPressed:(id)sender{
    [self keyboardOptions];
    colorKeyboardToolBar.hidden = YES;
    color1.hidden = YES;
    color2.hidden = YES;
    color3.hidden = YES;
    color4.hidden = YES;
    color5.hidden = YES;
    color6.hidden = YES;
    color7.hidden = YES;
    color8.hidden = YES;
}

- (void)cancelText:(id)sender{
    colorKeyboardToolBar.hidden = YES;
    color1.hidden = YES;
    color2.hidden = YES;
    color3.hidden = YES;
    color4.hidden = YES;
    color5.hidden = YES;
    color6.hidden = YES;
    color7.hidden = YES;
    color8.hidden = YES;
    composeTextView.text = @"";
    [self disableKeyBoard];
    textButton.hidden = NO;
    imageButton.hidden = NO;
    if ((deleteImage.hidden)){
        postButton.enabled = NO;
    }
}

- (void)confirmText:(id)sender{
    colorKeyboardToolBar.hidden = YES;
    color1.hidden = YES;
    color2.hidden = YES;
    color3.hidden = YES;
    color4.hidden = YES;
    color5.hidden = YES;
    color6.hidden = YES;
    color7.hidden = YES;
    color8.hidden = YES;
    [self disableKeyBoard];
    textButton.hidden = NO;
    imageButton.hidden = NO;
}

#pragma mark - Color options
- (void)color1Pressed:(id)sender{
   // composeTextView.textColor = [UIColor whiteColor];
    NSDictionary *typingAttributes = @{
                                  NSFontAttributeName: [UIFont fontWithName:kAUCFontFamilySecondary size:kAUCFontSizeComposeText],
                                  NSForegroundColorAttributeName:[UIColor whiteColor],
                                  NSParagraphStyleAttributeName:paraStyle,
                                  NSStrokeColorAttributeName:[CommonUtility getColorFromHSBACVec:kAUTextStrokeColor],
                                  NSStrokeWidthAttributeName:@-4.0,
                                  NSKernAttributeName:@1.0
                                  };
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:composeTextView.text attributes:typingAttributes];
    composeTextView.attributedText = str;


}
- (void)color2Pressed:(id)sender{
    NSDictionary *typingAttributes = @{
                                       NSFontAttributeName: [UIFont fontWithName:kAUCFontFamilySecondary size:kAUCFontSizeComposeText],
                                       NSForegroundColorAttributeName:[CommonUtility getColorFromHSBACVec:kAUTextColor2],
                                       NSParagraphStyleAttributeName:paraStyle,
                                       NSStrokeWidthAttributeName:@0,
                                       NSKernAttributeName:@1.0
                                       };
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:composeTextView.text attributes:typingAttributes];
    composeTextView.attributedText = str;

}
- (void)color3Pressed:(id)sender{
    NSDictionary *typingAttributes = @{
                                       NSFontAttributeName: [UIFont fontWithName:kAUCFontFamilySecondary size:kAUCFontSizeComposeText],
                                       NSForegroundColorAttributeName:[CommonUtility getColorFromHSBACVec:kAUTextColor3],
                                       NSParagraphStyleAttributeName:paraStyle,
                                       NSStrokeWidthAttributeName:@0,
                                       NSKernAttributeName:@1.0
                                       };
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:composeTextView.text attributes:typingAttributes];
    composeTextView.attributedText = str;
}

- (void)color4Pressed:(id)sender{
    NSDictionary *typingAttributes = @{
                                       NSFontAttributeName: [UIFont fontWithName:kAUCFontFamilySecondary size:kAUCFontSizeComposeText],
                                       NSForegroundColorAttributeName:[CommonUtility getColorFromHSBACVec:kAUTextColor4],
                                       NSParagraphStyleAttributeName:paraStyle,
                                       NSStrokeWidthAttributeName:@0,
                                       NSKernAttributeName:@1.0
                                       };
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:composeTextView.text attributes:typingAttributes];
    composeTextView.attributedText = str;
}
- (void)color5Pressed:(id)sender{
    NSDictionary *typingAttributes = @{
                                       NSFontAttributeName: [UIFont fontWithName:kAUCFontFamilySecondary size:kAUCFontSizeComposeText],
                                       NSForegroundColorAttributeName:[CommonUtility getColorFromHSBACVec:kAUTextColor5],
                                       NSParagraphStyleAttributeName:paraStyle,
                                       NSStrokeWidthAttributeName:@0,
                                       NSKernAttributeName:@1.0
                                       };
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:composeTextView.text attributes:typingAttributes];
    composeTextView.attributedText = str;
}
- (void)color6Pressed:(id)sender{
    NSDictionary *typingAttributes = @{
                                       NSFontAttributeName: [UIFont fontWithName:kAUCFontFamilySecondary size:kAUCFontSizeComposeText],
                                       NSForegroundColorAttributeName:[CommonUtility getColorFromHSBACVec:kAUTextColor6],
                                       NSParagraphStyleAttributeName:paraStyle,
                                       NSStrokeWidthAttributeName:@0,
                                       NSKernAttributeName:@1.0
                                       };
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:composeTextView.text attributes:typingAttributes];
    composeTextView.attributedText = str;
}
- (void)color7Pressed:(id)sender{
    NSDictionary *typingAttributes = @{
                                       NSFontAttributeName: [UIFont fontWithName:kAUCFontFamilySecondary size:kAUCFontSizeComposeText],
                                       NSForegroundColorAttributeName:[CommonUtility getColorFromHSBACVec:kAUTextColor7],
                                       NSParagraphStyleAttributeName:paraStyle,
                                       NSStrokeWidthAttributeName:@0,
                                       NSKernAttributeName:@1.0
                                       };
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:composeTextView.text attributes:typingAttributes];
    composeTextView.attributedText = str;
}
- (void)color8Pressed:(id)sender{
    NSDictionary *typingAttributes = @{
                                       NSFontAttributeName: [UIFont fontWithName:kAUCFontFamilySecondary size:kAUCFontSizeComposeText],
                                       NSForegroundColorAttributeName:[CommonUtility getColorFromHSBACVec:kAUTextColor8],
                                       NSParagraphStyleAttributeName:paraStyle,
                                       NSStrokeColorAttributeName:[CommonUtility getColorFromHSBACVec:kAUTextStrokeColor],
                                       NSStrokeWidthAttributeName:@-4.0,
                                       NSKernAttributeName:@1.0
                                       };
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:composeTextView.text attributes:typingAttributes];
    composeTextView.attributedText = str;
}

#pragma mark - textview delegate methods
- (void)disableKeyBoard{
    // disable keyboard
    [composeTextView resignFirstResponder];
    //composeTextView.inputAccessoryView = nil;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
   // [composeTextView resignFirstResponder];
    [composeTextView setInputAccessoryView:keyboardToolBar];
    
   return YES;
}

- (void)textViewDidChange:(UITextView *)textView{

    textLength =[textView.text length];
    long charLeft = kAPIValidationContentMaxLength - [textView.text length];
//    NSString *substring = [NSString stringWithString:composeTextView];
    
    // place holder text
    if(( textLength == 0)&&(placeHolderLabel.isHidden)){
       // placeHolderLabel.hidden=NO;
        characterCount.text = [NSString stringWithFormat:@"%ld", charLeft];
    }
    else if((textLength> 0)&&(!placeHolderLabel.isHidden)){
        //placeHolderLabel.hidden=YES;
    }
      // Update remaining characters
    if (textLength >0){
        characterCount.text = [NSString stringWithFormat:@"%ld", charLeft];
    }
    
    textLength =[[CommonUtility  trimString:textView.text ] length];
    
    // post button
    if((textLength < kAPIValidationContentMinLength)) {//&&(postButton.isEnabled)){
        if (!(deleteImage.hidden)){
            postButton.enabled = YES;
        }
        else {
        postButton.enabled=NO; }
        }
    else if((textLength >= kAPIValidationContentMinLength)){//&&(!postButton.isEnabled)){
        postButton.enabled=YES;
        }
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    [self adjustFrames];
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
   [self adjustFrames];
    // return key
   if([text isEqualToString:@"\n"]) {
//        [self postContent:nil];
//       [composeTextView resignFirstResponder];
       
        return YES;
    }
    
    long totalLength = textView.text.length - range.length + text.length;
    
    if (totalLength>kAPIValidationContentMaxLength){
        return NO;
    }
    return YES;
}
-(void) adjustFrames
{
    CGRect textFrame = composeTextView.frame;
    textFrame.size.height = composeTextView.contentSize.height;
    composeTextView.frame = textFrame;
}
// Vertically center text
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    UITextView *tv = object;
    CGFloat topCorrect = ([tv bounds].size.height - [tv contentSize].height * [tv zoomScale])/2.0;
    topCorrect = ( topCorrect < 0.0 ? 0.0 : topCorrect );
    tv.contentOffset = (CGPoint){.x = 0, .y = -topCorrect};
}
#pragma mark - Image options
- (void)imageOptions{
    [self showPhotoOptions:self];
//    filterToolBar = [[UIToolbar alloc] init];
//    [filterToolBar setTranslatesAutoresizingMaskIntoConstraints:NO];
//    filterToolBar.backgroundColor = [UIColor redColor];
//    
//    keyboardToolBar = [[UIToolbar alloc] init];
//    [keyboardToolBar setTranslatesAutoresizingMaskIntoConstraints:NO];
//    
//    [self.view addSubview:keyboardToolBar];
//    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(keyboardToolBar);
//    
//    // like Button
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[keyboardToolBar(100)]-50-|"                                                                      options:0 metrics:nil views:viewsDictionary]];
//    
//    // Comment label
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[keyboardToolBar]-5-|"                                                                      options:0 metrics:nil views:viewsDictionary]];
    
}

#pragma mark - Google Image Search
//- (void)imageSearch{
//    NSString * yourImageURL = 0;//...//;
//    NSString *searchURL = @"https://www.google.com/searchbyimage?&image_url=";
//    NSString * completeURL = [NSString stringWithFormat:@"%@%@", searchURL, yourImageURL];
//}

#pragma mark - Filter options
- (void)filterOptions{
    
}

#pragma mark - Gesture recognizes
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGesture {
//    return YES;
//}
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}
- (void)addGesture{
    //   Add swipe gesture
    
    panRecognized = [[UIPanGestureRecognizer alloc]
                     initWithTarget:self
                     action:@selector(panRecognized:)];
    
    touchRecognized = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchRecognized:)];
    [touchRecognized setNumberOfTapsRequired:1];
    
    
    [panRecognized setMinimumNumberOfTouches:1];
    [panRecognized setMaximumNumberOfTouches:1];
    [composeTextView setGestureRecognizers:nil];
 //   composeTextView.gestureRecognizers = nil;
    [composeTextView setMultipleTouchEnabled:YES];
    [composeTextView setUserInteractionEnabled:YES];
    [contentImageView setUserInteractionEnabled:YES];
    
   // [contentImageView addGestureRecognizer:panRecognized];
   // [[self view] addGestureRecognizer:panRecognized];
    [composeTextView addGestureRecognizer:panRecognized];
    [composeTextView addGestureRecognizer:touchRecognized];
}
- (void)touchRecognized:(UITapGestureRecognizer *)sender{
    [self textButtonPressed:self];
}
- (void)panRecognized:(UIPanGestureRecognizer *)sender
{
//    CGPoint touchLocation = [panRecognized locationInView:self.view];
//    composeTextView.center = touchLocation;
    if (sender.state == UIGestureRecognizerStateBegan) {
    }
   
   // CGPoint translatedPoint = [(UIPanGestureRecognizer*)sender translationInView:composeTextView];
   // translatedPoint = CGPointMake(translatedPoint.x, translatedPoint.y);
    
    if (UIGestureRecognizerStateChanged == sender.state) {
        // Use translation offset
        CGPoint translation = [sender translationInView:composeTextView];
        [self moveTextWithWithContraints:translation];
        // Clear translation
        [sender setTranslation:CGPointZero inView:sender.view];
        [sender cancelsTouchesInView];
    }
}
- (void)moveTextWithWithContraints:(CGPoint)translation{
  
    double pointX =composeTextView.center.x + translation.x;
    double pointY =composeTextView.center.y + translation.y;
    
    pointX = fmax(contentImageView.bounds.origin.x, pointX);
    pointX = fmin(contentImageView.bounds.origin.x+contentImageView.frame.size.width, pointX);
    pointY = fmax(contentImageView.bounds.origin.y, pointY);
    pointY = fmin(contentImageView.bounds.origin.y+contentImageView.frame.size.height, pointY);

    composeTextView.center = CGPointMake(pointX,pointY);
}
#pragma mark - Button Action Methods
- (void)postContent:(id)sender {
    
    
    [self captureContentImage];
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
 //   DBLog(@"%f", contentImageView.image.size.width);
    // post content user
    [activityIndicator startAnimating];
    [[ApiManager sharedApiManager] postContentWithCategoryId:(int)ci.categoryId.integerValue
                                                        text:ci.contentText
                                                       photo:finalContentImage//contentImageView.image
                                                     success:^(ApiContent * content){
                                                         [activityIndicator stopAnimating];
                                                         [self actionsForSuccessfulPostContent];
                                                     }failure:^(NSError * error){
                                                         // Analytics: Flurry
                                                         [Flurry logEvent:[FlurryManager getEventName:kFAComposePostFailure] withParameters:@{@"Error":error}];
                                                         [activityIndicator stopAnimating];
                                                         //[ApiErrorManager displayAlertWithError:error withDelegate:self];
                                                             [self displayCustomAlertWithImageFile:kAUCPostFailureImage];
                                                         postButton.enabled = YES;
                                                     }];
    
}

- (void)addPicture:(id)sender {
    
}


#pragma mark - Api Manager Post actions methods
- (void)actionsForSuccessfulPostContent{
    // Analytics: Flurry
    [Flurry logEvent:[FlurryManager getEventName:kFAComposePostSuccess]];
    //clear contentj    [self clearViewAfterSuccessfulPostOrCancel];
    
    // Go back after successful post
    [self.navigationController popViewControllerAnimated:NO];
//    [ContentViewController self.view];
    //[ContentViewController setView];
    // display sucess
    //[CommonUtility displayAlertWithTitle:@"Post Successful"
    //                           message:@"Your content was posted sucessfully!" delegate:self];
    
    [self displayCustomAlertWithImageFile:kAUCPostSuccessImage];
//    successAlertView = [[CustomIOS7AlertView alloc] init];
//    UIImage *image = [UIImage imageNamed:kAUCPostSuccessImage];
//    UIImageView *successImage = [[UIImageView alloc] initWithImage:image];
//    [successAlertView setContainerView:successImage];
////    UIAlertView *alertView  = [[UIAlertView alloc] initWithTitle:@"Post Successful"
////                                                          message:@""
////                                                         delegate:self
////                                                cancelButtonTitle:nil
////                                                otherButtonTitles:nil];
//    
//    [successAlertView show];
//    
//    // dismiss autometically
//    [self performSelector:@selector(dismissAlertView:) withObject:successAlertView afterDelay:1.0];
    
}
- (void)displayCustomAlertWithImageFile:(NSString *)fileName{
    if(successAlertView==nil){
    successAlertView = [[CustomIOS7AlertView alloc] init];
    }
    UIImage *image = [UIImage imageNamed:fileName];
    UIImageView *successImage = [[UIImageView alloc] initWithImage:image];
    [successAlertView setContainerView:nil];
    [successAlertView setContainerView:successImage];
    //    UIAlertView *alertView  = [[UIAlertView alloc] initWithTitle:@"Post Successful"
    //                                                          message:@""
    //                                                         delegate:self
    //                                                cancelButtonTitle:nil
    //                                                otherButtonTitles:nil];
    
    [successAlertView show];
    
    // dismiss autometically
    [self performSelector:@selector(dismissAlertView:) withObject:successAlertView afterDelay:1.0];
}
-(void)dismissAlertView:(UIAlertView *)alertView{
   // [alertView dismissWithClickedButtonIndex:0 animated:YES];
    [successAlertView close];
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
- (void)removeImage:(id)sender {
    contentImageView.image = nil;
    deleteImage.hidden = YES;
    if (textLength==0) {
    postButton.enabled = NO;
    }
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
    deleteImage.hidden = NO;
//    postButton.enabled = YES;
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
    deleteImage.hidden = NO;
}


#pragma mark -  Image Processing Manager Delegate methods
- (void)captureContentImage{
    [self disableKeyBoard];
    finalContentImage = [CommonUtility getImageFromView:contentImageView];
    placeHolderLabel.hidden = YES;
    placeHolderLabel2.hidden = YES;
}
- (void)photoCaptureCancelled {
    deleteImage.hidden = YES;
    //[self photoDialogCancelAction];
   // postButton.enabled = NO;
}
- (void)photoCaptureDoneWithImage:(UIImage *)image {
    // set image view
    [self cropImageToSquare:image];
    contentImageView.image = image;
//    postButton.enabled = YES;
    placeHolderLabel.hidden = YES;
    placeHolderLabel2.hidden = YES;
}
- (void)cropImageToSquare:(UIImage *)image{
    CGSize imageSize = image.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    if (width != height) {
        CGFloat newDimension = MIN(width, height);
        CGFloat widthOffset = (width - newDimension) / 2;
        CGFloat heightOffset = (height - newDimension) / 2;
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(newDimension, newDimension), NO, 0.);
        [image drawAtPoint:CGPointMake(-widthOffset, -heightOffset)
                 blendMode:kCGBlendModeCopy
                     alpha:1.];
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
}
@end
