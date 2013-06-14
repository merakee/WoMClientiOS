//
//  AppDelegate.m
//  OpinionPlatfrom
//
//  Created by Bijit Halder on 6/13/13.
//  Copyright (c) 2013 Bijit Halder. All rights reserved.
//

#import "AppDelegate.h"
#import "CommonUtility.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // get app state
    [self getAppState];
    
    // Override point for customization after application launch.
    // set global styles
    //[CommonViewElementManager setGlobalStyles];
    
    // view controllers
    [self setViewController];
    
    // Override point for customization after application launch.
    //self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
        [self saveAppState];
    
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
[self saveAppState];
}

#pragma mark - View Set up methods
- (void)setViewController {
//    // practice
//    if(self.appState==kCRDAppStatePracticeView) {
//        if(practiceNavController==nil) {
//            if(practiceViewController==nil) {
//                practiceViewController =[[PracticeViewController alloc] init];
//            }
//            practiceNavController = [[UINavigationController alloc] initWithRootViewController:practiceViewController];
//        }
//        [self setWindowWithViewController:practiceNavController];
//        return;
//    }
//    
//    // Admin
//    if(self.appState==kCRDAppStateAdminView) {
//        if(adminViewController==nil) {
//            adminViewController =[[AdminViewController alloc] init];
//        }
//        
//        [self setWindowWithViewController:adminViewController];
//        return;
//    }
//    
//    // StudentAdmin
//    if(self.appState==kCRDAppStateStudentAdminView) {
//        if(studentAdminViewController==nil) {
//            studentAdminViewController =[[StudentAdminViewController alloc] init];
//        }
//        
//        [self setWindowWithViewController:studentAdminViewController];
//        return;
//    }
//    
//    // start pactice view to cut down time - temp fix
//    if(practiceNavController==nil) {
//        if(practiceViewController==nil) {
//            practiceViewController =[[PracticeViewController alloc] init];
//        }
//        practiceNavController = [[UINavigationController alloc] initWithRootViewController:practiceViewController];
//    }
//    
//    // default - home view
//    if(homeViewController==nil) {
//        homeViewController =[[HomeViewController alloc] init];
//    }
//    [self setWindowWithViewController:homeViewController];
}

- (void)setWindowWithViewController:(UIViewController *)vc {
    // remove all
    for(UIView *view in self.window.subviews) {
        [view removeFromSuperview];
    }
    // add view
    //[self.window addSubview:vc.view];
    [self.window setRootViewController:vc];
}
#pragma mark - Button Action Methods
//- (void)goToHomeView:(id)sender {
//    self.appState=kCRDAppStateHomeView;
//    [self setViewController];
//}
//
//- (void)goToPracticeView:(id)sender {
//    self.appState=kCRDAppStatePracticeView;
//    [self setViewController];
//}
//- (void)goToAdminView:(id)sender {
//    self.appState=kCRDAppStateAdminView;
//    [self setViewController];
//}
//- (void)goToStudentAdminView:(id)sender {
//    self.appState=kCRDAppStateStudentAdminView;
//    [self setViewController];
//}

#pragma mark - screen orientation
//- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
//    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
//        /* ipad */
//        return UIInterfaceOrientationMaskAll;
//    }
//    else{
//        /* iphone */
//        return UIInterfaceOrientationMaskAllButUpsideDown;
//    }
//}

#pragma mark - persistence mathods
- (void)getAppState {
    //self.appState = kCRDAppStateHomeView;
    //[DatabaseManager getAppState:appState];
    // DBLog(@"get app state: %d",appState);
    
}
- (void)saveAppState {
    //DBLog(@"save app state: %d",appState);
    //[DatabaseManager saveAppState:appState];
}

#pragma mark -  Store (In App Purchase) observer methods
- (void)addStoreToApp {
    // Call StoreController to Add Store
    // NEED TO ADD THIS TO APP DELEGATE: application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
    //     add in app purchase transation observer
    //if(kIsStoreActive){
    //  [StoreController addTransactionObserverIfNeeded];
    //}
}

#pragma mark -  Debug Test Methods (TDD flavor)
- (void)runDebugTests {
    if(IS_DEBUG) {
        DBLog(@"DEBUG TEST....................START");
        //[DebugTest testAll];
        DBLog(@"DEBUG TEST....................END");
    }
}


@end
