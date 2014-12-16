//
//  ContentViewController.m
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 2/15/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import "ContentViewController.h"
#import "AppUIManager.h"
#import "ComposeViewController.h"
#import "ApiManager.h"
#import "AppDelegate.h"
#import "FlurryManager.h"
#import "SignInAndOutViewController.h"

#import "SettingsViewController.h"
#import "MapViewController.h"
#import "CommentViewController.h"
#import "ProfileViewController.h"
#import <Social/Social.h>
#import "NotificationViewController.h"
#import "AppUIConstants.h"


@implementation ContentViewController {
    
}

- (id)init
{
    if (self = [super init]) {
        
        self.tabBarItem = [[UITabBarItem alloc]
                           initWithTitle:@"WoM"
                           image:nil//[UIImage imageNamed:kAUCCoreFunctionTabbarImageContent]
                           tag:0];//kCFVTabbarIndexContent];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(receiveTestNotification:)
                                                     name:@"TestNotification"
                                                   object:nil];
        
    }
    return self;
}
- (void) receiveTestNotification:(NSNotification *) notification
{
    // [notification name] should always be @"TestNotification"
    // unless you use this method for observation of other notifications
    // as well.
    if ([[notification name] isEqualToString:@"TestNotification"])
        NSLog (@"Successfully received the test notification!");
}


#pragma mark -  View Life cycle Methods
- (void)loadView {
    [super loadView];
    
    // view customization code
    [self setView];
    
    // init content manager
    contentManager = [[ContentManager alloc] init];
    // init content
    currentContent =[[ApiContent  alloc] init];
    
    
}

- (void)viewDidLoad{
    [super viewDidLoad];
    // full screen view
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
    
}

- (void)viewDidUnload{
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // set up navigation bar
    //self.navigationItem.title = [[ApiManager sharedApiManager] currentUser].email;
    
    //userImage.image = [UIImage imageNamed:@"UserImage.png"];
    
    // hide navigation bar
    //   [self.navigationController setNavigationBarHidden:YES];
    
    // update content
    [self refreshContentOnlyForTopView:false];
    
    
    // add observer for text view
    //[contentTextView  addObserver:self forKeyPath:@"contentSize" options:(NSKeyValueObservingOptionNew) context:NULL];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    // Analytics: Flurry
    [Flurry logEvent:[FlurryManager getEventName:kFAContentSession] withParameters:nil timed:YES];
    
    // rest button active flag
    //    isAnimationActive = NO;
    //    animationView.hidden=YES;
    // set navigation bar
  //  self.navigationController.navigationBar.hidden = YES;
    [self.navigationController setNavigationBarHidden:YES];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    // Analytics: Flurry
    [Flurry endTimedEvent:[FlurryManager getEventName:kFAContentSession] withParameters:nil];
    // Analytics: Flurry
    [Flurry endTimedEvent:[FlurryManager getEventName:kFAContentEach] withParameters:nil];
    
    // remove observer for text view
    //[contentTextView removeObserver:self forKeyPath:@"contentSize"];
    
    
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

#pragma mark - Text View Observer
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    //    UITextView *txtview = object;
    //
    //    NSLog(@"Observer called....Text view size: %f, content size: %f",[txtview bounds].size.height,[txtview contentSize].height);
    //
    //    CGFloat topoffset = ([txtview bounds].size.height - [txtview contentSize].height * [txtview zoomScale])/2.0;
    //    topoffset = ( topoffset < 0.0 ? 0.0 : topoffset );
    //    txtview.contentOffset = (CGPoint){.x = 0, .y = -topoffset};
    //
    //    NSLog(@"Observer called....Text view size: %f, content size: %f",[txtview bounds].size.height,[txtview contentSize].height);
    //    NSLog(@"Observer called....Text view size: %f, content size: %f",[contentTextView bounds].size.height,[txtview contentSize].height);
}

#pragma mark -  View Design
- (void)setView {
    // set view
    [ContentViewHelper  setView:self.view];
    //    [self view].userInteractionEnabled = YES;
    
    [self setNavigationBar];
    
    self.navigationController.toolbarHidden = YES;
    // animation view
    //    animationView = [[UIView alloc] init];
    //    spreadAnimationView = [[UIImageView alloc] init];
    //    killAnimationView = [[UIImageView alloc] init];
    //    [ContentViewHelper setAnimationView:animationView withSpead:spreadAnimationView andKill:killAnimationView];
    //    [self.view addSubview:animationView];
    
    
    //page logo
    //pageLogo =[ContentViewHelper getPageLogoImageView];
    //    pageLogo =[ContentViewHelper getPageLogoButton];
    //    [pageLogo addTarget:self action:@selector(pageLogoButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    //    [self.view addSubview:pageLogo];
    
    // set buttons
    spreadButton = [ContentViewHelper getSpreadButton];
    [spreadButton addTarget:self action:@selector(spreadButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    killButton = [ContentViewHelper getKillButton];
    [killButton addTarget:self action:@selector(killButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    repliesButton = [ContentViewHelper getRepliesButton];
    [repliesButton addTarget:self action:@selector(goToCommentView:) forControlEvents:UIControlEventTouchUpInside];
    
    shareButton = [ContentViewHelper getShareButton];
    [shareButton addTarget:self action:@selector(shareButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    reportButton = [ContentViewHelper getReportButton];
    [reportButton addTarget:self action:@selector(goToReportMessage:) forControlEvents:UIControlEventTouchUpInside];
    
    commentCount = [ContentViewHelper getCommentsCount];
    spreadsCount = [ContentViewHelper getSpreadsCount];
    [repliesButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [repliesButton addSubview:commentCount];
    
    [spreadButton addSubview:spreadsCount];
    
    //    mapButton = [ContentViewHelper getMapButton];
    //     [mapButton addTarget:self action:@selector(goMapView:) forControlEvents:UIControlEventTouchUpInside];
    //    [self.view addSubview:mapButton];
    
    customContentView1 = [[CustomContentView alloc] init];
    customContentView2 = [[CustomContentView alloc] init];
    [customContentView2 setView];
    [customContentView1 setView];
    customContentView1.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:kAUCContentLoadingImage]];
    customContentView2.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:kAUCContentLoadingImage]];
    [self.view addSubview:customContentView2];
    [self.view addSubview:customContentView1];
    
    self.view.backgroundColor = [CommonUtility getColorFromHSBACVec:kAUContentBackgroundColor];
    // set toolbar
    [self setToolBar];
    
    [self.view addSubview:spreadButton];
    [self.view addSubview:killButton];
    [self.view addSubview:repliesButton];
    [self.view addSubview:shareButton];
    [self.view addSubview:reportButton];
    
    shareButton.enabled = NO;
    //    // set Textlabels and progress view
    //    spreadCount = [ContentViewHelper getTextLabelForSpreadCount];
    //    [self.view addSubview:spreadCount];
    //    progressCounter =[ContentViewHelper getCounterViewWithDelegate:self];
    //    [self.view addSubview:progressCounter];
    //
    //    // image view
    //    userImage = [ContentViewHelper getUserImageView];
    //    [self.view addSubview:userImage];
    
    //activity indicator view
    //activityIndicator =[[UIActivityIndicatorView alloc] init];
    activityIndicator =[[CustomActivityIndicator alloc] init];
    [AppUIManager addCustomActivityIndicator:activityIndicator toView:self.view];
    
    // layout
    [self layoutView];
    [self layoutAnimationView];
    
    // add gestures
    [self addGestures];
    
    // scroll adjustment
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)contentTextView;
{
    return NO;
}


- (void)layoutView{
    // all view elements
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(spreadButton,killButton,repliesButton,customContentView1,customContentView2, shareButton, reportButton, commentCount, spreadsCount, composeButton, moreButton);
    //NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(contentTextView,contentBackGround,spreadButton,killButton,composeButton,signInOutButton);
    
    // Comment count
    [repliesButton addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[commentCount(40)]" options:0 metrics:nil views:viewsDictionary]];
    [repliesButton addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[commentCount(35)]-15-|" options:0 metrics:nil views:viewsDictionary]];
    
    [spreadButton addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[spreadsCount(40)]-2-|" options:0 metrics:nil views:viewsDictionary]];
    [spreadButton addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[spreadsCount(20)]" options:0 metrics:nil views:viewsDictionary]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[moreButton(49)]" options:0 metrics:nil views:viewsDictionary]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[composeButton(40)]|" options:0 metrics:nil views:viewsDictionary]];

    //     Content view contraints
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[customContentView1(320)]|" options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[moreButton(40)]-[customContentView1(320)]-18-[repliesButton(59)]" options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[composeButton(40)]-[customContentView1(320)]-18-[repliesButton(59)]" options:0 metrics:nil views:viewsDictionary]];
    //    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[customContentView1(320)]-11-[reportButton)]" options:0 metrics:nil views:viewsDictionary]];
    
    // Next content view same constraints
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[customContentView2(320)]|" options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[moreButton(40)]-[customContentView2(320)]-18-[repliesButton(59)]" options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[composeButton(40)]-[customContentView2(320)]-18-[repliesButton(59)]" options:0 metrics:nil views:viewsDictionary]];
    
    //[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-18-[pageLogo(35)]-20-[contentTextView]-24-[spreadButton]"
    //                                                                options:0 metrics:nil views:viewsDictionary]];
    //
    //    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-18-[pageLogo(35)]"
    //                                                                      options:0 metrics:nil views:viewsDictionary]];
    
    
    //    // text view placement
    //    [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-16-[contentTextView]-16-|"
    //                                                                        options:0 metrics:nil views:viewsDictionary]];
    //
    //    [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-16-[contentTextView]-16-|"
    //                                                                        options:0 metrics:nil views:viewsDictionary]];
    //
    //    // next content
    //    [nextContentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-16-[nextContentTextView]-16-|"
    //                                                                            options:0 metrics:nil views:viewsDictionary]];
    //
    //    [nextContentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-16-[nextContentTextView]-16-|"
    //                                                                            options:0 metrics:nil views:viewsDictionary]];
    // toolbar
    //    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[infoToolBar(320)]"
    //                                                                      options:0 metrics:nil views:viewsDictionary]];
    //    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[infoToolBar]-20-[repliesButton]|"
    //                                                                      options:0 metrics:nil views:viewsDictionary]];
    
    // buttons
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[spreadButton(92)]|"
                                                                      options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[killButton(spreadButton)]"
                                                                      options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[reportButton(64)]-60-[repliesButton(59)]-60-[shareButton(64)]"
                                                                      options:0 metrics:nil views:viewsDictionary]];
    [AppUIManager horizontallyCenterElement:repliesButton inView:self.view];
    
    [self.view addConstraints:              [NSLayoutConstraint constraintsWithVisualFormat:@"V:[shareButton(32)]-50-[spreadButton(82)]|"
                                                                                    options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:              [NSLayoutConstraint constraintsWithVisualFormat:@"V:[reportButton(32)]-50-[spreadButton(82)]|"
                                                                                    options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:              [NSLayoutConstraint constraintsWithVisualFormat:@"V:[killButton(spreadButton)]|"
                                                                                    options:0 metrics:nil views:viewsDictionary]];
    
    //    [self.view addConstraints:              [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-70-[repliesButton(72)]-5-|"
    //                                                                                    options:0 metrics:nil views:viewsDictionary]];
}

- (void)layoutAnimationView{
    //    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(animationView,spreadAnimationView,killAnimationView);
    //
    //    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[animationView]|"
    //                                                                      options:0 metrics:nil views:viewsDictionary]];
    //    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[animationView]|"
    //                                                                      options:0 metrics:nil views:viewsDictionary]];
    //
    //    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[spreadAnimationView(172)]"
    //                                                                      options:0 metrics:nil views:viewsDictionary]];
    //    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[spreadAnimationView(154)]"
    //                                                                      options:0 metrics:nil views:viewsDictionary]];
    //    [AppUIManager horizontallyCenterElement:spreadAnimationView    inView:animationView];
    //    [AppUIManager verticallyCenterElement:spreadAnimationView    inView:animationView];
    //
    //    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[killAnimationView(169)]"
    //                                                                      options:0 metrics:nil views:viewsDictionary]];
    //    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[killAnimationView(173)]"
    //                                                                      options:0 metrics:nil views:viewsDictionary]];
    //
    //    [AppUIManager horizontallyCenterElement:killAnimationView    inView:animationView];
    //    [AppUIManager verticallyCenterElement:killAnimationView    inView:animationView];
    
    
}
- (void)setToolBar {
    
    //    float screenW = [CommonUtility getScreenWidth];
    // //   infoToolBar = [[UIToolbar alloc] init];
    //  infoToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, screenW, 50)];
    // //    infoToolBar = [[UIToolbar alloc] init];
    // //   infoToolBar.frame = CGRectMake(0,  44, self.view.frame.size.width, 44);
    //    infoToolBar.backgroundColor = [UIColor clearColor];
    //    infoToolBar.tintColor = [UIColor orangeColor];
    //    infoToolBar.translucent = YES;
    //    // Make toolbar clear
    //    [infoToolBar setTranslatesAutoresizingMaskIntoConstraints:NO];
    //    [infoToolBar setBackgroundImage:[UIImage new]
    //                  forToolbarPosition:UIBarPositionAny
    //                          barMetrics:UIBarMetricsDefault];
    //    [infoToolBar setShadowImage:[UIImage new]
    //              forToolbarPosition:UIToolbarPositionAny];
    //
    //
    //    viewsImage = [ContentViewHelper getViewsImage];
    //    commentImage = [ContentViewHelper getCommentImage];
    //
    //    viewsCount = [ContentViewHelper getViewsCount];
    //    commentCount = [ContentViewHelper getCommentsCount];
    //
    //
    //    UIBarButtonItem *flexibleSpace =  [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    //    reportButton = [ContentViewHelper getReportButton];
    //    [reportButton addTarget:self action:@selector(goToReportMessage:) forControlEvents:UIControlEventTouchUpInside];
    //
    //    rButton = [[UIBarButtonItem alloc] initWithCustomView:reportButton];
    //    vImage = [[UIBarButtonItem alloc]initWithCustomView:viewsImage];
    //    cImage = [[UIBarButtonItem alloc]initWithCustomView:commentImage];
    //    vCount = [[UIBarButtonItem alloc] initWithCustomView:viewsCount];
    //    cCount = [[UIBarButtonItem alloc] initWithCustomView:commentCount];
    //
    //    NSArray *buttonItems = [NSArray arrayWithObjects:vImage,vCount,flexibleSpace, cImage, cCount, flexibleSpace, rButton, nil];
    //    [infoToolBar setItems:buttonItems];
    //    // infoToolBar.items = buttonItems;
    //    [self.view addSubview:infoToolBar];
    
}

- (void)setNavigationBar {
    // set up navigation bar
    //   self.navigationItem.title = @"Spark";
    composeButton = [ContentViewHelper getComposeButton];
    [composeButton addTarget:self action:@selector(goToAddContentView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:composeButton];
    moreButton = [ContentViewHelper getSettingsButton];
    [moreButton addTarget:self action:@selector(goToSettingsView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:moreButton];
    //    [self.navigationController.navigationBar setTranslucent:YES];
    //    self.navigationController.navigationBar.shadowImage = [UIImage new];
    //    self.navigationController.view.backgroundColor = [UIColor clearColor];
    //    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    //    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    //    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    //    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
    //                             forBarMetrics:UIBarMetricsDefault];
    //    self.navigationController.navigationBar.shadowImage = [UIImage new];
    //    self.navigationController.navigationBar.translucent = YES;
    //    self.navigationController.view.backgroundColor = [UIColor clearColor];
    
//    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:composeButton];
//    self.navigationItem.rightBarButtonItem = rightBarButton;
//    
//    // left navigation button
//    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:moreButton];
//    self.navigationItem.leftBarButtonItem = leftBarButton;
    
    //    UIBarButtonItem *settingsButton = [[UIBarButtonItem alloc] initWithTitle:@"\u2699" style:UIBarButtonItemStylePlain
    //    UIFont *settingsFont = [UIFont fontWithName:@"Helvetica" size:24.0];
    //     NSDictionary *fontDictionary = @{NSFontAttributeName:settingsFont};
    //    [settingsButton setTitleTextAttributes:fontDictionary forState:UIControlStateNormal];
    //    self.navigationItem.leftBarButtonItem = settingsButton;
//    self.navigationController.navigationBar = sizeToFit;
    
    
    //     [[UINavigationBar appearance] setTranslucent:YES];
    //    [[UINavigationBar appearance] setShadowImage:[UIImage new]];
    //    [[UINavigationBar appearance] setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    //    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    //    [[UINavigationBar appearance] setBackgroundColor:[UIColor blueColor]];
    //  navigationController.navigationBar setTranslucent:NO]
    [[UINavigationBar appearance] setTranslucent:NO];
    [[UINavigationBar appearance] setShadowImage:[UIImage new]];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
  //  [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"header-gradient.png"] forBarMetrics:UIBarMetricsDefault];
    //   [[UINavigationBar appearance] setTintColor:[UIColor redColor]];
    
    //   [[UINavigationBar appearance] setShadowImage:[UIImage imageNamed:@"header-gradient.png"]];
    // text shadow: use layer property (UIView)
   
}

- (void)addGestures{
    // Add swipeGestures
    panRecognized = [[UIPanGestureRecognizer alloc]
                     initWithTarget:self action:@selector(panRecognized:)];
    panRecognized2 = [[UIPanGestureRecognizer alloc]
                      initWithTarget:self action:@selector(panRecognized:)];
    
    
    [panRecognized setMinimumNumberOfTouches:1];
    [panRecognized setMaximumNumberOfTouches:1];
    
    [panRecognized2 setMinimumNumberOfTouches:1];
    [panRecognized2 setMaximumNumberOfTouches:1];
    //   CustomContentView *acv = [self getViewOnTop];
    
    [customContentView2 addGestureRecognizer:panRecognized2];
    [customContentView1 addGestureRecognizer:panRecognized];
    
    
    //     touchRecognized = [[UITapGestureRecognizer alloc]
    //              initWithTarget:self
    //              action:@selector(textTapped:)];
    //
    //    [contentTextView addGestureRecognizer:touchRecognized];
    
    //        [[self view] addGestureRecognizer:panRecognized];
    
}
//- (void)addGestures{
//    // Add swipeGestures
//    oneFingerSwipeLeft = [[UISwipeGestureRecognizer alloc]
//                          initWithTarget:self
//                          action:@selector(swipeLeft:)];
//    [oneFingerSwipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
//    [[self view] addGestureRecognizer:oneFingerSwipeLeft];
//
//    oneFingerSwipeRight = [[UISwipeGestureRecognizer alloc]
//                           initWithTarget:self
//                           action:@selector(swipeRight:)];
//    [oneFingerSwipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
//    [[self view] addGestureRecognizer:oneFingerSwipeRight];
//}

- (void)displaySignInOutButtonView{
    SignInAndOutViewController *siovc =[[SignInAndOutViewController alloc] init];
    //siovc.view.bounds = self.view.bounds;
    [self presentViewController:siovc    animated:YES completion:nil];
}

#pragma mark - Gesture Recognizers Action Methods

//- (void)textTapped:(UITapGestureRecognizer *)recognizer
//{
//    UITextView *textView = (UITextView *)recognizer.view;
//
//    // Location of the tap in text-container coordinates
//
//    CGPoint location = [recognizer locationInView:textView];
//    location.x -= textView.textContainerInset.left;
//    location.y -= textView.textContainerInset.top;
//
//}

//- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
////    [contentTextView resignFirstResponder];
////    [super touchesBegan:touches withEvent:event];
//
////    if (contentTextView.userInteractionEnabled)
////    {
////        NSLog(@"not detected wtf");
////    }
// //    NSLog(@"begin touch");
// //   NSLog(@"%f" ,_xCoord);
//   UITouch *touch = [touches anyObject];
//   _startPoint = [touch locationInView:self.view];
//   _xCoord = _startPoint.x;
////    CGFloat y = startPoint.y;
//
//   // xCoord.text = [NSString stringWithFormat:@"x = %f", x];
//}


//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
//{
// //   NSLog(@"end touch");
//    UITouch *touch = [touches anyObject];
//    _endPoint = [touch locationInView:self.view];
//    _xCoord = _startPoint.x - _endPoint.x;
////    NSLog(@"%f" ,_xCoord);
////    _xCoord.text = [NSString stringWithFormat:
////                    @"start = %f, %f", _startPoint.x, _startPoint.y];
//}
//
////-(id)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
////    id hitView = [super hitTest:point withEvent:event];
////    if (hitView == self) return nil;
////    else return hitView;
////}


- (void)panRecognized:(UIPanGestureRecognizer *)sender
{
    if (isRefreshingContent){
        return;
    }
    CustomContentView *tcv = [self getViewOnTop];
    
    // Get distance of pan/swipe in the view in which the gesture recognizer was added
    //    CGPoint distance = [sender translationInView:contentView];
    
    // Get velocity of pan/swipe in the view in which the gesture recognizer was added
    //  CGPoint velocity = [sender velocityInView:self.view];
    // Begin state get coordinates
    if (sender.state == UIGestureRecognizerStateBegan) {
        _originX = [tcv center].x;
        _originY = [tcv center].y;
        _startingTap = [panRecognized locationInView:self.view].x;
        _startingTap2 = [panRecognized2 locationInView:self.view].x;
        _startVerticalTap = [panRecognized locationInView:customContentView1].y;
    }
    
    CGPoint translatedPoint = [(UIPanGestureRecognizer*)sender translationInView:tcv];
    //    translatedPoint = CGPointMake(_originX+translatedPoint.x, _originY+translatedPoint.y);
    translatedPoint = CGPointMake(_originX+translatedPoint.x, _originY);
    if (UIGestureRecognizerStateChanged == sender.state) {
        
        // Use translation offset
        CGPoint translation = [sender translationInView:sender.view];
        sender.view.center = CGPointMake(sender.view.center.x + translation.x,
                                         sender.view.center.y);
        
        // Clear translation
        [sender setTranslation:CGPointZero inView:sender.view];
        [sender cancelsTouchesInView];
    }
    
    
    // Use this if you need to move an object at a speed that matches the users swipe speed
    //   float usersSwipeSpeed = abs(velocity.x);
    
    if (sender.state == UIGestureRecognizerStateEnded) {
        //       NSLog(@"%f", velocity.x);
        float screenW = [CommonUtility getScreenWidth];
        //   float screenH = [CommonUtility getScreenHeight];
        
        _endingTap = [panRecognized locationInView:self.view].x;
        _endingTap2 = [panRecognized2 locationInView:self.view].x;
        _endVerticalTap = [panRecognized locationInView:self.view].y;
        
        // NSLog(@"%f", _endingTap2);
        // right
        if (_endingTap - _startingTap > (screenW / 3) || _endingTap2 - _startingTap2 > (screenW / 3)) {
            // NSLog(@"Swiped right %f", distance.x);
            [self spreadButtonPressed:nil];
            // left
        } else if (_startingTap - _endingTap > (screenW / 3) || _startingTap2 - _endingTap2 > (screenW / 3)) {
            // NSLog(@"Swiped left %f", distance.x);
            [self killButtonPressed:nil];
        }
        //        if (_startVerticalTap - _endVerticalTap > (screenH / 4)){
        //            [self goToCommentView:self];
        //        }
        [sender setTranslation:CGPointZero inView:sender.view];
        
        
        // Snap contentView to original position
        [tcv setCenter:translatedPoint];
        
        //                // Use translation offset
        //                CGPoint translation = [sender translationInView:sender.view];
        //                sender.view.center = CGPointMake(sender.view.center.x + translation.x,
        //                                                 sender.view.center.y + translation.y);
        
        // Clear translation
        
        // //       [sender setTranslation:CGPointZero inView:sender.view];
        
        //         [sender cancelsTouchesInView];
        //
        //        // right
        //        if (distance.x > screenW / 4) {
        //            // NSLog(@"Swiped right %f", distance.x);
        //            [self spreadButtonPressed:nil];
        //            // left
        //        } else if (distance.x < -(screenW / 4)) {
        //            // NSLog(@"Swiped left %f", distance.x);
        //            [self killButtonPressed:nil];
        //        }
        //        // down
        //        if (distance.y > 0) {
        //            NSLog(@"user swiped down");
        //        }
        //        //up
        //        else if (distance.y < 0){
        //            NSLog(@"user swiped up");
        //        }
    }
}


//- (void)swipeLeft:(id)sender{
//    [self killButtonPressed:nil];
//}
//
//- (void)swipeRight:(id)sender{
//    [self spreadButtonPressed:nil];
//}

#pragma mark - Button Action Methods
- (void)shareButtonPressed:(id)sender {
    NSString *message = @"Found in Spark http://www.sparkapp.social/";
     scv = [self getViewOnTop];
    if (scv.contentImageView.image==nil){
        return;
    }
    
    UIImage *imageToShare = scv.contentImageView.image;
    NSArray *postItems = [[NSArray alloc] initWithObjects:imageToShare, message, nil];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc]
                                            initWithActivityItems:postItems
                                            applicationActivities:nil];
    [activityVC setTitle:message];
    
    activityVC.excludedActivityTypes = @[UIActivityTypePostToWeibo,
                                         // UIActivityTypeMessage,
                                         //   UIActivityTypeMail,
                                         UIActivityTypePrint,
                                         UIActivityTypeCopyToPasteboard,
                                         UIActivityTypeAssignToContact,
                                         // UIActivityTypeSaveToCameraRoll,
                                         UIActivityTypeAddToReadingList,
                                         UIActivityTypePostToFlickr,
                                         UIActivityTypePostToVimeo,
                                         UIActivityTypePostToTencentWeibo,
                                         UIActivityTypeAirDrop];
   // activityVC.popoverPresentationController.sourceView = self.view;
 //   [self presentViewController:activityVC animated:YES completion:nil];
  //  [self.navigationController pushViewController:activityVC animated:NO];
  //  [[[self parentViewController] parentViewController] presentViewController:activityVC animated:YES completion:nil];
    [[self parentViewController] presentViewController:activityVC animated:YES completion:nil];
}
// Override

- (void)goMapView:(id)sender {
    MapViewController *mvc =[[MapViewController alloc] init];
    mvc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:mvc animated:NO];
}

- (void)goToAddContentView:(id)sender {
    // set add content view
    ComposeViewController *acvc =[[ComposeViewController alloc] init];
    acvc.hidesBottomBarWhenPushed=YES;
    
    [self.navigationController pushViewController:acvc animated:NO];
}

- (void)goToSettingsView:(id)sender {
    SignInAndOutViewController *siovc =[[SignInAndOutViewController alloc] init];
    siovc.hidesBottomBarWhenPushed=YES;
    [self presentViewController:siovc    animated:YES completion:nil];
    
//    SettingsViewController *svc = [[SettingsViewController alloc] init];
//    svc.hidesBottomBarWhenPushed=YES;
//    [self.navigationController pushViewController:svc animated:NO];
}

-(void)goToReportMessage:(id)sender {
    // Display report message, report it to backend
     scv = [self getViewOnTop];
    if (scv.contentImageView.image==nil){
        return;
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Content offensive?" message:@"Want to report this content?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    [alert show];
    
}

-(void)goToCommentView:(id)sender{
    if (isRefreshingContent) {
        return;
    }
    CommentViewController *cvc = [[CommentViewController alloc] init];
    cvc.hidesBottomBarWhenPushed=YES;
    cvc.currentContent = currentContent;
    
    [self.navigationController pushViewController:cvc animated:NO];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0)
    {
        // Cancel clicked
        //    NSLog(@"Cancel");
    }
    else if (buttonIndex == 1)
    {
        [activityIndicator startAnimating];
        [[ApiManager sharedApiManager] flagContentWithId:currentContent.contentId.intValue
                                                 success:^(ApiContentFlag *contentFlag) {
                                                     [activityIndicator stopAnimating];
                                                     [self actionsForSuccessfulFlagContent];
                                                 } failure:^(NSError *error) {
                                                     [activityIndicator stopAnimating];
                                                 }];
        [self killButtonPressed:self];
    }
}
-(void)actionsForSuccessfulFlagContent{
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Report message" message:@"This content is now reported as inappropriate" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//    [alert show];
//    
//    [self performSelector:@selector(dismissAlertView:) withObject:alert afterDelay:1.0];
//    NSLog(@"Flag Message");
    
    
}
-(void)dismissAlertView:(UIAlertView *)alertView{
    [alertView dismissWithClickedButtonIndex:0 animated:YES];
}

- (void)pageLogoButtonPressed:(id)sender{
    [self displaySignInOutButtonView];
}

#pragma mark - Custom Content View Methods
- (CustomContentView *)getViewInBottom{
    NSInteger index1 = [[[customContentView1 superview] subviews] indexOfObject: customContentView1];
    NSInteger index2 = [[[customContentView2 superview] subviews] indexOfObject: customContentView2];
    
    if(index1>index2){
        return customContentView2;
    }else{
        return customContentView1;
    }
}

- (CustomContentView *)getViewOnTop{
    NSInteger index1 = [[[customContentView1 superview] subviews] indexOfObject: customContentView1];
    NSInteger index2 = [[[customContentView2 superview] subviews] indexOfObject: customContentView2];
    
    if(index1>index2){
        return customContentView1;
    }else{
        return customContentView2;
    }
}
-(void)swapCustomContentView:(CustomContentView *)customContentView{
    //   customContentView.hidden = YES;
    NSInteger indexTop = [[[customContentView superview] subviews] indexOfObject: customContentView ];
    [self.view exchangeSubviewAtIndex:indexTop withSubviewAtIndex:indexTop-1];
    
    
}

-(void)updateCustomContentView:(CustomContentView *)customContentView withText:(NSString *)text andImage:(UIImage *)image{
    //    [customContentView customTextView] = text;
    //      contentView.attributedText = [ContentViewHelper getAttributedText:currentContent.customContentView];
    //    customContentView.textInputMode = text;
    //          customContentView.image= image;
    customContentView.hidden = NO;
}

#pragma mark -  Content Display method
- (void)updateContentForTopView:(bool)isTop{
    // start animation
    [self startContentLoadAnimation];
    
    // Analytics: Flurry
    [Flurry logEvent:[FlurryManager getEventName:kFAContentFetch] withParameters:nil timed:YES];
    
    // update content
    [contentManager getContentWithActivityIndicator:nil//activityIndicator
                                            success:^(ApiContent *content) {
                                                // Analytics: Flurry
                                                [Flurry endTimedEvent:[FlurryManager getEventName:kFAContentFetch] withParameters:nil];
                                                currentContent=content;
                                                [self updateViewWithNewContentForTopView:isTop];
                                            }
                                            failure:^(ApiContent *content) {
                                                // Analytics: Flurry
                                                [Flurry endTimedEvent:[FlurryManager getEventName:kFAContentFetch] withParameters:@{@"Error":@"No Content"}];
                                                currentContent= content;
                                                [self updateViewWithNewContentForTopView:isTop];
                                            }];
    
    // Analytics: Flurry
    [Flurry logEvent:[FlurryManager getEventName:kFAContentEach] withParameters:nil timed:YES];
    
}
//- (void)updateView:(CustomContentView *)customContentView WithNewContent:newContent{
- (void)updateViewWithNewContentForTopView:(bool)isTop{
    
    //    [spreadButton setImage:[UIImage imageNamed:kAUCSpreadButtonImage] forState:UIControlStateNormal];
    [self startContentLoadAnimation];
    
    //  UIImage *bgImage = [self dummyImage];
    bgImage = [ContentViewHelper getImageForContentBackGroudView];
    
    //  UIImage *bgImage = [UIImage imageNamed:@"freelogue-web1.png"];
    //   UIImage *bgImage2 = [UIImage imageNamed:@"319041.jpg"];
    customContentView1.contentMode = UIViewContentModeScaleToFill;
    customContentView2.contentMode = UIViewContentModeScaleToFill;
    if(isTop){
        ccv = [self getViewOnTop];
    }
    else{
        ccv = [self getViewInBottom];
    }
    ccv.contentMode = UIViewContentModeScaleAspectFill;
    
    //   [ApiContent printContentInfo:currentContent];
    
    if([currentContent.photoToken isKindOfClass:[NSDictionary class]]
       && currentContent.photoToken[@"url"] &&
       (![currentContent.photoToken[@"url"] isEqual:[NSNull null]])){
        //        [contentBackGround setImageWithURL:[NSURL URLWithString:currentContent.photoToken[@"url"]]
        //                          placeholderImage:bgImage];
        //        NSLog(@"getting image");
        [ccv.contentImageView setImageWithURL:[NSURL URLWithString:currentContent.photoToken[@"url"]]
                             placeholderImage:bgImage];
        //   [self performContentDisplayAnimation];
    }
    else{
        ccv.contentImageView.image = bgImage;
        //        [contentView addSubview:contentBackGround];
        //        [self performSelector:@selector(performContentDisplayAnimation)
        //                   withObject:nil
        //                   afterDelay:2.0];
        //    [self performContentDisplayAnimation];
    }
    
    //[ApiContent printContentInfo:currentContent];
    // change category color
    //[ContentViewHelper updateContentBackGroundView:contentBackGround forCategory:(kAPIContentCategory)currentContent.categoryId];
    
    //    // set text
    //    contentTextView.text = currentContent.contentText;
    //
    //    // get text
    //    [ccv setAttributedText:[ContentViewHelper getAttributedText:currentContent.contentText]];
    
    //    customContentView1.attributedText = [ContentViewHelper getAttributedText:currentContent.contentText];
    //
    //    customContentView1.attributedText = [ContentViewHelper getAttributedText:(@"testing a verrrry long message because i want to see what it does")];
    
    
    //            contentView.attributedText = [ContentViewHelper getAttributedText:currentContent.contentView];
    
    // contentTextView.attributedText = [ContentViewHelper getAttributedText:[self dummyText]];
    
    //contentTextView.attributedText = [ContentViewHelper getAttributedText:@"Put a bird on it +1 Helvetica, iPhone quinoa Kickstarter Blue Bottle tote bag McSweeney's Carles wayfarers. McSweeney's trust fund biodiesel actually, next level squid keffiyeh Williamsburg ennui semiotics Helvetica authentic. Selfies Etsy umami, narwhal chillwave Williamsburg small batch "];
    
    
    //NSAttributedString *str = [[NSAttributedString alloc] initWithString:currentContent.contentText];
    //contentTextView.attributedText =str ;
    // center virtically
    //[AppUIManager  verticallyAlignTextView:contentTextView];
    //[self.view  updateConstraintsIfNeeded];
    
    // update counts
    //spreadCount.text = [NSString stringWithFormat:@"%ld", (long)currentContent.totalSpread.integerValue];
    ///timeCount.text = currentContent.timeStamp;
    //[self resetContentTimer];
    
    pic_index +=1;
    pic_index = (int) fmodf(pic_index,4.0);
    
    // comment count tag
    commentCount.text = [CommonUtility getFixedLengthStringForNumber:currentContent.commentCount];
    spreadsCount.text = [CommonUtility getFixedLengthStringForNumber:currentContent.spreadCount];
    
    shareButton.enabled = YES;
    
    isRefreshingContent = false;
}
- (void)clearContents{
    [contentManager clearContents];
    currentContent.contentId = nil;
    
}
- (void)refreshContentOnlyForTopView:(bool)onlyTop{
    if((currentContent.contentId==nil)&&([[ApiManager sharedApiManager] currentUser]!=nil)){
        // update the top view
         isRefreshingContent = true;
        [self updateContentForTopView:true];
        if(!onlyTop){
            // update the bottom view
            //[self updateContentForTopView:false];
        }
    }
}

#pragma mark - Dummy content
//- (UIImage *)dummyImage{
//
//    NSString *fileName =[[@"ScreenShot" stringByAppendingFormat:@"%d",pic_index+1 ]stringByAppendingString:@".png"];
//
//    return [UIImage imageNamed:fileName];
//}
//
//-(NSString *)dummyText{
//    NSArray *textArray=@[
//                         @"Awesome concert tonight!",
//                         @"We used to look at the stars and confess our dreams Hold each other 'till the morning light",
//                         @"\"He who must travel happily must travel light.\"\n -Antoine de Saint-Exupery",
//                         @"I can't believe we know more about the surface of the moon than the ocean floor "
//                         ];
//
//    return textArray[pic_index];
//
//}


#pragma mark - Animation Methods
- (void)startContentLoadAnimation{
    //isAnimationActive=YES;
    //    [self hideViewsForContentLoad];
    //    if(!activityIndicator.isAnimating){
    //        [activityIndicator startAnimatingCI];
    //    }
}
- (void)stopContentLoadAnimation{
    if(activityIndicator.isAnimating){
        [activityIndicator stopAnimating];
    }
}
- (void)performContentDisplayAnimation{
    //isAnimationActive=YES;
    [self stopContentLoadAnimation];
    [self setViewsForContentDisplay];
    //    [ContentViewHelper animateViewsForContentDisplay:@[contentBackGround, contentTextView,spreadButton,killButton,contentView, nextContentView]
    //                                     withFinalAction:^(){
    //                                         isAnimationActive=NO;
    //                                     }];
    
    //    [ContentViewHelper animateViewsForContentDisplay:@[customContentView1, customContentView2]
    //                                     withFinalAction:^(){
    //                                         isAnimationActive=NO;
    //                                     }];
    
}
- (void)performUserResponseAnimationWithResponse:(BOOL)response{
    //isAnimationActive=YES;
    contentView.hidden = YES;
    //    [ContentViewHelper animateViews:@[contentBackGround, contentTextView,spreadButton,killButton,animationView,spreadAnimationView,killAnimationView]
    //                    forUserResponse:response
    //                    withFinalAction:^(){
    //                        [self updateContent];
    //                    }];
    [self updateContentForTopView:true];
   // [self refreshContentOnlyForTopView:true];
    
}
//- (void)animationButtonsForContentUpdate{
//    isAnimationActive=YES;
//    // add animation: button
//    [ContentViewHelper animateButtonWithSlideFromDownAndUpShoot:spreadButton withFinalAction:^(){
//    }];
//    [ContentViewHelper animateButtonWithSlideFromDownAndUpShoot:killButton withFinalAction:^(){
//        [self updateViewWithNewContent];
//    }];
//    [ContentViewHelper animateButtonWithSlideFromDown:composeButton withFinalAction:^(){
//    }];
//
//}

- (void)hideViewsForContentLoad{
    contentTextView.hidden=YES;
    contentBackGround.hidden=YES;
    spreadButton.hidden=YES;
    killButton.hidden=YES;
    //    composeButton.hidden=YES;
    //    mapButton.hidden=YES;
}
- (void)setViewsForContentDisplay{
    contentTextView.alpha=0.0;
    contentBackGround.alpha=0.0;
    contentTextView.hidden=NO;
    contentBackGround.hidden=NO;
    spreadButton.hidden=NO;
    killButton.hidden=NO;
    //    composeButton.hidden=NO;
    contentView.hidden=NO;
    //   mapButton.hidden=NO;
}


#pragma mark - user_response methods
- (void) spreadButtonPressed:(id)sender {
    //    if(isAnimationActive){
    //        return;
    //    }
    if (isRefreshingContent){
        return;
    }
    
    isAnimationActive=YES;
    [self animateSpreadButton];
    // Analytics: Flurry
    [Flurry logEvent:[FlurryManager getEventName:kFAContentSpread]];
    
    //    [UIView transitionWithView:spreadButton
    //                      duration:1.2f
    //                       options:UIViewAnimationOptionTransitionCrossDissolve
    //                    animations:^{
    //                        spreadButton.imageView.image = [UIImage imageNamed:kAUCSpreadButtonFilledImage];
    //                    } completion:NULL];
    
    [self AddContentEachAnalytics:@"Spread"];
    [self postResponse:true];
    // animate button
    
    //    [ContentViewHelper animateButtonWithSlideUpAndReturn:spreadButton
    //                                         withFinalAction:^(){
    //                                             [self postResponse:true];
    //                                         }];
    [self swapCustomContentView:[self getViewOnTop]];
    //   [spreadButton setImage:[UIImage imageNamed:kAUCSpreadButtonFilledImage] forState:UIControlStateNormal];
    //    [[NSNotificationCenter defaultCenter]postNotificationName:@"TestNotification" object:nil];
    
}
- (void)animateSpreadButton{
    NSArray *animationArray=[NSArray arrayWithObjects:
                             [UIImage imageNamed:kAUCSpreadButtonFilledImage],
                             [UIImage imageNamed:kAUCSpreadButtonImage],
                             nil];
    //    [UIView transitionWithView:spreadButton
    //                      duration:1.2f
    //                       options:UIViewAnimationOptionTransitionCrossDissolve
    //                    animations:^{
    //                        spreadButton.imageView.image = [UIImage imageNamed:kAUCSpreadButtonFilledImage];
    //                    } completion:NULL];
    
    spreadButton.imageView.animationImages = animationArray;
    spreadButton.imageView.animationDuration = 1.0;
    spreadButton.imageView.animationRepeatCount = 1;
    spreadButton.adjustsImageWhenHighlighted = NO;
    [spreadButton.imageView startAnimating];
}
- (void) killButtonPressed:(id)sender {
    if (isRefreshingContent){
        return;
    }
    
    //   [self swapCustomContentView:customContentView1];
    //    if(isAnimationActive){
    //        return;
    //    }
    isAnimationActive=YES;
    [self animateKillButton];
    // Analytics: Flurry
    [Flurry logEvent:[FlurryManager getEventName:kFAContentKill]];
    [self AddContentEachAnalytics:@"Kill"];
    [self postResponse:false];
    
    //    // animate button
    //    [ContentViewHelper animateButtonWithSlideUpAndReturn:killButton
    //                                         withFinalAction:^(){
    //                                             [self postResponse:false];
    //                                         }];
    [self swapCustomContentView:[self getViewOnTop]];
}
- (void)animateKillButton{
    NSArray *animationArray=[NSArray arrayWithObjects:
                             [UIImage imageNamed:kAUCKillButtonFilledImage],
                             [UIImage imageNamed:kAUCKillButtonImage],
                             nil];
    //    [UIView transitionWithView:spreadButton
    //                      duration:1.2f
    //                       options:UIViewAnimationOptionTransitionCrossDissolve
    //                    animations:^{
    //                        spreadButton.imageView.image = [UIImage imageNamed:kAUCSpreadButtonFilledImage];
    //                    } completion:NULL];
    
    killButton.imageView.animationImages = animationArray;
    killButton.imageView.animationDuration = 1.0;
    killButton.imageView.animationRepeatCount = 1;
    killButton.adjustsImageWhenHighlighted = NO;
    [killButton.imageView startAnimating];
}

- (void)AddContentEachAnalytics:(NSString *)type{
    // Analytics: Flurry
    [Flurry endTimedEvent:[FlurryManager getEventName:kFAContentEach] withParameters:@{@"Action":type}];
    
    // Analytics: Flurry
    [Flurry logEvent:[FlurryManager getEventName:kFAContentEach] withParameters:nil timed:YES];
}

#pragma mark - Post Response Method
- (void)postResponse:(BOOL)response{
    // check for empty content condition: do not post response
    if(currentContent.categoryId==kAPIContentCategoryEmpty){
        [self updateContentForTopView:true];
//        [self refreshContentOnlyForTopView:true];
        return;
    }
    
    // post content user
    //[activityIndicator startAnimating];
    [self performUserResponseAnimationWithResponse:response];
    [[ApiManager sharedApiManager] postResponseWithContentId:currentContent.contentId.intValue
                                                    response:[NSNumber numberWithBool:response]
                                                     success:^(ApiUserResponse *response){
                                                         //[activityIndicator stopAnimating];
                                                         //[self actionsForSuccessfulPostResponse];
                                                     }failure:^(NSError * error){
                                                         //[activityIndicator stopAnimating];
                                                         //[ApiErrorManager displayAlertWithError:error withDelegate:self];
                                                         // do not show any error just assume sucess
                                                         //[self actionsForSuccessfulPostResponse];
                                                     }];
    // spreadButton.imageView.image = [UIImage imageNamed:kAUCSpreadButtonImage];
}

#pragma mark - Api Manager Post actions methods
- (void)actionsForSuccessfulPostResponse{
    [self updateContentForTopView:true];
 //   [self refreshContentOnlyForTopView:true];
}

//#pragma mark -  Progress view methods
//- (void)updateProgressViewWithValue:(CGFloat)value{
//    //[progressClock setProgress:value animated:YES];
//}

//#pragma mark - Timer Methods
//- (void)onTimerTask:(NSTimer *)timer {
//    // update reminaing time
//    timeRemaining -=1.0;
//    if(timeRemaining>=0){
//        [self updateProgressViewWithValue:timeRemaining];
//    }
//
//    if(timeRemaining<=0){
//        // stop the clock
//        [self setTimerOff:progressTimer];
//    }
//}
//
//- (void)setTimerOn {
//    progressTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(onTimerTask:) userInfo:nil repeats:YES];
//}
//
//- (void)resetTimerCount {
//
//}
//- (void)setTimerOff:(NSTimer *)timer {
//    if([timer isValid]) {
//        [timer invalidate];
//    }
//    timer = nil;
//}
//- (void)resetContentTimer{
//    [progressCounter stop];
//    [progressCounter startWithSeconds:kAUCAppContentTimerMax];
//}

//#pragma mark - CircleCounterViewDelegate methods
//- (void)counterDownFinished:(CVCircleCounterView *)circleView {
//    //update content
//    [self updateContent];
//}
//
//- (void)counter:(CVCircleCounterView *)circleView updatedWithValue:(float)timeInSeconds{
//    //if(timeInSeconds<=kAUCAppContentTimerWarning){
//    //circleView.circleColor = [UIColor redColor];
//    //circleView.numberColor = [UIColor redColor];
//    // }
//}

@end
