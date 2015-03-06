//
//  SettingsViewController.h
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 2/15/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>{

    UITableView             *settingsTableView;
    
    // Navigation bar
    UIView      *navigationView;
    UIButton    *cancelButton;
    UILabel     *settingsTitle;
}

@end
