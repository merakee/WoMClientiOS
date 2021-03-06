//
//  AddContentViewController.m
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 2/15/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import "ComposeViewController.h"
#import "ComposeViewHelper.h"

@implementation ComposeViewController

- (id)init
{
    if (self = [super init]) {
        // set tab bar
        // self.tabBarItem = [[UITabBarItem alloc]
        //                   initWithTitle:@"Post"
        //                  image:[UIImage imageNamed:kAUCCoreFunctionTabbarImageCompose]
        //                 tag:kCFVTabbarIndexCompose];
        
        // init conent manager
        contentManager = [[ContentManager alloc] init];
        contentManager.delegate = self;
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
    
    // display key board
    [composeTextView becomeFirstResponder];
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
    [self updateViewForCategory:kContentCategoryOther];
    
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
    
    // set Category control
    categoryControl = [ComposeViewHelper getCategoryControl];
    [categoryControl addTarget:self action:@selector(selectedCategoryChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:categoryControl];
    
    // set TextView
    composeTextView = [ComposeViewHelper getComposeTextViewWithDelegate:self];
    
    [self.view addSubview:composeTextView];
    
    
    // layout
    [self layoutView];
    
    // scroll adjustment
    //self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)layoutView{
    // all view elements
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(categoryControl,composeTextView);
    // text filed
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[composeTextView(>=100)]-|"
                                                                      options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[categoryControl(>=100)]-|"
                                                                      options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-68-[categoryControl]-8-[composeTextView]-218-|"
                                                                      options:0 metrics:nil views:viewsDictionary]];
}

- (void)setNavigationBar {
    // set up navigation bar
    self.navigationItem.title = @"Compose";
    
    // right navigation button
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                              initWithTitle:@"Post"
                                              style:UIBarButtonItemStyleDone
                                              target:self
                                              action:@selector(postContent:)];
    
    self.navigationItem.leftBarButtonItem =  [[UIBarButtonItem alloc]
                                              initWithTitle:@"Cancel"
                                              style:UIBarButtonItemStyleDone
                                              target:self
                                              action:@selector(cancelPost:)];
    //action:@selector(goBack:)];
}

- (void)updateViewForCategory:(ACMContentCategory)category{
    [ComposeViewHelper updateCategoryControl:categoryControl forCategory:category];
    composeTextView.backgroundColor =[AppUIManager getContentColorForCategory:category];
}
#pragma mark -  Local Methods Implememtation

- (void)clearTextView{
    composeTextView.text=@"";
}
#pragma mark - Button Action Methods
- (void)postContent:(id)sender {
    // attempt to post content
    ContentInfo *ci =[[ContentInfo alloc] init];
    ci.contentBody = [CommonUtility trimString:composeTextView.text];
    if(categoryControl.selectedSegmentIndex==UISegmentedControlNoSegment){
        ci.categoryId = kContentCategoryOther;
    }
    else{
        ci.categoryId = categoryControl.selectedSegmentIndex+1;
    }
    
    [contentManager postContent:ci];
}
- (void)goBack:(id)sender {
    // go back
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)cancelPost:(id)sender {
    // clear post
    [self clearTextView];
    // go back to content view
    self.tabBarController.selectedIndex = kCFVTabbarIndexContent;
}

#pragma mark - control events methods
- (void)selectedCategoryChanged:(id)sender{
    // update colors
    ACMContentCategory category = (ACMContentCategory) [(UISegmentedControl *)sender selectedSegmentIndex]+1;
    [self updateViewForCategory:category];
}

# pragma mark - Content Manager Delegate methods
- (void)contentPostedSuccessfully{
    //DBLog(@"Post successful...");
    [CommonUtility displayAlertWithTitle:@"Post successful" message:@"Your content was posted." delegate:self];
    //[CommonUtility displayActionSheetWithTitle:@"Post successful. Do you want to post another?"
    //                            cancelButton:@"Yes"
    //                        destructiveButton:@"No"
    //                           customButtons:nil
    //                                delegate:self];
    
    // clear post
    [self clearTextView];
}

- (void)contentPostFailedWithError:(NSError *)error{
    [CommonUtility displayAlertWithTitle:error.localizedDescription message:error.localizedRecoverySuggestion delegate:self];
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
        [self clearTextView];
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


@end
