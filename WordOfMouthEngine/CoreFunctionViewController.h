//
//  CoreFunctionViewController.h
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 2/15/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ContentViewController;
@class HistoryViewController;
@class ProfileViewController;
@class SettingsViewController;

@interface CoreFunctionViewController : UITabBarController<UITabBarDelegate>{
    
    UINavigationController          *contentViewNavigationController;
    ContentViewController           *contentViewController;
    HistoryViewController           *historyViewController;
    ProfileViewController           *profileViewController;
    SettingsViewController          *settingsViewController;
}

@end
