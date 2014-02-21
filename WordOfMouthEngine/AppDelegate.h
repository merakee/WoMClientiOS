//
//  AppDelegate.h
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 11/8/13.
//  Copyright (c) 2013 Bijit Halder. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SignInViewController;
@class CoreFunctionViewController;
@class SessionManager;

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    UINavigationController              *signInNavigationController;
    SignInViewController                 *signInViewController;
    CoreFunctionViewController          *coreFunctionViewController;
    
    // Session manager
    SessionManager                      *appSessionManager;
}

@property (strong, nonatomic) UIWindow *window;


# pragma mark - App Delegate methods
- (void)setSignInViewAsRootView;
- (void)setCoreFunctionViewAsRootView;
@end
