//
//  CoreFunctionViewController.h
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 2/15/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppUIManager.h"

@class ContentViewController;
@class ComposeViewController;
//@class HistoryViewController;
@class ProfileViewController;
//@class SettingsViewController;

@interface CoreFunctionViewController : UITabBarController<UITabBarDelegate,UITabBarControllerDelegate>{
    
    //UINavigationController          *contentViewNavigationController;
    ContentViewController           *contentViewController;
    UINavigationController          *composeViewNavigationController;
    ComposeViewController           *composeViewController;
    //HistoryViewController           *historyViewController;
    ProfileViewController           *profileViewController;
    //SettingsViewController          *settingsViewController;
}

@end
