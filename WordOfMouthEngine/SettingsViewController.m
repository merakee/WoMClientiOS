//
//  SettingsViewController.m
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 2/15/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import "SettingsViewController.h"
#import "SettingsViewHelper.h"
#import "AppUIManager.h"
#import "ApiManager.h"
#import "FlurryManager.h"
#import "SignInAndOutViewController.h"
#import "SettingsTableViewCell.h"
#import "SignInViewController.h"

@implementation SettingsViewController {

}

#pragma mark -  init methods

- (id)init{
    if (self = [super init]) {
        self.tabBarItem = [[UITabBarItem alloc]
                           initWithTitle:@"Settings"
                           image:nil//[UIImage imageNamed:kAUCCoreFunctionTabbarImageSettings]
                           tag:0];//kCFVTabbarIndexSettings];
    }
    return self;
}

#pragma mark -  View Life cycle Methods

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
    [super loadView];
    [self setView];
}
- (void)viewDidLoad{
    self.automaticallyAdjustsScrollViewInsets = YES;
    [super viewDidLoad];
}
- (void)viewDidUnload{
    [super viewDidUnload];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
- (BOOL)shouldAutorotate{
    return  YES;
}
- (NSUInteger)supportedInterfaceOrientations{
    return [AppUIManager getSupportedOrentation];
}
- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -  Local Methods Implememtation
- (void)setView {
    self.navigationController.toolbarHidden = YES;
    self.edgesForExtendedLayout=UIRectEdgeNone;
  //  self.title = @"Settings";
    self.view.backgroundColor = [CommonUtility getColorFromHSBACVec:kAUCBorderColor];
    
    [self setupTableView];
    
    navigationView = [SettingsViewHelper getNavigationView];
    [self.view addSubview:navigationView];
    cancelButton = [SettingsViewHelper getCancelButton];
    [cancelButton addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    [navigationView addSubview:cancelButton];
    settingsTitle = [SettingsViewHelper getSettingsTitle];
    [navigationView addSubview:settingsTitle];
    [self.view addSubview:settingsTableView];
    
    nicknameTextField = [SettingsViewHelper getNicknameField];
    currentCityField = [SettingsViewHelper getCurrentCityField];
    emailField = [SettingsViewHelper getEmailField];
    [self layoutView];
}
- (void)layoutView{
    
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(settingsTableView, navigationView, cancelButton, settingsTitle, nicknameTextField);
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[settingsTableView(320)]"                                                                      options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[navigationView(44)]-0-[settingsTableView]|"                                                                      options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[navigationView(320)]"                                                                      options:0 metrics:nil views:viewsDictionary]];
    
    [navigationView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[cancelButton(22)]"                                                                      options:0 metrics:nil views:viewsDictionary]];
    [navigationView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[cancelButton(22)]"                                                                      options:0 metrics:nil views:viewsDictionary]];
    [navigationView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[settingsTitle(22)]"                                                                      options:0 metrics:nil views:viewsDictionary]];
    [AppUIManager horizontallyCenterElement:settingsTitle inView:navigationView];
    [AppUIManager verticallyCenterElement:settingsTitle inView:navigationView];
    [AppUIManager verticallyCenterElement:cancelButton inView:navigationView];
}

- (void) setupTableView{
    settingsTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
   // settingsTableView.style = UITableViewStyleGrouped;
    settingsTableView.delegate = self;
    settingsTableView.dataSource = self;
    [settingsTableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    settingsTableView.backgroundColor = [UIColor whiteColor];
    // ios7
    if ([ settingsTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [ settingsTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    // ios 8
    if ([ settingsTableView respondsToSelector:@selector(layoutMargins)]) {
         settingsTableView.layoutMargins = UIEdgeInsetsZero;
    }
    // [self.settingsTableView setSeparatorColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"mapicon.jpeg"]]];
    [settingsTableView setSeparatorColor:[CommonUtility getColorFromHSBACVec:kAUCBorderColor]];

    settingsTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth |
    UIViewAutoresizingFlexibleHeight;

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 10;
    }
    else 
    return 20; // you can have your own choice, of course
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
//    if (section == 0){
//        return 1;
//    }
//    else if (section == 1){
//    return 4;
//    }
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    SettingsTableViewCell *cell = (SettingsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];


    if (!cell) {
        cell = [[SettingsTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
//        cell = [[SettingsTableViewCell alloc] init];
        }
//    NSDictionary *dictionary = NSDictionaryOfVariableBindings(nicknameTextField, currentCityField, emailField);
    switch (indexPath.row) {
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        case 0:
            cell.textLabel.text = @"Nickname";
            cell.detailTextLabel.text = nicknameTextField.text;
            break;
        case 1:
            cell.textLabel.text = @"Current City";
            cell.detailTextLabel.text = currentCityField.text;
//            [cell addSubview:currentCityField];
//            currentCityField.delegate = self;
//            [cell addConstraints:[NSLayoutConstraint
//                                  constraintsWithVisualFormat:@"H:[currentCityField]-15-|"
//                                  options:0
//                                  metrics:nil
//                                  views:dictionary]];
//            [AppUIManager verticallyCenterElement:currentCityField inView:cell];
            break;
        case 2:
            cell.textLabel.text = @"Email";
            cell.detailTextLabel.text = emailField.text;
            break;
        case 3:
            cell.textLabel.text = @"Change Password";
            break;
        case 4:
            cell.textLabel.text = @"Help";
            break;
        case 5:
            cell.textLabel.text = @"Share";
            break;
        case 6:
            cell.textLabel.text = @"Rate";
            break;
        case 7:
            cell.textLabel.text = @"Log out";
            break;
        default:
            break;
    }
    if ([cell respondsToSelector:@selector(layoutMargins)]) {
        cell.layoutMargins = UIEdgeInsetsZero;
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
#pragma mark - Customize cell
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.textLabel.font = [UIFont fontWithName:kAUCFontFamilySecondary size:kAUSSettingsSizeText];
 //   cell.backgroundColor = [UIColor greenColor]; //must do here in willDisplayCell
 //   cell.textLabel.backgroundColor = [UIColor redColor]; //must do here in willDisplayCell
    cell.textLabel.textColor = [CommonUtility getColorFromHSBACVec:kAUSSettingColor]; //can do here OR in cellForRowAtIndexPath
    // Arrow on right side of tableview
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    cell.accessoryView.backgroundColor = [UIColor purpleColor];
    // Image for accessory View, size should be 25x25
//     UIImageView *accessoryImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mapicon.jpeg"]];
//    [accessoryImage setFrame:CGRectMake(0, 0, 28.0, 28.0)];
//    accessoryImage.contentMode = UIViewContentModeScaleAspectFit;
//    cell.accessoryView = accessoryImage;
}

#pragma mark -  Table view delegate
//- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
//{
//   if([view isKindOfClass:[UITableViewHeaderFooterView class]]){
//        
//        UITableViewHeaderFooterView *tableViewHeaderFooterView = (UITableViewHeade'rFooterView *) view;
//        tableViewHeaderFooterView.textLabel.textColor = [UIColor blueColor];
//    }
//}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    return @"User Settings - To be implemented";
//}

// Set custom font/size for title of cell

//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 18)];
//    /* Create custom view to display section header... */
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, tableView.frame.size.width, 18)];
//    [label setFont:[UIFont boldSystemFontOfSize:12]];
//    NSArray const *testArray = [NSArray arrayWithObjects:  @"Login", @"Settings", nil];
//    NSString *string =[testArray objectAtIndex:section];
//
//    [label setText:string];
//
//    /* Section header is in 0th index... */
//    [view addSubview:label];
//    [view setBackgroundColor:[UIColor colorWithRed:166/255.0 green:177/255.0 blue:186/255.0 alpha:1.0]];
//    //your background color...
//    return view;
//}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            // Nickname
            [self changeNickname];
            break;
        case 1:
            // Current city
            [self changeCity];
            break;
        case 2:
            // Email
            [self changeEmail];
            break;
        case 3:
            // Change Password
            [self changePasswordButtonPressed];
            break;
        case 4:
            // Help
             [self helpButtonPressed];
            break;
        case 5:
            // Share
            [self shareButtonPressed:self];
            break;
        case 6:
            // Rate
            [self goToAppInAppStore];
            break;
        case 7:
            // Log Out
            [self LoginOutButtonPressed];
            break;
        default:
            break;
    }
}

#pragma mark - Button Action Methods
- (void)goBack:(id)sender {
    // go back to previous view
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)changeNickname{
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"Change Nickname"
                                          message:nil
                                          preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField)
     {
         textField.placeholder = NSLocalizedString(@"Change Nickname", @"Change Nickname");
     }];
    UIAlertAction *updateAction = [UIAlertAction
                                   actionWithTitle:NSLocalizedString(@"Update", @"Update action")
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction *action)
                                   {
                                       nicknameTextField = alertController.textFields.firstObject;
                                       [settingsTableView reloadData];
                                       // Need to send new data to backend!!
                                   }];
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel action")
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction *action)
                                   {
                                   }];
    [alertController addAction:cancelAction];
    [alertController addAction:updateAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (void)changeCity{
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"Change City"
                                          message:nil
                                          preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField)
     {
         textField.placeholder = NSLocalizedString(@"Current City", @"Current City");
     }];
    UIAlertAction *updateAction = [UIAlertAction
                               actionWithTitle:NSLocalizedString(@"Update", @"Update action")
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action)
                               {
                                   currentCityField = alertController.textFields.firstObject;
                                   [settingsTableView reloadData];
                                   // Need to send new data to backend!!
                               }];
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel action")
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction *action)
                                   {
                                   }];
    [alertController addAction:cancelAction];
    [alertController addAction:updateAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (void)changeEmail{
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"Update Email"
                                          message:nil
                                          preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField)
     {
         textField.placeholder = NSLocalizedString(@"Update Email", @"Update action");
     }];
    
    UIAlertAction *updateAction = [UIAlertAction
                                   actionWithTitle:NSLocalizedString(@"Update", @"Update action")
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction *action)
                                   {
                                       emailField = alertController.textFields.firstObject;
                                       [settingsTableView reloadData];
                                        // Need to send new data to backend!!
                                   }];
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel action")
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction *action)
                                   {
                                   }];
    [alertController addAction:cancelAction];
    [alertController addAction:updateAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (void)changePasswordButtonPressed{
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"Change Password"
                                          message:nil
                                          preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField)
     {
         textField.placeholder = NSLocalizedString(@"Current Password", @"Current Password");
     }];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField)
     {
         textField.placeholder = NSLocalizedString(@"New Password", @"New Password");
         textField.secureTextEntry = YES;
     }];
    UIAlertAction *updateAction = [UIAlertAction
                               actionWithTitle:NSLocalizedString(@"Update", @"Update action")
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action)
                               {
                                   // Sent to backend
                                   currentPassword = alertController.textFields.firstObject;
                                   newPassword = alertController.textFields.lastObject;
                                   NSLog(@"new password: %@", currentPassword.text);
                                   NSLog(@"old password: %@", newPassword.text);
                               }];
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel action")
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction *action)
                                   {
                                   }];
    [alertController addAction:cancelAction];
    [alertController addAction:updateAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (void)helpButtonPressed{
    //    SignInViewController *sivc = [[SignInViewController alloc] init];
    //    [self presentViewController:sivc animated:YES completion:nil];
}
- (void)goToAppInAppStore{
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"Rate Exploze"
                                          message:nil
                                          preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *loveAction = [UIAlertAction
                                 actionWithTitle:NSLocalizedString(@"Love it!", @"Love action")
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction *action)
                                 {
                                     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/in/app/spark-discover-worlds-interests/id926538951?mt=8"]];
                                 }];
    UIAlertAction *hateAction = [UIAlertAction
                                 actionWithTitle:NSLocalizedString(@"Hate it!", @"Hate action")
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction *action)
                                 {
                                     if ([MFMailComposeViewController canSendMail]){
                                         mail = [[MFMailComposeViewController alloc] init];
                                         mail.mailComposeDelegate = self;
                                         [mail setSubject:@"Hi team"];
                                         [mail setMessageBody:@"Let us know what's on your mind" isHTML:NO];
                                         [mail setToRecipients:@[@"testingEmail@example.com"]];
                                         
                                         [self presentViewController:mail animated:YES completion:NULL];
                                     }
                                     else
                                     {
                                         NSLog(@"This device cannot send email");
                                     }
                                 }];
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:NSLocalizedString(@"rate later", @"Rate action")
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction *action)
                                   {
                                   }];

    [alertController addAction:hateAction];
    [alertController addAction:loveAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (void)shareButtonPressed:(id)sender {
    //    ApiUser *user = (ApiUser *) ;
    //    [[ApiManager sharedApiManager] getUserProfileForId:userId
    //                                               success:^(ApiUser *user) {
    //                                                   //                                                   NSLog(@"nickname %@", user.nickname);
    //                                                   //                                                   NSLog(@"bio %@", user.bio);
    //                                                   [ccv.nicknameButton setTitle:user.nickname forState:UIControlStateNormal];
    //                                                   //[ApiUser printApiUser:user];
    //                                               }
    //                                               failure:^(NSError *error) {
    //                                                   //  NSLog(@"%@", error);
    //                                               }];
    
    NSString *message = @"Annoymous thinks you should Break out of your social network. Join exploze!";
    
    NSArray *postItems = [[NSArray alloc] initWithObjects: message, nil];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc]
                                            initWithActivityItems:postItems
                                            applicationActivities:nil];
    [activityVC setTitle:message];
    
    activityVC.excludedActivityTypes = @[UIActivityTypePostToWeibo,
                                         // UIActivityTypeMessage,
                                         //   UIActivityTypeMail,
                                         UIActivityTypePrint,
                                         UIActivityTypeCopyToPasteboard,
                                         UIActivityTypeAssignToContact,
                                         // UIActivityTypeSaveToCameraRoll,
                                         UIActivityTypeAddToReadingList,
                                         UIActivityTypePostToFlickr,
                                         UIActivityTypePostToVimeo,
                                         UIActivityTypePostToTencentWeibo,
                                         UIActivityTypeAirDrop];
    // activityVC.popoverPresentationController.sourceView = self.view;
    [self presentViewController:activityVC animated:YES completion:nil];
}
- (void)LoginOutButtonPressed{
    SignInAndOutViewController *siovc =[[SignInAndOutViewController alloc] init];
    //siovc.view.bounds = self.view.bounds;
    [self presentViewController:siovc    animated:YES completion:nil];
}
#pragma mark - UITextField actions
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == nicknameTextField || textField == currentCityField || textField == emailField) {
        [textField resignFirstResponder];
    }
    return NO;
}
#pragma mark - Email message Actions
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch(result)
    {
        case MFMailComposeResultSent:
            NSLog(@"You sent the email.");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"You saved a draft of this email");
            break;
        case MFMailComposeResultCancelled:
            NSLog(@"You cancelled sending this email.");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail failed:  An error occurred when trying to compose this email");
            break;
        default:
            NSLog(@"An error occurred when trying to compose this email");
            break;
    }
    [self dismissViewControllerAnimated:YES completion:NULL];
}
#pragma mark - Text Field Actions
- (void)textFieldDidEndEditing:(UITextField *)textField {
    // If textfield value changed, store the new value.
    if ( textField == nicknameTextField) {
//        self.name = textField.text ;
    } else if ( textField == currentCityField ) {}
//        self.address = textField.text;}
//    } else if ( textField == passwordField_ ) {
//        self.password = textField.text ;
//    } else if ( textField == descriptionField_ ) {
//        self.description = textField.text ;
//    }
}


@end
