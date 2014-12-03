//
//  CommentViewController.m
//  WordOfMouthEngine
//
//  Created by Kevin Moy on 11/11/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import "CommentViewController.h"
#import "CommentViewHelper.h"
#import "CommentTableViewCell.h"
#import "AppUIManager.h"
#import "ApiManager.h"
#import "FlurryManager.h"

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
    [self setView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload{
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self registerForKeyboardNotifications];
    
//    [self onSegmentedControlChanged:segmentedControl];
//    [self textViewDidChange:commentText];
//    [commentText becomeFirstResponder];
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
    commentsTableView.estimatedRowHeight = 68.0;
    commentsTableView.rowHeight = UITableViewAutomaticDimension;
    [self onSegmentedControlChanged:segmentedControl];
    [self addSegmentedControl];
    [self setNavigationBar];
    [self setupTableView];
    [self.view addSubview:commentsTableView];

    [self addToolbar];
    [self layoutView];
}

- (void)layoutView{
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(commentsTableView, sendButton, commentText);
    
    // buttons
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[replyToolBar(320)]-10-[sendButton]"                                                                      options:0 metrics:nil views:viewsDictionary]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[commentsTableView(320)]"                                                                      options:0 metrics:nil views:viewsDictionary]];
    
  //  [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[commentsTableView(200)]"                                                                      options:0 metrics:nil views:viewsDictionary]];
    
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[commentText(320)]|"                                                                      options:0 metrics:nil views:viewsDictionary]];

    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[commentsTableView]-10-[commentText(50)]|"                                                                      options:0 metrics:nil views:viewsDictionary]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[commentsTableView]-10-[sendButton(50)]|"                                                                      options:0 metrics:nil views:viewsDictionary]];
    
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[commentText(200)]"                                                                      options:0 metrics:nil views:viewsDictionary]];
//    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[commentText]-5-[sendButton]|"                                                                      options:0 metrics:nil views:viewsDictionary]];

    
//    [replyToolBar addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[commentText]-5-|" options:0 metrics:nil views:viewsDictionary]];
//    
//    [replyToolBar addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[commentText]-5-|" options:0 metrics:nil views:viewsDictionary]];
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
    CommentTableViewCell *cell = (CommentTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
//         cell = [[CommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell = [[CommentTableViewCell alloc] init];
     //   cellButton.tag = kCellButtonTag;
        }
        likeButton = cell.likeButton;
        [likeButton addTarget:self action:@selector(cellButtonTapped:event:) forControlEvents:UIControlEventTouchUpInside];
        cell.commentCellLabel.text = [activeArray objectAtIndex:indexPath.row];
        [cell sizeToFit];
        likeButton.tag = indexPath.row;
//    if (segmentedControl.selectedSegmentIndex == 0) {
//        // Update the comments to top/most recent
//        cell.textLabel.text = @"One";
//    
//    } else if (segmentedControl.selectedSegmentIndex == 1) {
//        cell.textLabel.text = @"Two";
//    }
    if ([cell respondsToSelector:@selector(layoutMargins)]) {
        cell.layoutMargins = UIEdgeInsetsZero;
    }
    
    return cell;
}

#pragma mark - Customize cell
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.textLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
    //   cell.backgroundColor = [UIColor greenColor]; //must do here in willDisplayCell
    //   cell.textLabel.backgroundColor = [UIColor redColor]; //must do here in willDisplayCell
    cell.textLabel.textColor = [UIColor greenColor]; //can do here OR in cellForRowAtIndexPath
   tableView.separatorColor = [UIColor orangeColor];
}
//- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (3 == indexPath.section){
//        return nil;
//    }
//    return indexPath;
//}

- (void)cellButtonTapped:(id)sender event:(id)event{
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:commentsTableView];
    NSIndexPath *indexPath = [commentsTableView indexPathForRowAtPoint: currentTouchPosition];
    if (indexPath != nil){
        [self tableView:commentsTableView cellButtonTapped:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView cellButtonTapped:(NSIndexPath *)indexPath{
    UIImage *heartFull = [UIImage imageNamed:@"reply-heart-full.png"];
    CommentTableViewCell *cell = (CommentTableViewCell *)[commentsTableView cellForRowAtIndexPath:indexPath];
    [cell.likeButton setImage:heartFull forState:UIControlStateNormal];
}

#pragma mark - Segmented Control
- (void) addSegmentedControl {
    NSArray *segmentItems = [NSArray arrayWithObjects: @"Popular", @"Recent", nil];
    segmentedControl = [[UISegmentedControl alloc] initWithItems: segmentItems];

    [segmentedControl addTarget: self action: @selector(onSegmentedControlChanged:) forControlEvents: UIControlEventValueChanged];

    segmentedControl.selectedSegmentIndex = 0;
   // segmentedControl.frame = CGRectMake(0, 0, 120, 30);
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
// reset the scrolling to the top of the table view
    if ([self tableView:commentsTableView numberOfRowsInSection:0] > 0) {
        NSIndexPath *topIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [commentsTableView scrollToRowAtIndexPath:topIndexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
    }
    
    // lazy load data for a segment choice (write this based on your data)
//    [self loadSegmentData:segmentedControl.selectedSegmentIndex];
    
    // reload data based on the new index
//    [self.tableView reloadData];
//    

}

#pragma mark - Toolbar at bottom
- (void) addToolbar{

    sendButton = [CommentViewHelper getSendButton];
    [sendButton addTarget:self action:@selector(sendButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendButton];
    
    commentText = [CommentViewHelper getCommentText:self];
    [self.view addSubview:commentText];
    
    
    //    replyToolBar = [[UIToolbar alloc] init];
    //    replyToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, screenW, 50)];
    //    replyToolBar.backgroundColor = [UIColor greenColor];
    //commentText.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
//    barItem = [[UIBarButtonItem alloc] initWithCustomView:commentText];
//    sButton = [[UIBarButtonItem alloc] initWithCustomView:sendButton];
//    commentText.backgroundColor = [UIColor redColor];
//    NSArray *buttonItems = [NSArray arrayWithObjects:barItem, sButton, nil];
//    [replyToolBar setItems:buttonItems];
  //  [self setToolbarItems:buttonItems animated:NO];
  //  self.navigationController.toolbarHidden = NO;
//    [replyToolBar setTranslatesAutoresizingMaskIntoConstraints:NO];

}
#pragma mark - Navigation bar
- (void) setNavigationBar{
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *cancelBtnImage = [UIImage imageNamed:@"reply-X.png"];
    [cancelBtn setBackgroundImage:cancelBtnImage forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.frame = CGRectMake(0, 0, 15, 15);
    UIView *cancelButtonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 15)];
    [cancelButtonView addSubview:cancelBtn];
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithCustomView:cancelButtonView];
    self.navigationItem.leftBarButtonItem = cancelButton;
    
    
//    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"reply-X.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(goBack:)];
////    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"myImage"] style:UIBarButtonItemStyleBordered target:self action:@selector(goBack:)];
//    
//    [[self navigationItem] setLeftBarButtonItem:cancelButton]

}
- (void) setupTableView{
    commentsTableView = [[UITableView alloc] init];
    [commentsTableView setTranslatesAutoresizingMaskIntoConstraints:NO];

    // ios7
    if ([commentsTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [commentsTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    // ios 8
    if ([commentsTableView respondsToSelector:@selector(layoutMargins)]) {
        commentsTableView.layoutMargins = UIEdgeInsetsZero;
    }

    commentsTableView.delegate = self;
    commentsTableView.dataSource = self;
    
    commentsTableView.backgroundColor = [UIColor whiteColor];
    
    //make sure our table view resizes correctly
    commentsTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth |
    UIViewAutoresizingFlexibleHeight;

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

//    CGSize kbSize = [[keyboardInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
//    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
//    commentsTableView.contentInset = contentInsets;
//    commentsTableView.scrollIndicatorInsets = contentInsets;
    
    [self.view setFrame:CGRectMake(0,0-keyboardHeight,screenW, screenH)];
//     [replyToolBar setFrame:CGRectMake(0,0-keyboardHeight,screenW, screenH)];
//    [self scrollViewForKeyboard:notification up:YES];
}

- (void)keyboardWillBeHidden:(NSNotification *)notification {
    float screenH = [CommonUtility getScreenHeight];
    float screenW = [CommonUtility getScreenWidth];
    
//    scrollView.contentInset = contentInsets;
//    scrollView.scrollIndicatorInsets = contentInsets;
    [self.view setFrame:CGRectMake(0,0,screenW,screenH)];
}
- (void)textViewDidBeginEditing:(UITextView *)textView{
    sendButton.enabled=NO;
}
- (void)textViewDidChange:(UITextView *)textView{
    long  textLength =[textView.text length];
    // NSLog(@"%ld",textLength);
    textLength =[[CommonUtility  trimString:textView.text ] length];
    // post button
    if(textLength < kAPIValidationContentMinLength){
        sendButton.enabled=NO;
    }
    else if(textLength >= kAPIValidationContentMinLength){
        sendButton.enabled=YES;
    }

}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    long totalLength = textView.text.length - range.length + text.length;
    
    if (totalLength>200){
        return NO;
    }
    return YES;
}
- (void)disableKeyBoard{
    // disable keyboard
   
    [commentText resignFirstResponder];
 //   commentText.inputAccessoryView = nil;
}

#pragma mark - Button presses
- (void)goBack:(id)sender {
    // go back
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)sendButtonPressed:(id)sender {
    // send Message and clear content
    NSLog(@"sent comment!");
    [self disableKeyBoard];
    commentText.text = @"";
}

#pragma mark - temp code
- (void) createAllDummyLists{
    recentArray = @[@"1. Ninety-nine percent of lawyers give the rest a bad name. I AM GOING TO WRITE LONG TEST TEXT TO TEST HOW MANY LONG BLAH BLAH BLAH BLAH BAF;ASDJFK;LJ;",
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
