//
//  ContentViewController.m
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 2/15/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import "ContentViewController.h"
#import "AppUIManager.h"
#import "AddContentViewController.h"

@implementation ContentViewController

- (id)init
{
    if (self = [super init]) {
        // set tab bar
       /* self.navigationController.tabBarItem = [[UITabBarItem alloc]
                           initWithTitle:@"WoM"
                           image:[UIImage imageNamed:kAUCCoreFunctionTabbarImageContent]
                           tag:kCFVTabbarIndexContent];
        */
        
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

#pragma mark -  Local Methods Implememtation
- (void)setView {
    // set navigation bar
    [self setNavigationBar];
}
- (void)setNavigationBar {
    // set up navigation bar
    self.navigationItem.title = @"User name";
    
    // right navigation button
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                             initWithBarButtonSystemItem:UIBarButtonSystemItemCompose
                                              target:self
                                              action:@selector(goToAddContentView:)];
    
    
    // set up back button for the child view
    /* self.navigationItem.backBarButtonItem =  [[UIBarButtonItem alloc]
                                              initWithTitle:@"Cancel"
                                              style:UIBarButtonItemStyleDone
                                              target:nil
                                              action:nil];
     */
    

}


#pragma mark - Button Action Methods
- (void)goToAddContentView:(id)sender {
    // set add content view
    AddContentViewController *acvc =[[AddContentViewController alloc] init];
    acvc.hidesBottomBarWhenPushed=YES;
    
    [self.navigationController pushViewController:acvc animated:YES];
}


@end
