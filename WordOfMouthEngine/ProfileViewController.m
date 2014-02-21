//
//  ProfileViewController.m
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 2/15/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import "ProfileViewController.h"
#import "ProfileViewHelper.h"
#import "AppUIManager.h"
#import "AppDelegate.h"


@implementation ProfileViewController


#pragma mark -  init methods
- (id)initWithStyle:(UITableViewStyle)style
{
    if (self = [super initWithStyle:style]) {
        // set tab bar
        self.tabBarItem = [[UITabBarItem alloc]
                           initWithTitle:@"Profile"
                           image:[UIImage imageNamed:kAUCCoreFunctionTabbarImageProfile]
                           tag:kCFVTabbarIndexProfile];
        
        // set color
        //[CommonViewElementManager setTableViewBackGroundColor:self.tableView];
        
    }
    return self;
}
- (id)init {
    return [self initWithStyle:UITableViewStyleGrouped];
}

#pragma mark -  View Life cycle Methods

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
    [super loadView];
    // view customization code
    // [self setView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

// Implement viewWillAppear method for setting up the display
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // refresh data
    [self.tableView reloadData];
    
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    UILabel *textLabel;
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        // cell design
        //[self setCellProperties:cell forIndexPath:indexPath];
        
        // button
        UIButton *button = [ProfileViewHelper getButtonForIndexPath:indexPath];
        if(button!=nil) {
            [button  addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:button];
            // add lay out constraints
            NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(button);
            // buttons
            [cell.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[button]-|"
                                                                              options:0 metrics:nil views:viewsDictionary]];
            [cell.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[button]|"
                                                                                   options:0 metrics:nil views:viewsDictionary]];
            
        }
        // title
        textLabel =[ProfileViewHelper getTextLabelForIndexPath:indexPath];
        if(textLabel!=nil) {
            [cell.contentView addSubview:textLabel];
            // add lay out constraints
            NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(textLabel);
            // buttons
            [cell.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[textLabel]-|"
                                                                                     options:0 metrics:nil views:viewsDictionary]];
            [cell.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[textLabel]|"
                                                                                     options:0 metrics:nil views:viewsDictionary]];
        }
    }
    else{
        textLabel = (UILabel *)[cell.contentView viewWithTag:kPVHCellViewTagsLabel];
    }
    // add text
    //titleLabel.text = [[self.infoList objectAtIndex:indexPath.section] objectAtIndex:indexPath.row+1];
    textLabel.text = [self getTextForIndexPath:indexPath];
    
    return cell;
}

#pragma mark -  Local view methods
- (void)setCellProperties:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath {
    // auto layout
    [cell setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    
    // add accessory button
    //cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    
    // Add background image
    //UIImage *image = [UIImage imageNamed:kSLVTableCellBackgroundImage];
    //UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    //imageView.contentMode = UIViewContentModeScaleToFill;
    //cell.frame = [CommonUtility  offSetRect:kIVTableCellFrame byX:45 byY:0];
    //cell.frame = kIVTableCellFrame;
    //cell.backgroundView = [InfoViewHelper getBackgroundViewWithMode:kCVEMTableCellModeNormal];
    //cell.selectedBackgroundView =  [InfoViewHelper getBackgroundViewWithMode:kCVEMTableCellModeSelected];
    //cell.selectionStyle = UITableViewCellSelectionStyleGray;
    //cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
}


#pragma mark -  Table view delegate
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"User Profile - To be implemented";
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a story board-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 
 */

#pragma mark - Local Uitilty Methods
- (NSString *)getTextForIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.section==0&&indexPath.row==0) {
        // min questions
        return [NSString stringWithFormat:@"%@ %@",@"User id:",[SessionManager currentUser].userName];
    }
    
    
    // default
    return @"--";
}

#pragma mark - Button Actions
- (void)buttonPressed:(id)sender{
    // get indexpath
    NSIndexPath *indexPath = [self.tableView indexPathForCell:(UITableViewCell *)[[[sender superview] superview] superview]];
    // section 0 ---------------
    if(indexPath.section==0&&indexPath.row==4) {
        // log out
        [SessionManager sharedSessionManager].delegate=self;
        [[SessionManager sharedSessionManager] logOut];
        return;
    }
    
}

#pragma mark - Session Manager delegate methods
- (void)loggedOutSuccessfully{
    // go to sign in view
    [(AppDelegate *)[UIApplication sharedApplication].delegate  setSignInViewAsRootView];
}


@end
