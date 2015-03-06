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
#import "HistoryViewController.h"
#import "SettingsTableViewCell.h"

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
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
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
    self.title = @"Settings";
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
    [self layoutView];
}
- (void)layoutView{
    
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(settingsTableView, navigationView, cancelButton, settingsTitle);
    
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
    settingsTableView.backgroundColor = [UIColor lightGrayColor];
   
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
#pragma mark - Button Action Methods
- (void)goBack:(id)sender {
    // go back to previous view
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)LoginOutButtonPressed{
    SignInAndOutViewController *siovc =[[SignInAndOutViewController alloc] init];
    //siovc.view.bounds = self.view.bounds;
    [self presentViewController:siovc    animated:YES completion:nil];
}

- (void)HistoryButtonPressed {
    // set add content view
    HistoryViewController *hvc =[[HistoryViewController alloc] init];
    hvc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:hvc animated:NO];
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
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"Nickname";
            cell.detailTextLabel.text = @"Name";
            break;
        case 1:
            cell.textLabel.text = @"Current City";
            cell.detailTextLabel.text = @"Current City";
            break;
        case 2:
            cell.textLabel.text = @"Email";
            cell.detailTextLabel.text = @"jake@gmail.com";
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
    cell.textLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
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
    if (indexPath.section == 0){
        [self HistoryButtonPressed];
    }
    else
    switch (indexPath.row) {
        case 0:
           // [self LoginOutButtonPressed];
            break;
            
        case 1:
         //   [self HistoryButtonPressed];
            break;
        case 8:
            //[self ]
            
        default:
            break;
    }
}


@end
