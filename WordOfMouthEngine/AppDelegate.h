//
//  AppDelegate.h
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 11/8/13.
//  Copyright (c) 2013 Bijit Halder. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SignInViewController;
//@class CoreFunctionViewController;
@class ContentViewController;
@class ApiManager;

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    UINavigationController              *signInNavigationController;
    SignInViewController                *signInViewController;
    //CoreFunctionViewController          *coreFunctionViewController;
    ContentViewController               *contentViewController;
    UINavigationController              *contentViewNavigationController;
    
    // API Manager manager
    ApiManager                      *sharedApiManager;
}

@property (strong, nonatomic) UIWindow *window;


# pragma mark - App Delegate methods
- (void)setSignInViewAsRootView;
//- (void)setCoreFunctionViewAsRootView;
- (void)setContentViewAsRootView;
- (void)clearContents;
@end
