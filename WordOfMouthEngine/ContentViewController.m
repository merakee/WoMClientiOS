//
//  ContentViewController.m
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 2/15/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import "ContentViewController.h"
#import "ContentViewHelper.h"
#import "AppUIManager.h"
#import "ComposeViewController.h"
#import "SessionManager.h"

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
    
    // init conent
    contentInfo =[[ContentInfo  alloc] init];
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
    self.navigationItem.title = [SessionManager currentUser].userName;
    
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
    contentInfo = [ContentManager getContent];
    contentTextView.text = contentInfo.contentBody;
}


#pragma mark -  View Design
- (void)setView {
    // set view
    self.view.backgroundColor =[UIColor whiteColor];
    // set navigation bar
    //[self setNavigationBar];
    
    // set textview
    contentTextView =[[UITextView alloc] init];
    [ContentViewHelper setContentTextView:contentTextView withDelegate:self];
    [self.view addSubview:contentTextView];
    
    // set buttons
    spreadButton = [ContentViewHelper getSpreadButton];
    [spreadButton addTarget:self action:@selector(spreadButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    killButton = [ContentViewHelper getKillButton];
    [killButton addTarget:self action:@selector(killButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:spreadButton];
    [self.view addSubview:killButton];
    
    // set Textlabels
    
    
    // layout
    [self layoutView];
    
}

- (void)layoutView{
    // all view elements
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(spreadButton,killButton,contentTextView);
    
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
    [self.view addConstraints:              [NSLayoutConstraint constraintsWithVisualFormat:@"V:[killButton(30)]-60-|"
                                                                                    options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:              [NSLayoutConstraint constraintsWithVisualFormat:@"V:[spreadButton(30)]-60-|"
                                                                                    options:0 metrics:nil views:viewsDictionary]];
    
    // text view
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[contentTextView(>=100)]-|"
                                                                      options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-76-[contentTextView]-10-[killButton]"
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

@end
