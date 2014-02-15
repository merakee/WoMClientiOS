//
//  AppDelegate.h
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 11/8/13.
//  Copyright (c) 2013 Bijit Halder. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LogInViewController;
@class CoreFunctionViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    LogInViewController                 *logInViewController;
    CoreFunctionViewController          *coreFunctionViewController;
}

@property (strong, nonatomic) UIWindow *window;

@end
