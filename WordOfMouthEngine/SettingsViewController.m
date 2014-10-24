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

@implementation SettingsViewController {

}

#pragma mark -  init methods
- (id)initWithStyle:(UITableViewStyle)style
{
    if (self = [super initWithStyle:style]) {
        // set tab bar
        self.tabBarItem = [[UITabBarItem alloc]
                           initWithTitle:@"Settings"
                           image:nil//[UIImage imageNamed:kAUCCoreFunctionTabbarImageSettings]
                           tag:0];//kCFVTabbarIndexSettings];
        
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

- (void)viewDidLoad{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidUnload{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

// Implement viewWillAppear method for setting up the display
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -  Local Methods Implememtation
- (void)setView {
    
    self.title = @"enter a title";
    // Create table view with certain style
    self.settingsTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    // must set delegate & dataSource, otherwise the the table will be empty and not responsive
   self.settingsTableView.delegate = self;
   self.settingsTableView.dataSource = self;
    
    self.settingsTableView.backgroundColor = [UIColor whiteColor];
    
    //make sure our table view resizes correctly
    self.settingsTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth |
    UIViewAutoresizingFlexibleHeight;
    // add to canvas
    [self.view addSubview:self.settingsTableView];
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
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    SettingsViewHelper *cell = (SettingsViewHelper *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    // Configure the cell...
    if (!cell) {
        cell = [[SettingsViewHelper alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
  
//    cell.textLabel.textColor = [UIColor redColor];
//    cell.textLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
//    cell.textLabel.backgroundColor = [UIColor orangeColor];
    switch (indexPath.row) {
        case 0:
            
            cell.textLabel.text = @"Sign in";
            break;
        case 1:
            cell.textLabel.text = @"History";
        default:
            break;
    }
 
    
    return cell;
}

#pragma mark - Customize cell
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.textLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
    cell.backgroundColor = [UIColor redColor]; //must do here in willDisplayCell
    cell.textLabel.backgroundColor = [UIColor redColor]; //must do here in willDisplayCell
    cell.textLabel.textColor = [UIColor yellowColor]; //can do here OR in cellForRowAtIndexPath
}

#pragma mark -  Table view delegate
//- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
//{
//   if([view isKindOfClass:[UITableViewHeaderFooterView class]]){
//        
//        UITableViewHeaderFooterView *tableViewHeaderFooterView = (UITableViewHeaderFooterView *) view;
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
            [self LoginOutButtonPressed];
            break;
            
        case 1:
            [self HistoryButtonPressed];
            break;
            
        default:
            break;
    }
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

@end
