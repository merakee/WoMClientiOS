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

@implementation ContentViewController

- (id)init
{
    if (self = [super init]) {
        
        self.tabBarItem = [[UITabBarItem alloc]
                           initWithTitle:@"WoM"
                           image:[UIImage imageNamed:kAUCCoreFunctionTabbarImageContent]
                           tag:kCFVTabbarIndexContent];
        
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
    contentInfo =[[ApiContent  alloc] init];
}

- (void) viewDidLayoutSubviews {
    
    
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
    
    // set up navigation bar
    self.navigationItem.title = [[ApiManager sharedApiManager] currentUser].email;
    
    userImage.image = [UIImage imageNamed:@"UserImage.png"];
    
}

- (void)viewDidAppear:(BOOL)animated{
    // update content
    [self updateContent];
    
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

#pragma mark -  Content Display method
- (void)updateContent{
    // update content
    contentInfo = [contentManager getContent];
    // change category color
    [ContentViewHelper updateTextBackGroundView:textBackGround forCategory:(ACMContentCategory)contentInfo.categoryId];
    
    contentTextView.text = contentInfo.contentText;
    //NSAttributedString *str = [[NSAttributedString alloc] initWithString:contentInfo.contentText];
    //contentTextView.attributedText =str ;
    // center virtically
    [AppUIManager  verticallyAlignTextView:contentTextView];
    //[self.view  updateConstraintsIfNeeded];
    
    // update counts
    spreadCount.text = [NSString stringWithFormat:@"%ld", (long)contentInfo.totalSpread];
    ///timeCount.text = contentInfo.timeStamp;
    [self resetContentTimer];
}

#pragma mark -  View Design
- (void)setView {
    // set view
    [ContentViewHelper  setView:self.view];
    
    // set navigation bar
    //[self setNavigationBar];
    
    // set textview
    textBackGround = [ContentViewHelper getTextBackGroundView];
    [self.view addSubview:textBackGround];
    contentTextView = [ContentViewHelper getContentTextViewWithDelegate:self];
    [textBackGround addSubview:contentTextView];
    
    // set buttons
    spreadButton = [ContentViewHelper getSpreadButton];
    [spreadButton addTarget:self action:@selector(spreadButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    killButton = [ContentViewHelper getKillButton];
    [killButton addTarget:self action:@selector(killButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:spreadButton];
    [self.view addSubview:killButton];
    
    // set Textlabels and progress view
    spreadCount = [ContentViewHelper getTextLabelForSpreadCount];
    [self.view addSubview:spreadCount];
    progressCounter =[ContentViewHelper getCounterViewWithDelegate:self];
    [self.view addSubview:progressCounter];
    
    // image view
    userImage = [ContentViewHelper getUserImageView];
    [self.view addSubview:userImage];
    
    
    // layout
    [self layoutView];
    
    // scroll adjustment
    //self.automaticallyAdjustsScrollViewInsets = NO;
    
}

- (void)layoutView{
    // all view elements
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(userImage, spreadCount,contentTextView, spreadButton,killButton,textBackGround,progressCounter);
    
    // top row : user image and labels
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[userImage(36)]-34-[spreadCount(>=100)]-20-[progressCounter(36)]-|"
                                                                      options:0 metrics:nil views:viewsDictionary]];
    
    [self.view addConstraints:              [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[userImage(36)]"
                                                                                    options:0 metrics:nil views:viewsDictionary]];
    
    [self.view addConstraints:              [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[spreadCount(36)]"
                                                                                    options:0 metrics:nil views:viewsDictionary]];
    
    [self.view addConstraints:              [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[progressCounter(36)]"
                                                                                    options:0 metrics:nil views:viewsDictionary]];
    
    //[self.view addConstraints:              [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[progressClock(36)]"
    //                                                                           options:0 metrics:nil views:viewsDictionary]];
    
    
    
    // text view
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[textBackGround(>=100)]|"
                                                                      options:0 metrics:nil views:viewsDictionary]];
    
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[contentTextView(>=100)]-|"
                                                                      options:0 metrics:nil views:viewsDictionary]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[spreadCount]-[textBackGround]-10-[killButton]"
                                                                      options:0 metrics:nil views:viewsDictionary]];
    
    /*
     [self.view addConstraint:[NSLayoutConstraint constraintWithItem:contentTextView
     attribute:NSLayoutAttributeCenterY
     relatedBy:NSLayoutRelationEqual
     toItem:textBackGround
     attribute:NSLayoutAttributeCenterY
     multiplier:1.0
     constant:0.0]];
     */
    
    //[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[contentTextView(>=100)]-|"
    //                                                                 options:0 metrics:nil views:viewsDictionary]];
    
    
    
    // buttons
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[killButton(spreadButton)]-12-[spreadButton]-|"
                                                                      options:0 metrics:nil views:viewsDictionary]];
    // Center
    /*
     [self.view addConstraint:[NSLayoutConstraint constraintWithItem:killButton
     attribute:NSLayoutAttributeCenterX
     relatedBy:NSLayoutRelationEqual
     toItem:self.view
     attribute:NSLayoutAttributeCenterX
     multiplier:1.0
     constant:-46]];
     */
    
    [self.view addConstraints:              [NSLayoutConstraint constraintsWithVisualFormat:@"V:[killButton(30)]-10-|"
                                                                                    options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:              [NSLayoutConstraint constraintsWithVisualFormat:@"V:[spreadButton(30)]-10-|"
                                                                                    options:0 metrics:nil views:viewsDictionary]];
    
    
    
    
    
}

- (void)setNavigationBar {
    
    // right navigation button
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                              initWithBarButtonSystemItem:UIBarButtonSystemItemCompose
                                              target:self
                                              action:@selector(goToAddContentView:)];
    
    
    // set up back button for the child view
    self.navigationItem.backBarButtonItem =  [[UIBarButtonItem alloc]
                                              initWithTitle:@"Cancel"
                                              style:UIBarButtonItemStylePlain
                                              target:nil
                                              action:nil];
}


#pragma mark - Button Action Methods
- (void)goToAddContentView:(id)sender {
    // set add content view
    ComposeViewController *acvc =[[ComposeViewController alloc] init];
    acvc.hidesBottomBarWhenPushed=YES;
    
    [self.navigationController pushViewController:acvc animated:NO];
}

- (void) spreadButtonPressed:(id)sender {
    [ContentManager spreadContent:contentInfo];
    [self updateContent];
    
}
- (void) killButtonPressed:(id)sender {
    [ContentManager killContent:contentInfo];
    [self updateContent];
}

#pragma mark -  Progress view methods
- (void)updateProgressViewWithValue:(CGFloat)value{
    //[progressClock setProgress:value animated:YES];
}

#pragma mark - Timer Methods
- (void)onTimerTask:(NSTimer *)timer {
    // update reminaing time
    timeRemaining -=1.0;
    if(timeRemaining>=0){
        [self updateProgressViewWithValue:timeRemaining];
    }
    
    if(timeRemaining<=0){
        // stop the clock
        [self setTimerOff:progressTimer];
    }
}

- (void)setTimerOn {
    progressTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(onTimerTask:) userInfo:nil repeats:YES];
}

- (void)resetTimerCount {
    
}
- (void)setTimerOff:(NSTimer *)timer {
    if([timer isValid]) {
        [timer invalidate];
    }
    timer = nil;
}
- (void)resetContentTimer{
    [progressCounter stop];
    [progressCounter startWithSeconds:kAUCAppContentTimerMax];
}

#pragma mark - CircleCounterViewDelegate methods
- (void)counterDownFinished:(CVCircleCounterView *)circleView {
    //update content
    [self updateContent];
}

- (void)counter:(CVCircleCounterView *)circleView updatedWithValue:(float)timeInSeconds{
    //if(timeInSeconds<=kAUCAppContentTimerWarning){
        //circleView.circleColor = [UIColor redColor];
        //circleView.numberColor = [UIColor redColor];
        // }
}

@end
