//
//  SettingsViewController.h
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 2/15/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
@interface SettingsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, MFMailComposeViewControllerDelegate>{

    UITableView             *settingsTableView;
    
    // Navigation bar
    UIView      *navigationView;
    UIButton    *cancelButton;
    UILabel     *settingsTitle;
    
    // Text Fields
    UITextField *nicknameTextField;
    UITextField *currentCityField;
    UITextField *emailField;
    UITextField *changePasswordField;

    UITextField *currentPassword;
    UITextField *newPassword;
    MFMailComposeViewController *mail;
}

@end
