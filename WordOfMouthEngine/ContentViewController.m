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

@implementation ContentViewController

- (id)init
{
    if (self = [super init]) {
        
        self.tabBarItem = [[UITabBarItem alloc]
                           initWithTitle:@"WoM"
                           image:nil//[UIImage imageNamed:kAUCCoreFunctionTabbarImageContent]
                           tag:0];//kCFVTabbarIndexContent];
        
        // set color
        //[CommonViewElementManager setTableViewBackGroundColor:self.tableView];
        
    }
    return self;
}

#pragma mark -  View Life cycle Methods

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
    [super loadView];
    // view customization code
    [self setView];
    
    // init content manager
    contentManager = [[ContentManager alloc] init];
    // init conent
    currentContent =[[ApiContent  alloc] init];
}

- (void) viewDidLayoutSubviews {
    
    
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
    
    // set up navigation bar
    //self.navigationItem.title = [[ApiManager sharedApiManager] currentUser].email;
    
    //userImage.image = [UIImage imageNamed:@"UserImage.png"];
    
    // hide navigation bar
    [self.navigationController setNavigationBarHidden:YES];
    
    // update sign in button title
    [self updateSignInOutButtonTitle];
    
    // rest button active flag
    isPostActionActive = NO;
    
    // add observer for text view
    //[contentTextView  addObserver:self forKeyPath:@"contentSize" options:(NSKeyValueObservingOptionNew) context:NULL];
}

- (void)viewDidAppear:(BOOL)animated{
    // Analytics: Flurry
    [Flurry logEvent:[FlurryManager getEventName:kFAContentSession] withParameters:nil timed:YES];
    
    // update content
    [self updateContent];
    
}
- (void)viewWillDisappear:(BOOL)animated {
    // Analytics: Flurry
    [Flurry endTimedEvent:[FlurryManager getEventName:kFAContentSession] withParameters:nil];
    // Analytics: Flurry
    [Flurry endTimedEvent:[FlurryManager getEventName:kFAContentEach] withParameters:nil];
    
    // remove observer for text view
    //[contentTextView removeObserver:self forKeyPath:@"contentSize"];
    
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

#pragma mark -  Content Display method
- (void)updateContent{
    // Analytics: Flurry
    [Flurry logEvent:[FlurryManager getEventName:kFAContentFetch] withParameters:nil timed:YES];
    
    // update content
    [contentManager getContentWithActivityIndicator:activityIndicator
                                            success:^(ApiContent *content) {
                                                // Analytics: Flurry
                                                [Flurry endTimedEvent:[FlurryManager getEventName:kFAContentFetch] withParameters:nil];
                                                currentContent=content;
                                                [self animationButtonsForContentUpdate];
                                            }
                                            failure:^(ApiContent *content) {
                                                // Analytics: Flurry
                                                [Flurry endTimedEvent:[FlurryManager getEventName:kFAContentFetch] withParameters:@{@"Error":@"No Content"}];
                                                currentContent= content;
                                                [self updateViewWithNewContent];
                                            }];
    
    // Analytics: Flurry
    [Flurry logEvent:[FlurryManager getEventName:kFAContentEach] withParameters:nil timed:YES];
    
}
- (void)animationButtonsForContentUpdate{
    // add animation: button
    [ContentViewHelper animateButtonWithSlideFromDownAndUpShoot:spreadButton withFinalAction:^(){
    }];
    [ContentViewHelper animateButtonWithSlideFromDownAndUpShoot:killButton withFinalAction:^(){
        [self updateViewWithNewContent];
    }];
    [ContentViewHelper animateButtonWithSlideFromDown:composeButton withFinalAction:^(){
    }];
    
}
- (void)updateViewWithNewContent{
    // post is done
    isPostActionActive=NO;
    [self.view layoutIfNeeded];
    
    //[ApiContent printContentInfo:currentContent];
    // change category color
    //[ContentViewHelper updateContentBackGroundView:contentBackGround forCategory:(kAPIContentCategory)currentContent.categoryId];
    

    
    // set text
    //contentTextView.text = currentContent.contentText;
    //contentTextView.attributedText = [ContentViewHelper getAttributedText:currentContent.contentText];
    contentTextView.attributedText = [ContentViewHelper getAttributedText:@"Put a bird on it +1 Helvetica, iPhone quinoa Kickstarter Blue Bottle tote bag McSweeney's Carles wayfarers. McSweeney's trust fund biodiesel actually, next level squid keffiyeh Williamsburg ennui semiotics Helvetica authentic. Selfies Etsy umami, narwhal chillwave Williamsburg small batch "];
    
    
    UIImage *bgImage = [ContentViewHelper getImageForContentBackGroudView];
    if([currentContent.photoToken isKindOfClass:[NSDictionary class]]
       && currentContent.photoToken[@"url"] &&
       (![currentContent.photoToken[@"url"] isEqual:[NSNull null]])){
        [contentBackGround setImageWithURL:[NSURL URLWithString:currentContent.photoToken[@"url"]]
                          placeholderImage:bgImage];
    }
    else{
        contentBackGround.image = bgImage;
    }
    
    //NSAttributedString *str = [[NSAttributedString alloc] initWithString:currentContent.contentText];
    //contentTextView.attributedText =str ;
    // center virtically
    //[AppUIManager  verticallyAlignTextView:contentTextView];
    //[self.view  updateConstraintsIfNeeded];
    
    // update counts
    //spreadCount.text = [NSString stringWithFormat:@"%ld", (long)currentContent.totalSpread.integerValue];
    ///timeCount.text = currentContent.timeStamp;
    //[self resetContentTimer];
}

#pragma mark -  View Design
- (void)setView {
    // set view
    [ContentViewHelper  setView:self.view];
    
    // set navigation bar
    //[self setNavigationBar];
    
    // set textview
    contentBackGround = [ContentViewHelper getContentBackGroundView];
    [self.view addSubview:contentBackGround];
    contentTextView = [ContentViewHelper getContentTextViewWithDelegate:self];
    [contentBackGround addSubview:contentTextView];
    
    //page logo
    pageLogo =[ContentViewHelper getPageLogoImageView];
    [self.view addSubview:pageLogo];
    
    // set buttons
    spreadButton = [ContentViewHelper getSpreadButton];
    [spreadButton addTarget:self action:@selector(spreadButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    killButton = [ContentViewHelper getKillButton];
    [killButton addTarget:self action:@selector(killButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    composeButton = [ContentViewHelper getComposeButton];
    [composeButton addTarget:self action:@selector(goToAddContentView:) forControlEvents:UIControlEventTouchUpInside];
    signInOutButton = [ContentViewHelper getSignInOutButton];
    [signInOutButton addTarget:self action:@selector(signInOutButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:spreadButton];
    [self.view addSubview:killButton];
    [self.view addSubview:composeButton];
    [self.view addSubview:signInOutButton];
    signInOutButton.hidden=YES;
    //
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
    activityIndicator =[[UIActivityIndicatorView alloc] init];
    [AppUIManager addActivityIndicator:activityIndicator toView:self.view];
    
    // layout
    [self layoutView];
    
    
    // add gestures
    [self addGestures];
    
    // scroll adjustment
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}

- (void)layoutView{
    // all view elements
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(contentTextView,contentBackGround,spreadButton,killButton,composeButton,signInOutButton,pageLogo);
    //NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(contentTextView,contentBackGround,spreadButton,killButton,composeButton,signInOutButton);
    
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[pageLogo(40)]"
                                                                      options:0 metrics:nil views:viewsDictionary]];
    [AppUIManager horizontallyCenterElement:pageLogo inView:self.view];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[signInOutButton(40)]"
                                                                      options:0 metrics:nil views:viewsDictionary]];
    [AppUIManager horizontallyCenterElement:signInOutButton inView:self.view];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-18-[pageLogo(35)]-4-[signInOutButton(40)]"
                                                                      options:0 metrics:nil views:viewsDictionary]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-18-[pageLogo(35)]-20-[contentTextView]-24-[spreadButton]"
                                                                      options:0 metrics:nil views:viewsDictionary]];
    
    
    // text view
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[contentBackGround]|"
                                                                      options:0 metrics:nil views:viewsDictionary]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[contentBackGround]|"
                                                                      options:0 metrics:nil views:viewsDictionary]];
    
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-16-[contentTextView]-16-|"
                                                                      options:0 metrics:nil views:viewsDictionary]];
    
    // buttons
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[spreadButton(72)]-16-|"
                                                                      options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-16-[killButton(spreadButton)]"
                                                                      options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[composeButton(55)]"
                                                                      options:0 metrics:nil views:viewsDictionary]];
    [AppUIManager horizontallyCenterElement:composeButton inView:self.view];
    
    [self.view addConstraints:              [NSLayoutConstraint constraintsWithVisualFormat:@"V:[spreadButton(72)]-42-|"
                                                                                    options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:              [NSLayoutConstraint constraintsWithVisualFormat:@"V:[killButton(spreadButton)]-42-|"
                                                                                    options:0 metrics:nil views:viewsDictionary]];
    
    [self.view addConstraints:              [NSLayoutConstraint constraintsWithVisualFormat:@"V:[composeButton(55)]-14-|"
                                                                                    options:0 metrics:nil views:viewsDictionary]];
    
}

- (void)setNavigationBar {
    // set up navigation bar
    //self.navigationItem.title = @"WoM";
    self.navigationItem.titleView = [AppUIManager getAppLogoViewForNavTitle];
    
    // right navigation button
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                              initWithBarButtonSystemItem:UIBarButtonSystemItemCompose
                                              target:self
                                              action:@selector(goToAddContentView:)];
    [self.navigationItem.rightBarButtonItem setAccessibilityLabel:@"Compose"];
    
    // left navigation button
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]
                                             initWithTitle:@"Sign In"
                                             style:UIBarButtonItemStyleDone
                                             target:self
                                             action:@selector(signInOutButtonPressed:)];
    
    // set up back button for the child view
    //    self.navigationItem.backBarButtonItem =  [[UIBarButtonItem alloc]
    //                                              initWithBarButtonSystemItem:UIBarButtonSystemItemStop
    //                                              target:nil
    //                                              action:nil];
}

- (void)addGestures{
    // Add swipeGestures
    oneFingerSwipeLeft = [[UISwipeGestureRecognizer alloc]
                          initWithTarget:self
                          action:@selector(swipeLeft:)];
    [oneFingerSwipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [[self view] addGestureRecognizer:oneFingerSwipeLeft];
    
    oneFingerSwipeRight = [[UISwipeGestureRecognizer alloc]
                           initWithTarget:self
                           action:@selector(swipeRight:)];
    [oneFingerSwipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [[self view] addGestureRecognizer:oneFingerSwipeRight];
}

- (void)updateSignInOutButtonTitle{
    // left navigation button
    if([[ApiManager sharedApiManager] isAnonymousUser]){
        //self.navigationItem.leftBarButtonItem.title = @"Sign In";
        [signInOutButton setImage:[UIImage imageNamed:kAUCLogInButtonImage] forState:UIControlStateNormal];
    }
    else{
        //self.navigationItem.leftBarButtonItem.title =@"Sign Out";
        [signInOutButton setImage:[UIImage imageNamed:kAUCSignOutButtonImage] forState:UIControlStateNormal];
    }
}

#pragma mark - Gesture Recognizers Action Methods
- (void)swipeLeft:(id)sender{
    [self killButtonPressed:nil];
}

- (void)swipeRight:(id)sender{
    [self spreadButtonPressed:nil];
}
#pragma mark - Button Action Methods
- (void)goToAddContentView:(id)sender {
    // set add content view
    ComposeViewController *acvc =[[ComposeViewController alloc] init];
    acvc.hidesBottomBarWhenPushed=YES;
    
    [self.navigationController pushViewController:acvc animated:NO];
}

- (void)signInOutButtonPressed:(id)sender {
    if(![[ApiManager sharedApiManager] isAnonymousUser]){
        // sign out user
        [activityIndicator startAnimating];
        [[ApiManager sharedApiManager] signOutUserSuccess:^(void){
            // Analytics: Flurry
            [Flurry logEvent:[FlurryManager getEventName:kFAUserSessionSignOut]];
            [activityIndicator stopAnimating];
            [self signedOutSuccessfully];
        }failure:^(NSError * error){
            [activityIndicator stopAnimating];
            //[ApiErrorManager displayAlertWithError:error withDelegate:self];
            // Do not display any error: just sign user out
            [self signedOutSuccessfully];
        }];
    }
    else{
        [self signedOutSuccessfully];
    }
}

#pragma mark - user_response methods
- (void) spreadButtonPressed:(id)sender {
    if(isPostActionActive){
        return;
    }
    isPostActionActive=YES;
    // Analytics: Flurry
    [Flurry logEvent:[FlurryManager getEventName:kFAContentSpread]];
    [self AddContentEachAnalytics:@"Spread"];
    // animate button
    [ContentViewHelper animateButtonWithSlideUpAndReturn:spreadButton
                                         withFinalAction:^(){
                                             [self postResponse:true];
                                         }];
    
    
    
}
- (void) killButtonPressed:(id)sender {
    if(isPostActionActive){
        return;
    }
    isPostActionActive=YES;
    // Analytics: Flurry
    [Flurry logEvent:[FlurryManager getEventName:kFAContentKill]];
    [self AddContentEachAnalytics:@"Kill"];
    
    // animate button
    [ContentViewHelper animateButtonWithSlideUpAndReturn:killButton
                                         withFinalAction:^(){
                                             [self postResponse:false];
                                         }];
}

- (void)AddContentEachAnalytics:(NSString *)type{
    // Analytics: Flurry
    [Flurry endTimedEvent:[FlurryManager getEventName:kFAContentEach] withParameters:@{@"Action":type}];
    
    // Analytics: Flurry
    [Flurry logEvent:[FlurryManager getEventName:kFAContentEach] withParameters:nil timed:YES];
}
#pragma mark - Session methods
- (void)signedOutSuccessfully{
    // go to sign in view
    [(AppDelegate *)[UIApplication sharedApplication].delegate  setSignInViewAsRootView];
}

#pragma mark - Post Response Method
- (void)postResponse:(BOOL)response{
    // check for empty content condition: do not post response
    if(currentContent.categoryId==kAPIContentCategoryEmpty){
        [self updateContent];
        return;
    }
    
    //DBLog(@"Content id: %d",currentContent.contentId.integerValue);
    // post content
    [activityIndicator startAnimating];
    
    // post content user
    [activityIndicator startAnimating];
    [[ApiManager sharedApiManager] postResponseWithContentId:currentContent.contentId.intValue
                                                    response:[NSNumber numberWithBool:response]
                                                     success:^(ApiUserResponse *response){
                                                         [activityIndicator stopAnimating];
                                                         [self actionsForSuccessfulPostResponse];
                                                     }failure:^(NSError * error){
                                                         [activityIndicator stopAnimating];
                                                         //[ApiErrorManager displayAlertWithError:error withDelegate:self];
                                                         // do not show any error just assume sucess
                                                         [self actionsForSuccessfulPostResponse];
                                                     }];
    
}

#pragma mark - Api Manager Post actions methods
- (void)actionsForSuccessfulPostResponse{
    [self updateContent];
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
