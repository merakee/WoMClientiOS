//
//  CommentViewController.m
//  WordOfMouthEngine
//
//  Created by Kevin Moy on 11/11/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import "CommentViewController.h"
#import "CommentTableViewCell.h"
#import "AppUIManager.h"
#import "FlurryManager.h"

@implementation CommentViewController
@synthesize segmentedControl;
@synthesize currentContent;

#pragma mark -  init methods
- (id)init {
    if (self = [super init]) {
        // [self createAllDummyLists];
        recentArray = [[NSMutableArray alloc] init];
        popularArray = [[NSMutableArray alloc] init];
        activeArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)loadView {
    [super loadView];
    [self setView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    commentsTableView.estimatedRowHeight = 44.0;
    commentsTableView.rowHeight = UITableViewAutomaticDimension;
    commentsTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
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
- (void)viewDidAppear:(BOOL)animated {
    [self updateCommentArrayWithMode:kAPICommentRefreshModeGetMore];
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
//- (void)updateViewConstraints{
//  //  [self updateViewConstraints];
//}
#pragma mark -  Local Methods Implememtation
- (void)setView {
    
    // set app defaults
    [AppUIManager setUIView:self.view ofType:kAUCPriorityTypePrimary];
    self.view.backgroundColor = [UIColor whiteColor];
    totalHeight = 10;
    

    [self onSegmentedControlChanged:segmentedControl];
    [self addSegmentedControl];
    [self setNavigationBar];
    [self setupTableView];
    [self.view addSubview:commentsTableView];
    
    //activity indicator view
    activityIndicator =[[UIActivityIndicatorView alloc] init];
    [AppUIManager addActivityIndicator:activityIndicator toView:self.view];
    
    
    [self addToolbar];
    [self layoutView];
    [self addGesture];
}

- (void)layoutView{
    //totalHeight = 10;
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(commentsTableView, sendButton, commentText);
    NSDictionary *metrics = @{@"totalHeight":[NSNumber numberWithFloat:totalHeight]};
    // buttons
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[commentsTableView]-15-|"                                                                      options:0 metrics:nil views:viewsDictionary]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[commentsTableView]|"                                                                      options:0 metrics:nil views:viewsDictionary]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-6-[commentText(250)]-6-[sendButton(50)]"                                                                      options:0 metrics:nil views:viewsDictionary]];
    
    [self layoutCommentSectionViewWithDictionary:viewsDictionary andMetrics:metrics];
}
- (void)layoutCommentSectionViewWithDictionary:(NSDictionary *)viewsDictionary andMetrics:(NSDictionary *)metrics{
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[sendButton(39)]-totalHeight-|"                                                                      options:0 metrics:metrics views:viewsDictionary]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[commentText(39)]-totalHeight-|"                                                                      options:0 metrics:metrics views:viewsDictionary]];
    
  //   [self.view setNeedsUpdateConstraints];
    NSLog(@"total height: %f", totalHeight);
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section. should be returning the number of comments
  //  NSLog(@"Update: %ld", (unsigned long)activeArray.count);
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
    [cell.likeButton addTarget:self action:@selector(likeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    ApiComment *apiComment =(ApiComment*) [activeArray objectAtIndex:indexPath.row];
    cell.likeButton.didLike =[apiComment.didLike boolValue];
    cell.likeCount.text = [apiComment.likeCount stringValue];
    cell.commentCellLabel.text = apiComment.commentText;
    
    NSLog(@"comment text: %@", apiComment.commentText);
    
    [cell sizeToFit];
    //cell.likeButton.tag = indexPath.row;
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
    //   cell.textLabel.textColor = [UIColor greenColor]; //can do here OR in cellForRowAtIndexPath
    //   tableView.separatorColor = [UIColor orangeColor];
}

-(void)likeButtonPressed:(CustomLilkeButton *)sender{
    if(sender.didLike==true){
        return;
    }
    UITableViewCell *cell = (UITableViewCell *) sender.superview;
    NSIndexPath *indexPath = [commentsTableView indexPathForCell:cell];
    [self postCommentLikeWithIndexPath:(NSIndexPath *)indexPath];
}

//- (void)cellButtonTapped:(id)sender event:(id)event{
//    NSSet *touches = [event allTouches];
//    UITouch *touch = [touches anyObject];
//    CGPoint currentTouchPosition = [touch locationInView:commentsTableView];
//    NSIndexPath *indexPath = [commentsTableView indexPathForRowAtPoint: currentTouchPosition];
//    if (indexPath != nil){
//        [self tableView:commentsTableView cellButtonTapped:indexPath];
//    }
//}
//
//- (void)tableView:(UITableView *)tableView cellButtonTapped:(NSIndexPath *)indexPath{
//    UIImage *heartFull = [UIImage imageNamed:@"reply-heart-full.png"];
//    CommentTableViewCell *cell = (CommentTableViewCell *)[commentsTableView cellForRowAtIndexPath:indexPath];
//    [cell.likeButton setImage:heartFull forState:UIControlStateNormal];
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return UITableViewAutomaticDimension;
//}

#pragma mark - Segmented Control
- (void) addSegmentedControl {
    NSArray *segmentItems = [NSArray arrayWithObjects: @"Recent", @"Popular", nil];
    segmentedControl = [[UISegmentedControl alloc] initWithItems: segmentItems];
    
    [segmentedControl addTarget: self action: @selector(onSegmentedControlChanged:) forControlEvents: UIControlEventValueChanged];
    
    segmentedControl.selectedSegmentIndex = kCVCommentModeRecent;
    [[UISegmentedControl appearance] setTitleTextAttributes:@{
                                                              NSForegroundColorAttributeName : [CommonUtility getColorFromHSBACVec:kAUCColorPrimary]
                                                              } forState:UIControlStateNormal];
    [[UISegmentedControl appearance] setTintColor:[CommonUtility getColorFromHSBACVec:kAUCColorPrimary]];
    // segmentedControl.frame = CGRectMake(0, 0, 120, 30);
    //self.navigationItem.titleView = segmentedControl;
    //   self.tableView.tableHeaderView = segmentedControl;
    //  [self.navigationController.navigationItem setPrompt:@"some prompt text"];
    self.navigationItem.titleView = segmentedControl;
    //[self.view addSubview:segmentedControl];
}

- (void) onSegmentedControlChanged:(UISegmentedControl *) sender {
    
    [self updateCommentArrayWithMode:kAPICommentRefreshModeRefresh];
    
    //    if (sender.selectedSegmentIndex == 0) {
    //        segmentedControl.selectedSegmentIndex = 0;
    //        // switch active array pointer to popular array
    //        activeArray = popularArray;
    //        [commentsTableView reloadData];
    //    }
    //    else if (sender.selectedSegmentIndex == 1){
    //        segmentedControl.selectedSegmentIndex = 1;
    //        // switch active array pointer to recent array
    //        activeArray = recentArray;
    //        [commentsTableView reloadData];
    //    }
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
    [sendButton addTarget:self action:@selector(postComment:) forControlEvents:UIControlEventTouchUpInside];
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

    UIButton *cancelBtn = [CommentViewHelper getCancelButton];
    [cancelBtn addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithCustomView:cancelBtn];
    self.navigationItem.leftBarButtonItem = cancelButton;
    
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
#pragma mark - Touch gesture
- (void)addGesture{
    touchRecognized = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchRecognized:)];
    [touchRecognized setNumberOfTapsRequired:1];
    [commentsTableView addGestureRecognizer:touchRecognized];
}

- (void)touchRecognized:(UITapGestureRecognizer *)sender{
    [self textButtonPressed:self];
}

- (void)textButtonPressed:(id)sender {
    commentText.text = @"";

    [self disableKeyBoard];
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
//- (void)layoutIfNeeded{
//    NSLog(@"blah");
//    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(commentsTableView, sendButton, commentText);
//    NSDictionary *metrics = @{@"totalHeight":[NSNumber numberWithFloat:totalHeight]};
//    [self layoutCommentSectionViewWithDictionary:viewsDictionary andMetrics:metrics];
//}
- (void)keyboardWasShown:(NSNotification *)notification {
    if(keyboardHeight!=0.0){
        totalHeight = 10 + keyboardHeight;
        [self.view setNeedsLayout];
         [self.view updateConstraints];
        return;
    }
    // get keyboard size
    NSDictionary *keyboardInfo = [notification userInfo];
    NSValue *keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
    keyboardHeight = keyboardFrameBeginRect.size.height;
    totalHeight = keyboardHeight + 10;
    [self.view setNeedsLayout];
     [self.view updateConstraints];
    //    [commentsTableView setContentOffset:
    //     CGPointMake(0, -commentsTableView.contentInset.top) animated:YES];
    //    [self.view setFrame:CGRectMake(0,0-keyboardHeight,screenW, screenH)];
    //    [commentsTableView setContentOffset:
    //     CGPointMake(0, -commentsTableView.contentInset.top) animated:YES];
}




- (void)keyboardWillBeHidden:(NSNotification *)notification {
    //    scrollView.contentInset = contentInsets;
    //    scrollView.scrollIndicatorInsets = contentInsets;
//    [self.view setFrame:CGRectMake(0,64,screenW,screenH-64)];
    totalHeight = 10;
    [self.view setNeedsLayout];
    [self.view updateConstraints];
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
    
    if (totalLength>kAPIValidationCommentMaxLength){
        return NO;
    }
    return YES;
}
- (void)disableKeyBoard{
    // disable keyboard
    [commentText resignFirstResponder];
}

#pragma mark - Button Action Methods
- (void)goBack:(id)sender {
    // go back
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)sendButtonPressed:(id)sender {
    // send Message and clear content
    
    [self disableKeyBoard];
    commentText.text = @"";
}


- (void)postComment:(id)sender {
    
    [self disableKeyBoard];
    
    // Analytics: Flurry
    [Flurry logEvent:[FlurryManager getEventName:kFACommentPost]];
    
    
    // post content
    [activityIndicator startAnimating];
    
    // post content user
    [activityIndicator startAnimating];
    [[ApiManager sharedApiManager] postCommentWithContentId:(int)[self.currentContent.contentId integerValue]
                                                       text:commentText.text
                                                    success:^(ApiComment *comment) {
                                                        [activityIndicator stopAnimating];
                                                        [self actionsForSuccessfulPostComment];
                                                    }
                                                    failure:^(NSError *error) {
                                                        // Analytics: Flurry
                                                        [Flurry logEvent:[FlurryManager getEventName:kFACommentPostFailure] withParameters:@{@"Error":error}];
                                                        [activityIndicator stopAnimating];
                                                        [ApiErrorManager displayAlertWithError:error withDelegate:self];
                                                    }];
    
    
}

#pragma mark - Api Manager Post actions methods
- (void)actionsForSuccessfulPostComment{
    // Analytics: Flurry
    [Flurry logEvent:[FlurryManager getEventName:kFACommentPostSuccess]];
    
    commentText.text = @"";
    commentsTableView.estimatedRowHeight = 44.0;
    commentsTableView.rowHeight = UITableViewAutomaticDimension;
    
    //    UIAlertView *alertView  = [[UIAlertView alloc] initWithTitle:@"Post Successful"
    //                                                         message:@""
    //                                                        delegate:self
    //                                               cancelButtonTitle:nil
    //                                               otherButtonTitles:nil];
    //
    //    [alertView show];
    //
    //    // dismiss autometically
    //    [self performSelector:@selector(dismissAlertView:) withObject:alertView afterDelay:1.0];
    [self updateCommentArrayWithMode:kAPICommentRefreshModeRefresh];
}
-(void)dismissAlertView:(UIAlertView *)alertView{
    [alertView dismissWithClickedButtonIndex:0 animated:YES];
}
#pragma mark - Api Manager Get actions methods
-(void)updateCommentArrayWithMode:(kAPICommentRefreshMode)updateMode{
    if (isUpdateActive) {
        return;
    }
    isUpdateActive = true;
    if (segmentedControl.selectedSegmentIndex == kCVCommentModeRecent){
        [self updateCommentArrayRecentWithMode:updateMode];
    }
    else{
        [self updateCommentArrayPopularWithMode:updateMode];
    }
    
    NSLog(@"commenet array count %ld", (unsigned long)activeArray.count);
}
- (void)updateCommentArrayRecentWithMode:(kAPICommentRefreshMode)updateMode{
    // Analytics: Flurry
    [Flurry logEvent:[FlurryManager getEventName:kFACommentGetRecent]];
    
    // post content
    [activityIndicator startAnimating];
    
    int offset = (updateMode==kAPICommentRefreshModeGetMore)?(int)[recentArray count]:0;
    
    // post content user
    [activityIndicator startAnimating];
    [[ApiManager sharedApiManager] getCommentsForContentId:(int)[self.currentContent.contentId integerValue]
                                                      mode:kAPICommentOrderModeRecent
                                                     count:kCVC_DEFAULT_NUMBER_OF_COMMENTS
                                                    offset:offset
                                                   success:^(NSArray *commentArray) {
                                                       [activityIndicator stopAnimating];
                                                       // Analytics: Flurry
                                                       [Flurry logEvent:[FlurryManager getEventName:kFACommentGetRecentSuccess]];
                                                       if(updateMode==kAPICommentRefreshModeGetMore){
                                                           [recentArray addObjectsFromArray:commentArray];
                                                       }
                                                       else{
                                                           [recentArray setArray:commentArray];
                                                       }
                                                       activeArray =recentArray;
                                                       [commentsTableView reloadData];
                                                       isUpdateActive = false;
                                                   }
                                                   failure:^(NSError *error) {
                                                       // Analytics: Flurry
                                                       [Flurry logEvent:[FlurryManager getEventName:kFACommentGetRecentFailure] withParameters:@{@"Error":error}];
                                                       [activityIndicator stopAnimating];
                                                       [ApiErrorManager displayAlertWithError:error withDelegate:self];
                                                       isUpdateActive = false;
                                                   }];
}

- (void)updateCommentArrayPopularWithMode:(kAPICommentRefreshMode)updateMode{
    // Analytics: Flurry
    [Flurry logEvent:[FlurryManager getEventName:kFACommentGetPopular]];
    
    
    // post content
    [activityIndicator startAnimating];
    
    int offset = (updateMode==kAPICommentRefreshModeGetMore)?(int)[popularArray count]:0;
    
    // post content user
    [activityIndicator startAnimating];
    [[ApiManager sharedApiManager] getCommentsForContentId:(int)[self.currentContent.contentId integerValue]
                                                      mode:kAPICommentOrderModePopular
                                                     count:kCVC_DEFAULT_NUMBER_OF_COMMENTS
                                                    offset:offset
                                                   success:^(NSArray *commentArray) {
                                                       [activityIndicator stopAnimating];
                                                       // Analytics: Flurry
                                                       [Flurry logEvent:[FlurryManager getEventName:kFACommentGetPopularSuccess]];
                                                       if(updateMode==kAPICommentRefreshModeGetMore){
                                                           [popularArray addObjectsFromArray:commentArray];
                                                       }
                                                       else{
                                                           [popularArray setArray:commentArray];
                                                       }
                                                       
                                                       activeArray =popularArray;
                                                       [commentsTableView reloadData];
                                                       isUpdateActive = false;
                                                   }
                                                   failure:^(NSError *error) {
                                                       // Analytics: Flurry
                                                       [Flurry logEvent:[FlurryManager getEventName:kFACommentGetPopularFailure] withParameters:@{@"Error":error}];
                                                       [activityIndicator stopAnimating];
                                                       [ApiErrorManager displayAlertWithError:error withDelegate:self];
                                                       isUpdateActive = false;
                                                   }];
    
}
- (void)postCommentLikeWithIndexPath:(NSIndexPath *)indexPath{
    // Analytics: Flurry
    [Flurry logEvent:[FlurryManager getEventName:kFACommentGetPopular]];
    
    
    // post content
    [activityIndicator startAnimating];
    
    
    
    // get comment id
   // NSLog(@"index path row: %ld ", (long)indexPath.row);
    ApiComment *comment =(ApiComment *)[activeArray objectAtIndex:indexPath.row];
    int commentId =(int)[comment.commentId  integerValue];
    
    // post content user
    [activityIndicator startAnimating];
    [[ApiManager sharedApiManager] postCommentResponseWithCommentId:commentId
                                                            success:^(ApiCommentResponse *commentResponse) {
                                                                // Analytics: Flurry
                                                                [Flurry logEvent:[FlurryManager getEventName:kFACommentGetPopularSuccess]];
                                                                [activityIndicator stopAnimating];
                                                                // like button state
                                                                comment.didLike = [NSNumber numberWithBool:true];
                                                                [self updateLikeButtonWithIndexPath:indexPath];
                                                                
                                                            }
                                                            failure:^(NSError *error) {
                                                                // Analytics: Flurry
                                                                [Flurry logEvent:[FlurryManager getEventName:kFACommentGetPopularFailure] withParameters:@{@"Error":error}];
                                                                [activityIndicator stopAnimating];
                                                                [ApiErrorManager displayAlertWithError:error withDelegate:self];
                                                            } ];
    
    
}
- (void)updateLikeButtonWithIndexPath:(NSIndexPath *)indexPath{
    CommentTableViewCell *cell = (CommentTableViewCell *)[commentsTableView cellForRowAtIndexPath:indexPath];
    
    cell.likeButton.didLike=true;
    
    // comment count tag
    // .text = [CommonUtility getFixedLengthStringForNumber:currentContent.commentCount];
    
}
#pragma mark - temp code
//- (void) createAllDummyLists{
//    recentArray = @[@"1. Ninety-nine percent of lawyers give the rest a bad name. I AM GOING TO WRITE LONG TEST TEXT TO TEST HOW MANY LONG BLAH BLAH BLAH BLAH BAF;ASDJFK;LJ;",
//                    @"2. Borrow money from a pessimist -- they don't expect it back.",
//                    @"3. Time is what keeps things from happening all at once.",
//                    @"4. Lottery: A tax on people who are bad at math.",
//                    @"5. I didn't fight my way to the top of the food chain to be a vegetarian.",
//                    @"6. Never answer an anonymous letter.",
//                    @"7. It's lonely at the top; but you do eat better.",
//                    @"8. I don't suffer from insanity; I enjoy every minute of it.",
//                    @"9. Always go to other people's funerals, or they won't go to yours.",
//                    @"10. Few women admit their age; few men act it.",
//                    @"11. If we aren't supposed to eat animals, why are they made with meat?",
//                    @"12. No one is listening until you make a mistake.",
//                    @"13. Give me ambiguity or give me something else.",
//                    @"14. We have enough youth. How about a fountain of Smart?",
//                    @"15. He who laughs last thinks slowest.",
//                    @"16. Campers: Nature's way of feeding mosquitoes.",
//                    @"17. Always remember that you are unique; just like everyone else.",
//                    @"18. Consciousness: That annoying time between naps.",
//                    @"19. There are three kinds of people: Those who can count and those who can't.",
//                    @"20. Why is abbreviation such a long word?",
//                    @"21. Nuke the Whales.",
//                    @"22. I started out with nothing and I still have most of it.",
//                    @"23. Change is inevitable, except from a vending machine.",
//                    @"24. Out of my mind. Back in five minutes.",
//                    @"25. A clear conscience is usually the sign of a bad memory.",
//                    @"26. As long as there are tests, there will be prayer in public schools.",
//                    @"27. Laugh alone and the world thinks you're an idiot.",
//                    @"28. Sometimes I wake up grumpy; other times I let her sleep.",
//                    @"29. The severity of the itch is inversely proportional to the ability to reach it.",
//                    @"30. You can't have everything; where would you put it?",
//                    @"31. I took an IQ test and the results were negative.",
//                    @"32. Okay, who stopped the payment on my reality check?"
//                    ];
//
//    popularArray = @[@"Popular: 1. Ninety-nine percent of lawyers give the rest a bad name.",
//                    @"Popular: 2. Borrow money from a pessimist -- they don't expect it back.",
//                    @"Popular: 3. Time is what keeps things from happening all at once.",
//                    @"Popular: 4. Lottery: A tax on people who are bad at math.",
//                    @"Popular: 5. I didn't fight my way to the top of the food chain to be a vegetarian.",
//                    @"Popular: 6. Never answer an anonymous letter.",
//                    @"Popular: 7. It's lonely at the top; but you do eat better.",
//                    @"Popular: 8. I don't suffer from insanity; I enjoy every minute of it.",
//                    @"Popular: 9. Always go to other people's funerals, or they won't go to yours.",
//                    @"Popular: 10. Few women admit their age; few men act it.",
//                    @"Popular: 11. If we aren't supposed to eat animals, why are they made with meat?",
//                    @"Popular: 12. No one is listening until you make a mistake.",
//                    @"Popular: 13. Give me ambiguity or give me something else.",
//                    @"Popular: 14. We have enough youth. How about a fountain of Smart?",
//                    @"Popular: 15. He who laughs last thinks slowest.",
//                    @"Popular: 16. Campers: Nature's way of feeding mosquitoes.",
//                    @"Popular: 17. Always remember that you are unique; just like everyone else.",
//                    @"Popular: 18. Consciousness: That annoying time between naps.",
//                    @"Popular: 19. There are three kinds of people: Those who can count and those who can't.",
//                    @"Popular: 20. Why is abbreviation such a long word?",
//                    @"Popular: 21. Nuke the Whales.",
//                    @"Popular: 22. I started out with nothing and I still have most of it.",
//                    @"Popular: 23. Change is inevitable, except from a vending machine.",
//                    @"Popular: 24. Out of my mind. Back in five minutes.",
//                    @"Popular: 25. A clear conscience is usually the sign of a bad memory.",
//                    @"Popular: 26. As long as there are tests, there will be prayer in public schools.",
//                    @"Popular: 27. Laugh alone and the world thinks you're an idiot.",
//                    @"Popular: 28. Sometimes I wake up grumpy; other times I let her sleep.",
//                    @"Popular: 29. The severity of the itch is inversely proportional to the ability to reach it.",
//                    @"Popular: 30. You can't have everything; where would you put it?",
//                    @"Popular: 31. I took an IQ test and the results were negative.",
//                    @"Popular: 32. Okay, who stopped the payment on my reality check?"
//                    ];
//
//}

@end
