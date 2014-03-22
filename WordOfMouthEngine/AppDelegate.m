//
//  AppDelegate.m
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 11/8/13.
//  Copyright (c) 2013 Bijit Halder. All rights reserved.
//

#import "AppDelegate.h"
#import "SessionManager.h"
#import "SignInViewController.h"
#import "CoreFunctionViewController.h"
#import "AppUIAppearanceManager.h"

#import "SessionManager.h"

#import "DebugTestManager.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    // set session manager
    appSessionManager = [SessionManager sharedSessionManager];
    
    // set App wide appreance
    [AppUIAppearanceManager setAppAppearance];
    
    // view controllers
    [self setViewController];
    //self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    // run debug test ********
    [DebugTestManager runDebugTests];
    
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
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Root View Controller Set up methods
- (void)setViewController {
    // check if user is signed in
    if([appSessionManager isUsersignedIn]==YES ){
        [self setCoreFunctionViewAsRootView];
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
- (void)setCoreFunctionViewAsRootView{
    // show core functions
    if(coreFunctionViewController==nil) {
        coreFunctionViewController =[[CoreFunctionViewController alloc] init];
    }
    // select defalt tab
    coreFunctionViewController.selectedIndex = kCFVTabbarIndexContent;
    
    self.window.rootViewController=coreFunctionViewController;
}

@end
