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
                           image:nil//[UIImage imageNamed:kAUCCoreFunctionTabbarImageProfile]
                           tag:0];//kCFVTabbarIndexProfile];
        
        // set up info list
        [self setAllInfo];
        
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
    [self setView];
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
    return [profileInfo count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [profileInfo[section][@"rows"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifierText = @"TextCell";
    static NSString *CellIdentifierButton = @"ButtonCell";
    // cell type
    BOOL isButton =([profileInfo[indexPath.section][@"header"] isEqualToString:@"System"]) &&
    ([profileInfo[indexPath.section][@"rows"][indexPath.row] isEqualToString:@"Sign Out"]);
    
    // button type cell
    if(isButton){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifierButton];
        
        // Configure the cell...
        UIButton *button;
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifierButton];
            // cell design
            //[self setCellProperties:cell forIndexPath:indexPath];
            button = [ProfileViewHelper getButton];
            [button  addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:button];
            // add lay out constraints
            NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(button);
            // buttons
            [cell.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-30-[button]-30-|"
                                                                                     options:0 metrics:nil views:viewsDictionary]];
            [cell.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[button]-5-|"
                                                                                     options:0 metrics:nil views:viewsDictionary]];
            
            
            
        }
        else{
            button = (UIButton *)[cell.contentView viewWithTag:kPVHCellViewTagsButton];
        }
        
        [button setTitle:profileInfo[indexPath.section][@"rows"][indexPath.row]
                forState:UIControlStateNormal];
        
        return cell;
    }
    
    // text type cell
    
    // Configure the cell...
    UILabel *textLabel;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifierText];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifierText];
        // cell design
        //[self setCellProperties:cell forIndexPath:indexPath];
        textLabel =[ProfileViewHelper getTextLabelForIndexPath:indexPath];
        //if(textLabel!=nil) {
        [cell.contentView addSubview:textLabel];
        // add lay out constraints
        NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(textLabel);
        // buttons
        [cell.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[textLabel]-|"
                                                                                 options:0 metrics:nil views:viewsDictionary]];
        [cell.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[textLabel]|"
                                                                                 options:0 metrics:nil views:viewsDictionary]];
        
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
- (void)setView{
    // set view
    //[ProfileViewHelper  setView:self.view];
    
    // set table view
    [ProfileViewHelper setTableView:self.tableView];
    
    //activity indicator view
    //activityIndicator =[[UIActivityIndicatorView alloc] init];
    //[AppUIManager addActivityIndicator:activityIndicator toView:self.view];
}


#pragma mark -  Table view delegate
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return profileInfo[section][@"header"];
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

#pragma mark - Button Actions
- (void)buttonPressed:(id)sender{
    // get indexpath
    ///NSIndexPath *indexPath = [self.tableView indexPathForCell:(UITableViewCell *)[[[sender superview] superview] superview]];
   
    // sign out user
    [activityIndicator startAnimating];
    if([[(UIButton *)sender currentTitle] isEqualToString:@"Sign Out"]) {
        // log out
        [[ApiManager sharedApiManager] signOutUserSuccess:^(void){
            [activityIndicator stopAnimating];
            [self signedOutSuccessfully];
        }failure:^(NSError * error){
            [activityIndicator stopAnimating];
            [ApiErrorManager displayAlertWithError:error withDelegate:self];
        }];
        
        return;
    }
}

#pragma mark - Session Manager delegate methods
- (void)signedOutSuccessfully{
    // go to sign in view
    [(AppDelegate *)[UIApplication sharedApplication].delegate  setSignInViewAsRootView];
}


#pragma mark - Local Uitilty Methods
- (NSString *)getTextForIndexPath:(NSIndexPath *)indexPath {
    NSString *text = profileInfo[indexPath.section][@"rows"][indexPath.row];
    
    if(indexPath.section==0&&indexPath.row==0) {
        // min questions
        return [NSString stringWithFormat:@"%@: %@",text,[[ApiManager sharedApiManager] currentUser].email];
    }
    
    // default
    return [NSString stringWithFormat:@"%@: __",text];
}
-(void)setAllInfo {
    // profile info
    profileInfo = @[@{@"header": @"Profile",
                      @"rows": @[@"User Id",@"User Name", @"User Image",@"User email"]},
                    @{@"header": @"Performance",
                      @"rows": @[@"Total Spread Score",@"Spread Efficiency", @"Total Posts",@"Total Spread Count",@"Total Kill Count"]},
                    @{@"header": @"Settings",
                      @"rows": @[@"Category",@"Other Settings"]},
                    @{@"header": @"System",
                      @"rows": @[@"Sign Out",@"Others"]}];
}


@end
