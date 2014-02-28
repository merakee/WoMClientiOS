//
//  CoreFunctionViewController.m
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 2/15/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import "CoreFunctionViewController.h"
//#import "CoreFunctionViewHelper.h"


#import "ContentViewController.h"
#import "ComposeViewController.h"
//#import "HistoryViewController.h"
#import "ProfileViewController.h"
//#import "SettingsViewController.h"


@implementation CoreFunctionViewController

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

#pragma mark - Tababr Delegate methods
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed {
    
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController willBeginCustomizingViewControllers:(NSArray *)viewControllers {
    
}

- (void)tabBarController:(UITabBarController *)tabBarController willEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed {
    
}


#pragma mark -  Local Methods Implememtation
- (void)setView {
    // set tap bar
    [self setTapBar];
    // content view
    contentViewController =[[ContentViewController alloc] init];
    //contentViewNavigationController = [[UINavigationController alloc]
    //                                   initWithRootViewController:contentViewController];
    // set tab bar
    //contentViewNavigationController.tabBarItem = [[UITabBarItem alloc]
    //                                       initWithTitle:@"WoM"
    //                                      image:[UIImage imageNamed:kAUCCoreFunctionTabbarImageContent]
    //                                       tag:kCFVTabbarIndexContent];
    
    // compose view
    composeViewController =[[ComposeViewController alloc] init];
    
    composeViewNavigationController = [[UINavigationController alloc]
                                       initWithRootViewController:composeViewController];
    // set tab bar
    composeViewNavigationController.tabBarItem = [[UITabBarItem alloc]
                                                  initWithTitle:@"Compose"
                                                  image:[UIImage imageNamed:kAUCCoreFunctionTabbarImageCompose]
                                                  tag:kCFVTabbarIndexCompose];
    
    [AppUIManager setNavbar:composeViewController.navigationController.navigationBar];
    
    composeViewController.hidesBottomBarWhenPushed=YES;
    
    
    // history view
    //historyViewController =[[HistoryViewController alloc] init];
    // profile view
    profileViewController =[[ProfileViewController alloc] init];
    // settings view
    //settingsViewController =[[SettingsViewController alloc] init];
    
    // set tabs: create tabbar view controller
    NSMutableArray *viewControllersArray =[[NSMutableArray alloc] init];
    [viewControllersArray insertObject:contentViewController atIndex:kCFVTabbarIndexContent];
    [viewControllersArray insertObject:composeViewNavigationController atIndex:kCFVTabbarIndexCompose];
    //[viewControllersArray insertObject:historyViewController atIndex:kCFVTabbarIndexHistory];
    [viewControllersArray insertObject:profileViewController atIndex:kCFVTabbarIndexProfile];
    //[viewControllersArray insertObject:settingsViewController atIndex:kCFVTabbarIndexSettings];
    [self setViewControllers:viewControllersArray animated:YES];
}

- (void)setTapBar{
    // App default settings
    [AppUIManager setTabbar:self.tabBar];
    // customs settings
    
}
@end
