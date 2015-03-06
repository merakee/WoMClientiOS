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
#import "AppDelegate.h"
@implementation ComposeViewController
long  textLength;
int   doneCounter;
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
 //   [self createInputAccessoryView];

    // set view
    [ComposeViewHelper setView:self.view];

    doneButton = [ComposeViewHelper getDoneButton];
    [doneButton addTarget:self action:@selector(doneButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:doneButton];

    postButton = [ComposeViewHelper getPostButton];
    [postButton addTarget:self action:@selector(postContent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:postButton];
    postButton.hidden = YES;
    postButton.enabled = NO;
    
    cancelButton = [ComposeViewHelper getCancelButton];
    [cancelButton addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelButton];

    // image view
    contentImageView = [ComposeViewHelper getContentImageView];
   [self.view addSubview:contentImageView];
    
    defaultContentImage = [ComposeViewHelper getContentImageView];
    // set Category control
    //    categoryControl = [ComposeViewHelper getCategoryControl];
    //    [categoryControl addTarget:self action:@selector(selectedCategoryChanged:) forControlEvents:UIControlEventValueChanged];
    //    [self.view addSubview:categoryControl];
    
    // set TextView
    composeTextView = [ComposeViewHelper getComposeTextViewWithDelegate:self];
    [contentImageView addSubview:composeTextView];
    //composeTextView.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    //[composeTextView addObserver:self forKeyPath:@"contentSize" options:(NSKeyValueObservingOptionNew) context:NULL];
    
    // place holder label
 //   composeTextView.backgroundColor = [UIColor redColor];
    placeHolderLabel = [ComposeViewHelper getPlaceHolderLabel];
    [composeTextView addSubview:placeHolderLabel];
     contentImageView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:kAUCComposeBackgroundImage]];
    
    // buttons
    cameraOptionsButton = [ComposeViewHelper getCameraOptionsButton];
    [cameraOptionsButton addTarget:self action:@selector(showPhotoOptions:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cameraOptionsButton];
    
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
    
    borderLine = [[UIView alloc] init];
    borderLine.backgroundColor = [CommonUtility getColorFromHSBACVec:kAUCBorderColor];
    [borderLine setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:borderLine];
    // Set default toolbar
    //[self defaultToolBar];
//    [self addColorKeyboardToolBar];
//    [self.view addSubview:colorKeyboardToolBar];
    
    doneCounter = 0;
    // layout
    [self layoutView];
    
    [self addGesture];
    
    // Display keyboard at startup
    [self keyboardOptions];
    
    // scroll adjustment
    //self.automaticallyAdjustsScrollViewInsets = NO;
}
- (void)layoutView{
    // all view elements
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(contentImageView, composeTextView,placeHolderLabel, textButton, imageButton, filterButton, postButton, doneButton, cancelButton, cameraOptionsButton, borderLine);
    
    // buttons
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[cancelButton(44)]"                                                                      options:0 metrics:nil views:viewsDictionary]];
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-15-[cancelButton(33)]"                                                                      options:0 metrics:nil views:viewsDictionary]];
    
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[postButton(44)]|"                                                                      options:0 metrics:nil views:viewsDictionary]];
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-15-[postButton(44)]"                                                                      options:0 metrics:nil views:viewsDictionary]];
 
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[postButton(107)]"
//                                                                      options:0 metrics:nil views:viewsDictionary]];
//    [AppUIManager horizontallyCenterElement:postButton inView:self.view];
//    [self.view addConstraints:              [NSLayoutConstraint constraintsWithVisualFormat:@"V:[postButton(66)]-214-|"
//                                                                                    options:0 metrics:nil views:viewsDictionary]];
    
    [contentImageView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-30-[composeTextView(340)]"
                                                                      options:0 metrics:nil views:viewsDictionary]];
    
    //[AppUIManager verticallyCenterElement:composeTextView inView:contentImageView];

    [contentImageView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-24-[composeTextView]-24-|"
                                                                      options:0 metrics:nil views:viewsDictionary]];
    // Navigation toolbar setup
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[postButton(76)]-10-|"
                                                                      options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[doneButton(76)]-10-|"
                                                                      options:0 metrics:nil views:viewsDictionary]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[cancelButton(40)]"
                                                                      options:0 metrics:nil views:viewsDictionary]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[cameraOptionsButton(32)]"
                                                                      options:0 metrics:nil views:viewsDictionary]];
    [AppUIManager horizontallyCenterElement:cameraOptionsButton inView:self.view];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[doneButton(44)]-5-[contentImageView]-126-|"
                                                                      options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[postButton(44)]-5-[contentImageView]"
                                                                      options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[cancelButton(44)]-5-[contentImageView]"
                                                                      options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[cameraOptionsButton(44)]-5-[contentImageView]"
                                                                      options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[contentImageView]|"
                                                                      options:0 metrics:nil views:viewsDictionary]];
    
    
    // content image view height
//    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:contentImageView
//                                                      attribute:NSLayoutAttributeHeight
//                                                      relatedBy:NSLayoutRelationEqual
//                                                         toItem:contentImageView
//                                                      attribute:NSLayoutAttributeWidth
//                                                     multiplier:1.0
//                                                       constant:0.0]];
    

    // place holder label
    [composeTextView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[placeHolderLabel(240)]"
                                                                      options:0 metrics:nil views:viewsDictionary]];
    [composeTextView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[placeHolderLabel]|"
                                                                      options:0 metrics:nil views:viewsDictionary]];
    [AppUIManager horizontallyCenterElement:placeHolderLabel inView:composeTextView];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[imageButton(66)]-43-[filterButton(66)]-43-[textButton(66)]"
                                                                      options:0 metrics:nil views:viewsDictionary]];
    [AppUIManager horizontallyCenterElement:filterButton inView:self.view];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[borderLine]|"
                                                                      options:0 metrics:nil views:viewsDictionary]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[borderLine(5)]-25-[textButton(66)]-30-|"
                                                                                    options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[imageButton(66)]-30-|"
                                                                      options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[filterButton(66)]-30-|"
                                                                      options:0 metrics:nil views:viewsDictionary]];
    //[super layoutSubviews];
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
    composeToolBar.translucent = YES;
    
    // Make toolbar clear
    [composeToolBar setTranslatesAutoresizingMaskIntoConstraints:NO];
    [composeToolBar setBackgroundImage:[UIImage new]
                    forToolbarPosition:UIBarPositionAny
                            barMetrics:UIBarMetricsDefault];
    [composeToolBar setShadowImage:[UIImage new]
                forToolbarPosition:UIToolbarPositionAny];
    
    textButton = (RoundRobinButton *)[ComposeViewHelper getTextButton];
    textButton.delegate = self;
    textButton.actionList = @[@"textStyle1", @"textStyle2", @"textStyle3", @"textStyle4", @"textStyle5"];
    [self.view addSubview:textButton];
    imageButton = (RoundRobinButton *)[ComposeViewHelper getImageButton];
    imageButton.delegate = self;
    imageButton.actionList = @[@"backgroundImage1", @"backgroundImage2", @"backgroundImage3", @"backgroundImage4", @"backgroundImage5", @"backgroundImage6", @"backgroundImage7", @"backgroundImage8"];
   [self.view addSubview:imageButton];
    
    filterButton = (RoundRobinButton *)[ComposeViewHelper getFilterButton];
    filterButton.delegate = self;
    filterButton.actionList = @[@"filter1", @"filter2", @"filter3", @"filter4", @"filter5", @"filter6", @"filter7", @"filter8", @"noFilter"];
    [self.view addSubview:filterButton];
}
#pragma mark - Text Button Actions
- (void)textStyle1{
    if (textLength == 0)
    {
        return;
    }
    NSShadow *shadow = [NSShadow new];
    [shadow setShadowColor:[CommonUtility getColorFromHSBACVec:kAUShadowColor1]];
    [shadow setShadowOffset: CGSizeMake(0.0f, 1.0f)];
    NSDictionary *typingAttributes = @{
                                       NSFontAttributeName: [UIFont fontWithName:kAUCFontFamilySecondary size:kAUCFontSizeComposeText],
                                       NSForegroundColorAttributeName:[CommonUtility getColorFromHSBACVec:kAUTextColor1],
                                       NSParagraphStyleAttributeName:paraStyle,
                                       NSKernAttributeName:@1.0,
                                       NSShadowAttributeName:shadow
                                       };
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:composeTextView.text attributes:typingAttributes];
    composeTextView.attributedText = str;
}
- (void)textStyle2{
    if (textLength == 0)
    {
        return;
    }
    NSShadow *shadow = [NSShadow new];
    [shadow setShadowColor:[CommonUtility getColorFromHSBACVec:kAUShadowColor1]];
    [shadow setShadowOffset: CGSizeMake(0.0f, 1.0f)];
    NSDictionary *typingAttributes = @{
                                       NSFontAttributeName: [UIFont fontWithName:kAUCFontFamilySecondary size:kAUCFontSizeComposeText],
                                       NSForegroundColorAttributeName:[UIColor whiteColor],
                                       NSParagraphStyleAttributeName:paraStyle,
                                       NSKernAttributeName:@1.0,
                                       NSShadowAttributeName:shadow
                                       };
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:composeTextView.text attributes:typingAttributes];
    composeTextView.attributedText = str;
     [composeTextView setBackgroundColor:[CommonUtility getColorFromHSBACVec:kAUTextFieldColor]];
    [composeTextView.layer setCornerRadius:10.0f];
    composeTextView.alpha = 0.8;
}
- (void)textStyle3{
    if (textLength == 0)
    {
        return;
    }
    NSDictionary *typingAttributes = @{
                                       NSFontAttributeName: [UIFont fontWithName:kAUCFontFamilySecondary size:kAUCFontSizeComposeText],
                                       NSForegroundColorAttributeName:[CommonUtility getColorFromHSBACVec:kAUTextColor3],
                                       NSParagraphStyleAttributeName:paraStyle,
                                       NSKernAttributeName:@1.0,
                                       };
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:composeTextView.text attributes:typingAttributes];
    composeTextView.attributedText = str;
    [composeTextView setBackgroundColor:[UIColor whiteColor]];
    [composeTextView.layer setCornerRadius:0.0f];
    composeTextView.alpha = 0.8;
}
- (void)textStyle4{
    if (textLength == 0)
    {
        return;
    }
    NSShadow *shadow = [NSShadow new];
    [shadow setShadowColor:[CommonUtility getColorFromHSBACVec:kAUShadowColorDefault]];
    [shadow setShadowOffset: CGSizeMake(0.0f, 1.0f)];
    NSDictionary *typingAttributes = @{
                                       NSFontAttributeName: [UIFont fontWithName:kAUCFontFamilySecondary size:kAUCFontSizeComposeText],
                                       NSForegroundColorAttributeName:[UIColor whiteColor],
                                       NSParagraphStyleAttributeName:paraStyle,
                                       NSShadowAttributeName:shadow,
                                       NSKernAttributeName:@1.0
                                       };
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:composeTextView.text attributes:typingAttributes];
    composeTextView.attributedText = str;
}
- (void)textStyle5{
    if (textLength == 0)
    {
        return;
    }
    NSShadow *shadow = [NSShadow new];
    [shadow setShadowColor:[CommonUtility getColorFromHSBACVec:kAUShadowColor1]];
    [shadow setShadowOffset: CGSizeMake(0.0f, 1.0f)];
    NSDictionary *typingAttributes = @{
                                       NSFontAttributeName: [UIFont fontWithName:kAUCFontFamilySecondary size:kAUCFontSizeComposeText],
                                       NSForegroundColorAttributeName:[CommonUtility getColorFromHSBACVec:kAUTextColor4],
                                       NSParagraphStyleAttributeName:paraStyle,
                                       NSKernAttributeName:@1.0,
                                       NSShadowAttributeName:shadow
                                       };
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:composeTextView.text attributes:typingAttributes];
    composeTextView.attributedText = str;
    [composeTextView setBackgroundColor:[UIColor clearColor]];
    composeTextView.alpha = 1.0;
}
#pragma mark - Image Button options
- (void)backgroundImage1{
    contentImageView.backgroundColor = [CommonUtility getColorFromHSBACVec:kAUBackgroundColor1];
}
- (void)backgroundImage2{
    contentImageView.backgroundColor = [CommonUtility getColorFromHSBACVec:kAUBackgroundColor2];
}
- (void)backgroundImage3{
    contentImageView.backgroundColor = [CommonUtility getColorFromHSBACVec:kAUBackgroundColor3];
}
- (void)backgroundImage4{
    contentImageView.backgroundColor = [CommonUtility getColorFromHSBACVec:kAUBackgroundColor4];
}
- (void)backgroundImage5{
    contentImageView.backgroundColor = [CommonUtility getColorFromHSBACVec:kAUBackgroundColor5];
}
- (void)backgroundImage6{
    contentImageView.backgroundColor = [CommonUtility getColorFromHSBACVec:kAUBackgroundColor6];
}
- (void)backgroundImage7{
    contentImageView.backgroundColor = [CommonUtility getColorFromHSBACVec:kAUBackgroundColor7];
}
- (void)backgroundImage8{
    contentImageView.backgroundColor = [CommonUtility getColorFromHSBACVec:kAUBackgroundColor8];
}
#pragma mark - Filter Button options
- (void)filter1{
    if (contentImageView.image == nil)
    {
        return;
    }
   //  NSLog(@"color monochrome");
    imageFilter = [CIFilter filterWithName:@"CIColorMonochrome"];
    [imageFilter setDefaults];
    [imageFilter setValue:[CIImage imageWithCGImage:[defaultContentImage.image CGImage]] forKey:kCIInputImageKey];
    outputImage = [imageFilter outputImage];
    context   = [CIContext contextWithOptions:nil];
    CGRect rect          = [outputImage extent];
    rect.origin.x        += (rect.size.width  - contentImageView.image.size.width ) / 2;
    rect.origin.y        += (rect.size.height - contentImageView.image.size.height) / 2;
    rect.size            = contentImageView.image.size;
    CGImageRef cgimg     = [context createCGImage:outputImage fromRect:rect];
    imageWithFilter      = [UIImage imageWithCGImage:cgimg];
    contentImageView.image = imageWithFilter;
}
- (void)filter2{
    if (contentImageView.image == nil)
    {
        return;
    }
  //  NSLog(@"photo effect instant");
    imageFilter = [CIFilter filterWithName:@"CIPhotoEffectInstant"];
    [imageFilter setDefaults];
    [imageFilter setValue:[CIImage imageWithCGImage:[defaultContentImage.image CGImage]] forKey:kCIInputImageKey];
    outputImage = [imageFilter outputImage];
    context   = [CIContext contextWithOptions:nil];
    CGRect rect          = [outputImage extent];
    rect.origin.x        += (rect.size.width  - contentImageView.image.size.width ) / 2;
    rect.origin.y        += (rect.size.height - contentImageView.image.size.height) / 2;
    rect.size            = contentImageView.image.size;
    CGImageRef cgimg     = [context createCGImage:outputImage fromRect:rect];
    imageWithFilter      = [UIImage imageWithCGImage:cgimg];
    contentImageView.image = imageWithFilter;
}
- (void)filter3{
    if (contentImageView.image == nil)
    {
        return;
    }
  //  NSLog(@"color cube");
    imageFilter = [CIFilter filterWithName:@"CIColorCube"];
    [imageFilter setDefaults];
    [imageFilter setValue:[CIImage imageWithCGImage:[defaultContentImage.image CGImage]] forKey:kCIInputImageKey];
    outputImage = [imageFilter outputImage];
    context   = [CIContext contextWithOptions:nil];
    CGRect rect          = [outputImage extent];
    rect.origin.x        += (rect.size.width  - contentImageView.image.size.width ) / 2;
    rect.origin.y        += (rect.size.height - contentImageView.image.size.height) / 2;
    rect.size            = contentImageView.image.size;
    CGImageRef cgimg     = [context createCGImage:outputImage fromRect:rect];
    imageWithFilter      = [UIImage imageWithCGImage:cgimg];
    contentImageView.image = imageWithFilter;
}
- (void)filter4{
    if (contentImageView.image == nil)
    {
        return;
    }
  //  NSLog(@"photo effect mono");
    imageFilter = [CIFilter filterWithName:@"CIPhotoEffectMono"];
    [imageFilter setDefaults];
    [imageFilter setValue:[CIImage imageWithCGImage:[defaultContentImage.image CGImage]] forKey:kCIInputImageKey];
    outputImage = [imageFilter outputImage];
    context   = [CIContext contextWithOptions:nil];
    CGRect rect          = [outputImage extent];
    rect.origin.x        += (rect.size.width  - contentImageView.image.size.width ) / 2;
    rect.origin.y        += (rect.size.height - contentImageView.image.size.height) / 2;
    rect.size            = contentImageView.image.size;
    CGImageRef cgimg     = [context createCGImage:outputImage fromRect:rect];
    imageWithFilter      = [UIImage imageWithCGImage:cgimg];
    contentImageView.image = imageWithFilter;
}
- (void)filter5{
    if (contentImageView.image == nil)
    {
        return;
    }
  //  NSLog(@"photo effect fade");
    imageFilter = [CIFilter filterWithName:@"CIPhotoEffectFade"];
    [imageFilter setDefaults];
    [imageFilter setValue:[CIImage imageWithCGImage:[defaultContentImage.image CGImage]] forKey:kCIInputImageKey];
    outputImage = [imageFilter outputImage];
    context   = [CIContext contextWithOptions:nil];
    CGRect rect          = [outputImage extent];
    rect.origin.x        += (rect.size.width  - contentImageView.image.size.width ) / 2;
    rect.origin.y        += (rect.size.height - contentImageView.image.size.height) / 2;
    rect.size            = contentImageView.image.size;
    CGImageRef cgimg     = [context createCGImage:outputImage fromRect:rect];
    imageWithFilter      = [UIImage imageWithCGImage:cgimg];
    contentImageView.image = imageWithFilter;
}
- (void)filter6{
    if (contentImageView.image == nil)
    {
        return;
    }
  //  NSLog(@"bloom");
    imageFilter = [CIFilter filterWithName:@"CIBloom"];
    [imageFilter setDefaults];
    [imageFilter setValue:[CIImage imageWithCGImage:[defaultContentImage.image CGImage]] forKey:kCIInputImageKey];
    outputImage = [imageFilter outputImage];
    context   = [CIContext contextWithOptions:nil];
    CGRect rect          = [outputImage extent];
    rect.origin.x        += (rect.size.width  - contentImageView.image.size.width ) / 2;
    rect.origin.y        += (rect.size.height - contentImageView.image.size.height) / 2;
    rect.size            = contentImageView.image.size;
    CGImageRef cgimg     = [context createCGImage:outputImage fromRect:rect];
    imageWithFilter      = [UIImage imageWithCGImage:cgimg];
    contentImageView.image = imageWithFilter;
}
- (void)filter7{
    if (contentImageView.image == nil)
    {
        return;
    }
 //   NSLog(@"color matrix");
    imageFilter = [CIFilter filterWithName:@"CIColorMatrix"];
    [imageFilter setDefaults];
    [imageFilter setValue:[CIImage imageWithCGImage:[defaultContentImage.image CGImage]] forKey:kCIInputImageKey];
    [imageFilter setValue:[CIVector vectorWithX:1 Y:1 Z:1 W:0] forKey:@"inputRVector"];
    [imageFilter setValue:[CIVector vectorWithX:0 Y:1 Z:0 W:0] forKey:@"inputGVector"];
    [imageFilter setValue:[CIVector vectorWithX:0 Y:0 Z:1 W:0] forKey:@"inputBVector"];
    [imageFilter setValue:[CIVector vectorWithX:0 Y:0 Z:0 W:1] forKey:@"inputAVector"];
    outputImage = [imageFilter outputImage];
    context   = [CIContext contextWithOptions:nil];
    CGRect rect          = [outputImage extent];
    rect.origin.x        += (rect.size.width  - contentImageView.image.size.width ) / 2;
    rect.origin.y        += (rect.size.height - contentImageView.image.size.height) / 2;
    rect.size            = contentImageView.image.size;
    CGImageRef cgimg     = [context createCGImage:outputImage fromRect:rect];
    imageWithFilter      = [UIImage imageWithCGImage:cgimg];
    contentImageView.image = imageWithFilter;
}
- (void)filter8{
    if (contentImageView.image == nil)
    {
        return;
    }
  //  NSLog(@"tone curve");
    imageFilter = [CIFilter filterWithName:@"CIToneCurve"];
    [imageFilter setDefaults];
    [imageFilter setValue:[CIImage imageWithCGImage:[defaultContentImage.image CGImage]] forKey:kCIInputImageKey];
    [imageFilter setValue:[CIVector vectorWithX:0.0  Y:0.0] forKey:@"inputPoint0"]; // default
    [imageFilter setValue:[CIVector vectorWithX:0.27 Y:0.26] forKey:@"inputPoint1"];
    [imageFilter setValue:[CIVector vectorWithX:0.5  Y:0.80] forKey:@"inputPoint2"];
    [imageFilter setValue:[CIVector vectorWithX:0.7  Y:1.0] forKey:@"inputPoint3"];
    [imageFilter setValue:[CIVector vectorWithX:1.0  Y:1.0] forKey:@"inputPoint4"];
    outputImage = [imageFilter outputImage];
    context   = [CIContext contextWithOptions:nil];
    CGRect rect          = [outputImage extent];
    rect.origin.x        += (rect.size.width  - contentImageView.image.size.width ) / 2;
    rect.origin.y        += (rect.size.height - contentImageView.image.size.height) / 2;
    rect.size            = contentImageView.image.size;
    CGImageRef cgimg     = [context createCGImage:outputImage fromRect:rect];
    imageWithFilter      = [UIImage imageWithCGImage:cgimg];
    contentImageView.image = imageWithFilter;
}
- (void)noFilter{
    if (contentImageView.image == nil)
    {
        return;
    }
  //   NSLog(@"default image");
    contentImageView.image = defaultContentImage.image;
}

#pragma mark - Keyboard Toolbar Options
//- (void)defaultToolBar{
//    xButton = [ComposeViewHelper getXButton];
//    [xButton addTarget:self action:@selector(cancelText:) forControlEvents:UIControlEventTouchUpInside];
//    checkButton = [ComposeViewHelper getCheckButton];
//    [checkButton addTarget:self action:@selector(confirmText:) forControlEvents:UIControlEventTouchUpInside];
//    backgroundButton = [ComposeViewHelper getTextColorButton];
//    [backgroundButton addTarget:self action:@selector(getTextColor:) forControlEvents:UIControlEventTouchUpInside];
//    keyboardButton = [ComposeViewHelper getKeyboardButton];
//    [keyboardButton addTarget:self action:@selector(keyboardButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
//    
//    xBarButton = [[UIBarButtonItem alloc] initWithCustomView:xButton];
//    checkBarButton = [[UIBarButtonItem alloc] initWithCustomView:checkButton];
//    backgroundBarButton = [[UIBarButtonItem alloc] initWithCustomView:backgroundButton];
//    keyboardBarButton = [[UIBarButtonItem alloc] initWithCustomView:keyboardButton];
//    
//    UIBarButtonItem *flexibleSpace =  [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
//    buttonItems = [NSArray arrayWithObjects:xBarButton, flexibleSpace, backgroundBarButton, flexibleSpace, keyboardBarButton, flexibleSpace, checkBarButton, nil];
//}
//- (void)addKeyboardToolBar{
//    [self defaultToolBar];
//    keyboardToolBar = [[UIToolbar alloc] init];
//    keyboardToolBar.translucent = YES;
//    // Make toolbar clear
//    [keyboardToolBar setTranslatesAutoresizingMaskIntoConstraints:NO];
//    [keyboardToolBar setBackgroundImage:[UIImage new]
//                     forToolbarPosition:UIBarPositionAny
//                             barMetrics:UIBarMetricsDefault];
//    [keyboardToolBar setShadowImage:[UIImage new]
//                 forToolbarPosition:UIToolbarPositionAny];
//     keyboardToolBar.backgroundColor = [UIColor whiteColor];
//     keyboardToolBar.tintColor = [[UIColor clearColor] colorWithAlphaComponent:0.6];
//  
//    [keyboardToolBar setItems:buttonItems];
//}
//- (void)addColorKeyboardToolBar{
//    [self defaultToolBar];
//    colorKeyboardToolBar = [[UIToolbar alloc] init];
//    
//    colorKeyboardToolBar.backgroundColor = [UIColor whiteColor];
//    colorKeyboardToolBar.translucent = YES;
//    // Make toolbar clear
//    [colorKeyboardToolBar setTranslatesAutoresizingMaskIntoConstraints:NO];
////    [colorKeyboardToolBar setBackgroundImage:[UIImage new]
////                          forToolbarPosition:UIBarPositionAny
////                                  barMetrics:UIBarMetricsDefault];
////    [colorKeyboardToolBar setShadowImage:[UIImage new]
////                      forToolbarPosition:UIToolbarPositionAny];
//    [colorKeyboardToolBar setItems:buttonItems];
//}

#pragma mark - textview delegate methods
- (void)disableKeyBoard{
    // disable keyboard
    [composeTextView resignFirstResponder];
    //composeTextView.inputAccessoryView = nil;
}
- (void)keyboardOptions{
    
    [composeTextView becomeFirstResponder];
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
   // [composeTextView resignFirstResponder];
    [composeTextView setInputAccessoryView:keyboardToolBar];
    doneButton.hidden = NO;
    postButton.hidden = YES;
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
    if((textLength < kAPIValidationContentMinLength && contentImageView.image == nil)) {//&&(postButton.isEnabled)){
        postButton.enabled=NO;
        }
    else if((textLength >= kAPIValidationContentMinLength)){//&&(!postButton.isEnabled)){
        postButton.enabled=YES;
        }
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (textLength == 0){
        return;
    }
    [self adjustFrames];
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    placeHolderLabel.hidden=YES;
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
-(void)adjustFrames
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
  //  [self imageSearch];
    [self showPhotoOptions:self];
    
//    filterToolBar = [[UIToolbar alloc] init];
//    [filterToolBar setTranslatesAutoresizingMaskIntoConstraints:NO];
    filterToolBar.backgroundColor = [UIColor redColor];
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
- (void)imageSearch{
//    NSString *yourImageURL = 0;//...//;
//    NSString *searchURL = @"https://www.google.com/searchbyimage?&image_url=";
//    NSString *completeURL = [NSString stringWithFormat:@"%@%@", searchURL, yourImageURL];
    searchTextField.text = [NSString stringWithFormat:@"rabbit"];
 //   NSLog(@"%@", searchTextField.text);
  //  NSString *searchString = searchTextField.text;
    NSString *searchString = @"rabbit";
    NSLog(@"%@", searchString);
    NSString *URLAddress = [NSString stringWithFormat:@"https://www.google.nl/search?tbm=isch&q=%@", searchString];
    
    
    
   // imageSearchView = [[ImageSearchViewController alloc] init];
    imageSearchView = [[UIImageView alloc] init];
    [self.view addSubview:imageSearchView];
    [imageSearchView setTranslatesAutoresizingMaskIntoConstraints:NO];
 //   imageSearchView.backgroundColor = [UIColor redColor];
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(imageSearchView);
 //   [[UIApplication sharedApplication] openURL:[NSURL URLWithString:URLAddress]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[imageSearchView(100)]-50-|"
                                                                            options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-50-[imageSearchView(100)]"
                                                                      options:0 metrics:nil views:viewsDictionary]];
    UIImage *bgImage = [UIImage imageNamed:@"freelogue-web1.png"];
    [imageSearchView setImageWithURL:[NSURL URLWithString:URLAddress] placeholderImage:bgImage];
}
#pragma mark - Gesture recognizes
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}
- (void)addGesture{
    //   Add swipe gesture
    panRecognized = [[UIPanGestureRecognizer alloc]
                     initWithTarget:self
                     action:@selector(panRecognized:)];
    
    // Add touch for the textBox
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
    // When textField is touched, show keyboard
    [self keyboardOptions];
}
- (void)panRecognized:(UIPanGestureRecognizer *)sender
{
//    CGPoint touchLocation = [panRecognized locationInView:self.view];
//    composeTextView.center = touchLocation;
    if (sender.state == UIGestureRecognizerStateBegan) {
    }
   
    
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
  
    double pointX =composeTextView.center.x;
    double pointY =composeTextView.center.y + translation.y;
    
//    pointX = fmax(contentImageView.bounds.origin.x, pointX);
//    pointX = fmin(contentImageView.bounds.origin.x+contentImageView.frame.size.width, pointX);
    pointY = fmax(contentImageView.bounds.origin.y, pointY);
    pointY = fmin(contentImageView.bounds.origin.y+contentImageView.frame.size.height, pointY);

    composeTextView.center = CGPointMake(pointX,pointY);
}
#pragma mark - Button Action Methods
- (void)doneButtonPressed:(id)sender{
    doneButton.hidden = YES;
    postButton.hidden = NO;
    placeHolderLabel.hidden = YES;
    [self disableKeyBoard];
    if (doneCounter == 0){
    contentImageView.backgroundColor = [UIColor whiteColor];
        doneCounter++;
    }
}
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
}

#pragma mark -  Image Processing Manager Delegate methods
- (void)captureContentImage{
    [self disableKeyBoard];
    finalContentImage = [CommonUtility getImageFromView:contentImageView];
    placeHolderLabel.hidden = YES;
}
- (void)photoCaptureCancelled {
    //[self photoDialogCancelAction];
}
- (void)photoCaptureDoneWithImage:(UIImage *)image {
    // set image view
    [self cropImageToSquare:image];
    contentImageView.image = image;
    placeHolderLabel.hidden = YES;
    postButton.enabled = YES;
    defaultContentImage.image = image;
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
