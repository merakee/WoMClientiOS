//
//  AppDelegate.m
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 11/8/13.
//  Copyright (c) 2013 Bijit Halder. All rights reserved.
//

#import "AppDelegate.h"
#import "ApiManager.h"
#import "SignInViewController.h"
//#import "CoreFunctionViewController.h"
#import "ContentViewController.h"
#import "AppUIAppearanceManager.h"
#import "AFNetworkActivityIndicatorManager.h"

#import "ApiManager.h"

#import "DebugTestManager.h"

#import "FlurryManager.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    // API and Network set up- set it before views
    [self setApiManagerAndNetwork];
    
    // set App wide appreance
    [AppUIAppearanceManager setAppAppearance];
    
    // view controllers
    [self setViewController];
    //self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    // run debug test ********
    [DebugTestManager runDebugTests];
    
    // Analytics
    //note: iOS only allows one crash reporting tool per app; if using another, set to: NO
    [Flurry setCrashReportingEnabled:YES];
    
    // Replace YOUR_API_KEY with the api key in the downloaded package
    [Flurry startSession:[FlurryManager getKey]];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [sharedApiManager performEnteredBackgroundActions];
    // clear contents
    [self clearContents];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    if(![sharedApiManager isUserSignedIn]){
        [self  setSignInViewAsRootView];
    }else{
        if(contentViewController){
            [contentViewController refreshContent];
        }
    }
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    // clear contents
    [self clearContents];
}

#pragma mark - Root View Controller Set up methods
- (void)setApiManagerAndNetwork{
    // set api manager
    sharedApiManager = [ApiManager sharedApiManager];
    // start reachability manager
    //[sharedApiManager.reachabilityManager startMonitoring];
    // set Network Activity indicator
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
}
- (void)setViewController {
    [self preloadContentView];
    
    // check if user is signed in
    if([sharedApiManager isUserSignedIn]==YES ){
        [self setContentViewAsRootView];
    }
    else{
        [self setSignInViewAsRootView];
    }
}

- (void)setSignInViewAsRootView{
    // show sign in view
    if(signInNavigationController==nil){
        signInNavigationController =[[UINavigationController alloc] init];
    }
    if(signInViewController==nil) {
        signInViewController =[[SignInViewController alloc] init];
    }
    // set root view controller
    [signInNavigationController setViewControllers:@[signInViewController]];
    
    self.window.rootViewController=signInNavigationController;
}

- (void)preloadContentView{
    // preload content view
    contentViewController =[[ContentViewController alloc] init];
    UIView *view = contentViewController.view;
    if(view){} // to void waring about unused variable
}
//- (void)setCoreFunctionViewAsRootView{
//    // show core functions
//    if(coreFunctionViewController==nil) {
//        coreFunctionViewController =[[CoreFunctionViewController alloc] init];
//    }
//    // select defalt tab
//    coreFunctionViewController.selectedIndex = kCFVTabbarIndexContent;
//
//    self.window.rootViewController=coreFunctionViewController;
//}

- (void)setContentViewAsRootView{
    // show core functions
    if(contentViewController==nil) {
        contentViewController =[[ContentViewController alloc] init];
    }
    if(contentViewNavigationController ==nil){
        contentViewNavigationController = [[UINavigationController alloc]
                                           initWithRootViewController:contentViewController];
        
    }
    // make sure it is root view
    [contentViewNavigationController popToRootViewControllerAnimated:NO];
    
    self.window.rootViewController=contentViewNavigationController;
}
- (void)clearContents{
    if(contentViewController){
        [contentViewController clearContents];
    }
}
@end
