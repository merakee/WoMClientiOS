//
//  CommentViewController.m
//  WordOfMouthEngine
//
//  Created by Kevin Moy on 11/11/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import "CommentViewController.h"
#import "CommentViewHelper.h"
#import "AppUIManager.h"
#import "ApiManager.h"
#import "FlurryManager.h"

@interface CommentViewController ()

@end

@implementation CommentViewController
@synthesize segmentedControl;
- (void)loadView {
    [super loadView];
    // view customization code
    [self setView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self registerForKeyboardNotifications];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self deregisterFromKeyboardNotifications];
    [super viewWillDisappear:animated];
    
    // Analytics: Flurry
    [Flurry endTimedEvent:[FlurryManager getEventName:kFAComposeSession] withParameters:nil];
}

- (BOOL)shouldAutorotate{
    return  YES;
}
- (NSUInteger)supportedInterfaceOrientations{
    return [AppUIManager getSupportedOrentation];
}

#pragma mark -  Local Methods Implememtation
- (void)setView {

   self.navigationController.toolbarHidden = NO;
    [self addSegmentedControl];
    [self setNavigationBar];
    [self addToolbar];
    self.title = @"enter a title";
    // Create table view with certain style
    self.commentsTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    // Inset of cell seperators
    [self.commentsTableView setSeparatorInset:UIEdgeInsetsZero];
//    [self.commentsTableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLineEtched];
    
    // must set delegate & dataSource, otherwise the the table will be empty and not responsive
    self.commentsTableView.delegate = self;
    self.commentsTableView.dataSource = self;
    
    self.commentsTableView.backgroundColor = [UIColor whiteColor];
    
    //make sure our table view resizes correctly
    self.commentsTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth |
    UIViewAutoresizingFlexibleHeight;
    // add to canvas
    [self.view addSubview:self.commentsTableView];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section. should be returning the number of comments
    return 6;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    CommentViewHelper *cell = (CommentViewHelper *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (!cell) {
        cell = [[CommentViewHelper alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    if (segmentedControl.selectedSegmentIndex == 0) {
        // Update the comments to top/most recent
        cell.textLabel.text = @"One";
    
    } else if (segmentedControl.selectedSegmentIndex == 1) {
        cell.textLabel.text = @"Two";
    }
    return cell;
}

#pragma mark - Customize cell
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.textLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
    //   cell.backgroundColor = [UIColor greenColor]; //must do here in willDisplayCell
    //   cell.textLabel.backgroundColor = [UIColor redColor]; //must do here in willDisplayCell
    cell.textLabel.textColor = [UIColor greenColor]; //can do here OR in cellForRowAtIndexPath
    tableView.separatorColor = [UIColor orangeColor];
    // Arrow on right side of tableview
    //    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    //    cell.accessoryView.backgroundColor = [UIColor purpleColor];
    
    
    // Image for accessory View, size should be 25x25
//    UIImageView *accessoryImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"reply-heart-empty.png"]];
//    [accessoryImage setFrame:CGRectMake(0, 0, 18.0, 18.0)];
//    accessoryImage.contentMode = UIViewContentModeScaleAspectFit;
    
    // Get accessory image
    accessoryImage = [CommentViewHelper getAccessoryImage];
    accessoryImageView = [[UIImageView alloc] initWithImage:accessoryImage];
    
    [accessoryButton setImage:accessoryImage forState:UIControlStateNormal];
    [accessoryButton setFrame:CGRectMake(0, 0, 18.0, 18.0)];
    accessoryButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [accessoryButton addTarget:self action:@selector(accessoryButtonTapped:event:) forControlEvents:UIControlEventTouchUpInside];
    
   // accessoryButton.contentMode = UIViewContentModeScaleAspectFit;

    
//    [tableView cellForRowAtIndexPath:indexPath].accessoryView = accessoryButton;
   cell.accessoryView = accessoryButton;
    NSLog(@"%@", cell);
}
- (void)accessoryButtonTapped:(id)sender event:(id)event{
  //  NSLog(@"tapped");
    // UIImage *heartFull = [UIImage imageNamed:@"reply-heart-full.png"];
   // [accessoryButton setImage:heartFull forState:UIControlStateNormal];
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint: currentTouchPosition];
    if (indexPath != nil){
        [self tableView: self.tableView accessoryButtonTappedForRowWithIndexPath: indexPath];
    }
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld", (long)indexPath.row);
     UIImage *heartFull = [UIImage imageNamed:@"reply-heart-full.png"];
    
    // change image for image.
    //     [accessoryButton setImage:heartFull forState:UIControlStateNormal];
//    if (indexPath != nil)
//    {
//        [self tableView: self.tableView accessoryButtonTappedForRowWithIndexPath: indexPath];
//    }
}

#pragma mark - Segmented Control
- (void) addSegmentedControl {
    NSArray *segmentItems = [NSArray arrayWithObjects: @"One", @"Two", nil];
    segmentedControl = [[UISegmentedControl alloc] initWithItems: segmentItems];

    [segmentedControl addTarget: self action: @selector(onSegmentedControlChanged:) forControlEvents: UIControlEventValueChanged];

    segmentedControl.selectedSegmentIndex = 0;
    segmentedControl.frame = CGRectMake(0, 0, 120, 30);
    //self.navigationItem.titleView = segmentedControl;
  //   self.tableView.tableHeaderView = segmentedControl;
  //  [self.navigationController.navigationItem setPrompt:@"some prompt text"];
    self.navigationItem.titleView = segmentedControl;
    //[self.view addSubview:segmentedControl];
}

- (void) onSegmentedControlChanged:(UISegmentedControl *) sender {
    
  // NSLog(@"%ld", sender.selectedSegmentIndex);
    if (sender.selectedSegmentIndex == 0) {
        segmentedControl.selectedSegmentIndex = 0;
        [_commentsTableView reloadData];
    }
    else if (sender.selectedSegmentIndex == 1){
        segmentedControl.selectedSegmentIndex = 1;
        [_commentsTableView reloadData];
    }
    // lazy load data for a segment choice (write this based on your data)
//    [self loadSegmentData:segmentedControl.selectedSegmentIndex];
    
    // reload data based on the new index
//    [self.tableView reloadData];
//    
//    // reset the scrolling to the top of the table view
//    if ([self tableView:self.tableView numberOfRowsInSection:0] > 0) {
//        NSIndexPath *topIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//        [self.tableView scrollToRowAtIndexPath:topIndexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
//    }
}

#pragma mark - Toolbar at bottom
- (void) addToolbar{
    sendButton = [CommentViewHelper getSendButton];
    [sendButton addTarget:self action:@selector(sendButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(-30, 0, 250, 35)];
    textView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:textView];
    UIBarButtonItem *sButton = [[UIBarButtonItem alloc] initWithCustomView:sendButton];
//    self.toolbarItems = [NSArray arrayWithObject:barItem, sendButton];
    NSArray *buttonItems = [NSArray arrayWithObjects:barItem, sButton, nil];
    self.toolbarItems = buttonItems;
}
#pragma mark - Navigation bar
- (void) setNavigationBar{
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *cancelBtnImage = [UIImage imageNamed:@"reply-X.png"];
    [cancelBtn setBackgroundImage:cancelBtnImage forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.frame = CGRectMake(0, 0, 15, 15);
    UIView *cancelButtonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 15)];
 //   cancelButtonView.bounds = CGRectOffset(cancelButtonView.bounds, -14, -7);
    [cancelButtonView addSubview:cancelBtn];
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithCustomView:cancelButtonView];
    self.navigationItem.leftBarButtonItem = cancelButton;
    
    
//    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"reply-X.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(goBack:)];
////    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"myImage"] style:UIBarButtonItemStyleBordered target:self action:@selector(goBack:)];
//    
//    [[self navigationItem] setLeftBarButtonItem:cancelButton]

}

#pragma mark - Keyboard notifications
- (void)registerForKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)deregisterFromKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardDidHideNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}
- (void)keyboardWasShown:(NSNotification *)notification {

    [self scrollViewForKeyboard:notification up:YES];
//        NSDictionary* info = [notification userInfo];
//    
//        CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
//    
//        CGPoint buttonOrigin = sendButton.frame.origin;
//        CGFloat buttonHeight = sendButton.frame.size.height;
//        CGRect visibleRect = self.view.frame;
//    
//        visibleRect.size.height -= keyboardSize.height;
//    
//        if (!CGRectContainsPoint(visibleRect, buttonOrigin)){
//    
//            CGPoint scrollPoint = CGPointMake(0.0, buttonOrigin.y - visibleRect.size.height + buttonHeight);
//            NSLog(@"scroll up nigga");
//            [scrollView setContentOffset:scrollPoint animated:YES];
//        }
}

- (void)keyboardWillBeHidden:(NSNotification *)notification {
    //    [scrollView setContentOffset:CGPointZero animated:YES];
//    CGRect frame = self.view.frame;
//    frame.origin.y = 0;
    [self scrollViewForKeyboard:notification up:NO];
//    [_commentsTableView setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, 300, 600)];
    NSLog(@"hi");
}

- (void) scrollViewForKeyboard:(NSNotification*)aNotification up: (BOOL) up{
    NSDictionary* userInfo = [aNotification userInfo];
    // Get animation info from userInfo
//    NSTimeInterval animationDuration;
//    UIViewAnimationCurve animationCurve;
    NSValue* keyboardFrameBegin = [userInfo valueForKey:UIKeyboardFrameBeginUserInfoKey];
    CGRect keyboardFrame = [keyboardFrameBegin CGRectValue];
 //   CGRect keyboardFrame;
//    [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
//    [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
//    
//    // Animate up or down
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:animationDuration];
//    [UIView setAnimationCurve:animationCurve];
    
    [self.navigationController.toolbar setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y + (keyboardFrame.size.height * (up?-1:1)), self.view.frame.size.width, self.view.frame.size.height)];
    [UIView commitAnimations];
}


#pragma mark - Button presses
- (void)goBack:(id)sender {
    // go back
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)sendButtonPressed:(id)sender {
    // send Message
    [self.navigationController popViewControllerAnimated:NO];
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
