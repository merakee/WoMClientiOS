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
    self.view.backgroundColor =[UIColor whiteColor];
    
    // set navigation bar
    [self setNavigationBar];
    
    // set TextView
    composeTextView =[[UITextView alloc] init];
    [ComposeViewHelper setContentTextView:composeTextView withDelegate:self];
    [self.view addSubview:composeTextView];
    
    
    // layout
    [self layoutView];
}

- (void)layoutView{
    // all view elements
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(composeTextView);
    // text filed
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[composeTextView(>=100)]-|"
                                                                      options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-76-[composeTextView]-218-|"
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
                                              action:@selector(goBack:)];
    
}

#pragma mark -  Local Methods Implememtation

- (void)clearTextView{
    composeTextView.text=@"";
}

- (BOOL)isPostValid{
    return ([composeTextView.text length]>5);
}
#pragma mark - Button Action Methods
- (void)postContent:(id)sender {
    // check post
    if([self isPostValid]){
        // post content and add to history
        ContentInfo *ci =[[ContentInfo alloc] init];
        ci.contentBody = composeTextView.text;
        [contentManager postContent:ci];
        return;
    }
    
    // if invalid
    [CommonUtility displayAlertWithTitle:@"Invalid Post" message:@"Post is too short. Please add more to post." delegate:self];

}

- (void)goBack:(id)sender {
    // go back
    [self.navigationController popViewControllerAnimated:NO];
}


# pragma mark - Content Manager Delegate methods
- (void)contentPostedSuccessfully{
    //DBLog(@"Post successful...");
    [CommonUtility displayActionSheetWithTitle:@"Post successful. Do you want to post another?"
                                  cancelButton:@"Yes"
                             destructiveButton:@"No"
                                 customButtons:nil
                                      delegate:self];
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
