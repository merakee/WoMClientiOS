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

extern float ScreenH;
extern float ScreenW;

@interface CommentViewController ()

@end

@implementation CommentViewController
@synthesize segmentedControl;

#pragma mark -  init methods
- (id)init {
    if (self = [super init]) {
        [self createAllDummyLists];
    }
    return self;
    
}


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
    
    [self onSegmentedControlChanged:segmentedControl];
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
    
    // set app defaults
    [AppUIManager setUIView:self.view ofType:kAUCPriorityTypePrimary];
    // view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:[CommonUtility adjustImageFileName:kAUCContentBackgroundImage]]];
    self.view.backgroundColor = [UIColor whiteColor];
    
//   self.navigationController.toolbarHidden = NO;
    
    [self addSegmentedControl];
    [self setNavigationBar];
    [self setupTableView];
    [self.view addSubview:commentsTableView];

    [self addToolbar];
    [self layoutView];
    
    
}
- (void)layoutView{
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(replyToolBar, commentsTableView);
    
    // buttons
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[replyToolBar(320)]"                                                                      options:0 metrics:nil views:viewsDictionary]];
    
     [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[commentsTableView(320)]"                                                                      options:0 metrics:nil views:viewsDictionary]];
//
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[commentsTableView(320)]"                                                                      options:0 metrics:nil views:viewsDictionary]];

    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[commentsTableView]-10-[replyToolBar]|"                                                                      options:0 metrics:nil views:viewsDictionary]];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section. should be returning the number of comments
    return [activeArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
  //  NSString *CellIdentifier = [NSString stringWithFormat:@"%ld_%ld",(long)indexPath.section,(long)indexPath.row];
    CommentViewHelper *cell = (CommentViewHelper *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    UIButton                *cellButton;
    if (!cell) {
        NSLog(@"%ld",(long)indexPath.row);
        cellText = [[UILabel alloc] init];
      //  cellText.backgroundColor = [UIColor blueColor];
         cell = [[CommentViewHelper alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cellButton = [CommentViewHelper getCellButton];
        [cellButton addTarget:self action:@selector(cellButtonTapped:event:) forControlEvents:UIControlEventTouchUpInside];
        cellButton.tag = kCellButtonTag;
        
        cellText = [CommentViewHelper getCellText];
        
        [cell.contentView addSubview:cellButton];
      //  [cell.contentView addSubview:cellText];
        cellText.text = [activeArray objectAtIndex:indexPath.row];
                cell.textLabel.text = [activeArray objectAtIndex:indexPath.row];
     //   NSLog(@"%ld", indexPath.row);
        }
    else {
        cell.textLabel.text = [activeArray objectAtIndex:indexPath.row];
        //cellText.text = [activeArray objectAtIndex:indexPath.row];
        cellButton = (UIButton *)[cell.contentView viewWithTag:kCellButtonTag];
    }

    //[cellButton addTarget:self action:@selector(cellButtonTapped:event:) forControlEvents:UIControlEventTouchUpInside];
    
//        for (UIView *subview in cell.contentView.subviews){
//        if ([subview isKindOfClass:[UIButton class]]){
//            [subview removeFromSuperview];
//            NSLog(@"removed");}
//        }
//    }
   
//    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
//    if (segmentedControl.selectedSegmentIndex == 0) {
//        // Update the comments to top/most recent
//        cell.textLabel.text = @"One";
//    
//    } else if (segmentedControl.selectedSegmentIndex == 1) {
//        cell.textLabel.text = @"Two";
//    }
//     [cellText sizeToFit];
       return cell;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //[commentsTableView reloadData];
  //  NSLog(@"blah");
}


#pragma mark - Customize cell
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.textLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
    //   cell.backgroundColor = [UIColor greenColor]; //must do here in willDisplayCell
    //   cell.textLabel.backgroundColor = [UIColor redColor]; //must do here in willDisplayCell
    cell.textLabel.textColor = [UIColor greenColor]; //can do here OR in cellForRowAtIndexPath
   tableView.separatorColor = [UIColor orangeColor];
  
   // [cell.contentView addSubview:cellButton];

    
    
    // Image for accessory View, size should be 25x25
//    UIImageView *accessoryImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"reply-heart-empty.png"]];
//    [accessoryImage setFrame:CGRectMake(0, 0, 18.0, 18.0)];
//    accessoryImage.contentMode = UIViewContentModeScaleAspectFit;
    
//    // Get accessory image
//    accessoryImage = [CommentViewHelper getAccessoryImage];
//    accessoryImageView = [[UIImageView alloc] initWithImage:accessoryImage];
//    
//    [accessoryButton setImage:accessoryImage forState:UIControlStateNormal];
//    [accessoryButton setFrame:CGRectMake(0, 0, 18.0, 18.0)];
//    accessoryButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [accessoryButton addTarget:self action:@selector(accessoryButtonTapped:event:) forControlEvents:UIControlEventTouchUpInside];
    
   // accessoryButton.contentMode = UIViewContentModeScaleAspectFit;

    
//    [tableView cellForRowAtIndexPath:indexPath].accessoryView = accessoryButton;
//   cell.accessoryView = accessoryButton;
}
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (3 == indexPath.section){
        return nil;
    }
    return indexPath;
}
- (void)cellButtonTapped:(id)sender event:(id)event{
    NSLog(@"tapped");
     UIImage *heartFull = [UIImage imageNamed:@"reply-heart-full.png"];
    [cellButton setImage:heartFull forState:UIControlStateNormal];
 //   NSIndexPath *indexPath = [commentsTableView indexPathForRowAtPoint:[[[event touchesForView:cellButton] anyObject] locationInView:commentsTableView]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
    //return cellText.frame.size.height;
}

//-(CGFloat)heightForText:(NSString *)text
//{
//    NSInteger MAX_HEIGHT = 2000;
//    UITextView * textView = [[UITextView alloc] initWithFrame: CGRectMake(0, 0, 320, MAX_HEIGHT)];
//    textView.text = text;
//    textView.font = [UIFont boldSystemFontOfSize:12];
//    [textView sizeToFit];
//    return textView.frame.size.height;
//}
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
        // switch active array pointer to popular array
        activeArray = popularArray;
        [commentsTableView reloadData];
    }
    else if (sender.selectedSegmentIndex == 1){
        segmentedControl.selectedSegmentIndex = 1;
        // switch active array pointer to recent array
        activeArray = recentArray;
        [commentsTableView reloadData];
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
    float screenW = [CommonUtility getScreenWidth];
   // replyToolBar = [[UIToolbar alloc] init];
        replyToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, screenW, 50)];
    replyToolBar.backgroundColor = [UIColor greenColor];
    sendButton = [CommentViewHelper getSendButton];
    [sendButton addTarget:self action:@selector(sendButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 250, 35)];
    textView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    barItem = [[UIBarButtonItem alloc] initWithCustomView:textView];
    sButton = [[UIBarButtonItem alloc] initWithCustomView:sendButton];
//    self.toolbarItems = [NSArray arrayWithObject:barItem, sendButton];
    NSArray *buttonItems = [NSArray arrayWithObjects:barItem, sButton, nil];
    [replyToolBar setItems:buttonItems];
  //  [self setToolbarItems:buttonItems animated:NO];
  //  self.navigationController.toolbarHidden = NO;
    [replyToolBar setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:replyToolBar];
    

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
- (void) setupTableView{
 //   float screenH = [CommonUtility getScreenHeight];
    float screenW = [CommonUtility getScreenWidth];
    // Create table view with certain style
    commentsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenW, 500) style:UITableViewStylePlain];
    
//    commentsTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    //commentsTableView.style.UITableViewStylePlain;
   // commentsTableView.translatesAutoresizingMaskIntoConstraints = NO;
    // Inset of cell seperators
    [commentsTableView setSeparatorInset:UIEdgeInsetsZero];
    //    [self.commentsTableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLineEtched];
    
    // must set delegate & dataSource, otherwise the the table will be empty and not responsive
    commentsTableView.delegate = self;
    commentsTableView.dataSource = self;
    
    commentsTableView.backgroundColor = [UIColor whiteColor];
    
    //make sure our table view resizes correctly
    commentsTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth |
    UIViewAutoresizingFlexibleHeight;
    // add to canvas
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
    
    float screenH = [CommonUtility getScreenHeight];
    float screenW = [CommonUtility getScreenWidth];
    // Step 1: Get the size of the keyboard.
    NSDictionary *keyboardInfo = [notification userInfo];
    NSValue *keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
    float keyboardHeight = keyboardFrameBeginRect.size.height;

    [self.view setFrame:CGRectMake(0,0-keyboardHeight,screenW, screenH)];
//     [replyToolBar setFrame:CGRectMake(0,0-keyboardHeight,screenW, screenH)];
//    [self scrollViewForKeyboard:notification up:YES];
}

- (void)keyboardWillBeHidden:(NSNotification *)notification {
    float screenH = [CommonUtility getScreenHeight];
    float screenW = [CommonUtility getScreenWidth];
//    [self scrollViewForKeyboard:notification up:NO];
//    [_commentsTableView setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, 300, 600)];
//    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
//    commentsTableView.contentInset = contentInsets;
    [self.view setFrame:CGRectMake(0,0,screenW,screenH)];
}

//- (void) scrollViewForKeyboard:(NSNotification*)aNotification up: (BOOL) up{
//    NSDictionary* userInfo = [aNotification userInfo];
//    
//    // Get animation info from userInfo
//    NSTimeInterval animationDuration;
//    UIViewAnimationCurve animationCurve;
//    CGRect keyboardFrame;
//    [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
//    [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
//    
//    // Animate up or down
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:animationDuration];
//    [UIView setAnimationCurve:animationCurve];
//    
//    [self.view setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y + (keyboardFrame.size.height * (up?-1:1)), self.view.frame.size.width, self.view.frame.size.height)];
//    [UIView commitAnimations];
//}


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

#pragma mark - temp code
- (void) createAllDummyLists{
    recentArray = @[@"1. Ninety-nine percent of lawyers give the rest a bad name.",
                    @"2. Borrow money from a pessimist -- they don't expect it back.",
                    @"3. Time is what keeps things from happening all at once.",
                    @"4. Lottery: A tax on people who are bad at math.",
                    @"5. I didn't fight my way to the top of the food chain to be a vegetarian.",
                    @"6. Never answer an anonymous letter.",
                    @"7. It's lonely at the top; but you do eat better.",
                    @"8. I don't suffer from insanity; I enjoy every minute of it.",
                    @"9. Always go to other people's funerals, or they won't go to yours.",
                    @"10. Few women admit their age; few men act it.",
                    @"11. If we aren't supposed to eat animals, why are they made with meat?",
                    @"12. No one is listening until you make a mistake.",
                    @"13. Give me ambiguity or give me something else.",
                    @"14. We have enough youth. How about a fountain of Smart?",
                    @"15. He who laughs last thinks slowest.",
                    @"16. Campers: Nature's way of feeding mosquitoes.",
                    @"17. Always remember that you are unique; just like everyone else.",
                    @"18. Consciousness: That annoying time between naps.",
                    @"19. There are three kinds of people: Those who can count and those who can't.",
                    @"20. Why is abbreviation such a long word?",
                    @"21. Nuke the Whales.",
                    @"22. I started out with nothing and I still have most of it.",
                    @"23. Change is inevitable, except from a vending machine.",
                    @"24. Out of my mind. Back in five minutes.",
                    @"25. A clear conscience is usually the sign of a bad memory.",
                    @"26. As long as there are tests, there will be prayer in public schools.",
                    @"27. Laugh alone and the world thinks you're an idiot.",
                    @"28. Sometimes I wake up grumpy; other times I let her sleep.",
                    @"29. The severity of the itch is inversely proportional to the ability to reach it.",
                    @"30. You can't have everything; where would you put it?",
                    @"31. I took an IQ test and the results were negative.",
                    @"32. Okay, who stopped the payment on my reality check?"
                    ];
    
    popularArray = @[@"Popular: 1. Ninety-nine percent of lawyers give the rest a bad name.",
                    @"Popular: 2. Borrow money from a pessimist -- they don't expect it back.",
                    @"Popular: 3. Time is what keeps things from happening all at once.",
                    @"Popular: 4. Lottery: A tax on people who are bad at math.",
                    @"Popular: 5. I didn't fight my way to the top of the food chain to be a vegetarian.",
                    @"Popular: 6. Never answer an anonymous letter.",
                    @"Popular: 7. It's lonely at the top; but you do eat better.",
                    @"Popular: 8. I don't suffer from insanity; I enjoy every minute of it.",
                    @"Popular: 9. Always go to other people's funerals, or they won't go to yours.",
                    @"Popular: 10. Few women admit their age; few men act it.",
                    @"Popular: 11. If we aren't supposed to eat animals, why are they made with meat?",
                    @"Popular: 12. No one is listening until you make a mistake.",
                    @"Popular: 13. Give me ambiguity or give me something else.",
                    @"Popular: 14. We have enough youth. How about a fountain of Smart?",
                    @"Popular: 15. He who laughs last thinks slowest.",
                    @"Popular: 16. Campers: Nature's way of feeding mosquitoes.",
                    @"Popular: 17. Always remember that you are unique; just like everyone else.",
                    @"Popular: 18. Consciousness: That annoying time between naps.",
                    @"Popular: 19. There are three kinds of people: Those who can count and those who can't.",
                    @"Popular: 20. Why is abbreviation such a long word?",
                    @"Popular: 21. Nuke the Whales.",
                    @"Popular: 22. I started out with nothing and I still have most of it.",
                    @"Popular: 23. Change is inevitable, except from a vending machine.",
                    @"Popular: 24. Out of my mind. Back in five minutes.",
                    @"Popular: 25. A clear conscience is usually the sign of a bad memory.",
                    @"Popular: 26. As long as there are tests, there will be prayer in public schools.",
                    @"Popular: 27. Laugh alone and the world thinks you're an idiot.",
                    @"Popular: 28. Sometimes I wake up grumpy; other times I let her sleep.",
                    @"Popular: 29. The severity of the itch is inversely proportional to the ability to reach it.",
                    @"Popular: 30. You can't have everything; where would you put it?",
                    @"Popular: 31. I took an IQ test and the results were negative.",
                    @"Popular: 32. Okay, who stopped the payment on my reality check?"
                    ];
    
}

@end
