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
#import "ContentTableViewCell.h"
#import "ContentViewController.h"
#import "CustomContentView.h"
#import "PublicProfileViewController.h"
@implementation CommentViewController
@synthesize segmentedControl;
@synthesize currentContent;
@synthesize keyboardConstraints;
@synthesize favoriteButton;
#pragma mark -  init methods
- (id)init {
    if (self = [super init]) {
        // [self createAllDummyLists];
        recentArray = [[NSMutableArray alloc] init];
        popularArray = [[NSMutableArray alloc] init];
        activeArray = [[NSMutableArray alloc] init];
        keyboardConstraints = [[NSMutableArray alloc] init];
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
   // [self.navigationController setNavigationBarHidden:NO];
    //    [self onSegmentedControlChanged:segmentedControl];
    //    [self textViewDidChange:commentText];
    //    [commentText becomeFirstResponder];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
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
- (BOOL)prefersStatusBarHidden {
    return YES;
}
#pragma mark -  Local Methods Implememtation
- (void)setView {
    
    // set app defaults
    [AppUIManager setUIView:self.view ofType:kAUCPriorityTypePrimary];

    [self onSegmentedControlChanged:segmentedControl];
    [self addSegmentedControl];
    [self setupTableView];
    [self.view addSubview:commentsTableView];
    
    //activity indicator view
    activityIndicator =[[UIActivityIndicatorView alloc] init];
    [AppUIManager addActivityIndicator:activityIndicator toView:self.view];
    
    // Send Button
    sendButton = [CommentViewHelper getSendButton];
    [sendButton addTarget:self action:@selector(postComment:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendButton];
    
    // Comment Textbox
    commentText = [CommentViewHelper getCommentText:self];
    [self.view addSubview:commentText];
    
    // Navigation Buttons and View
    navigationShadow = [CommentViewHelper getNavigationShadow];
    [self.view addSubview:navigationShadow];
    
    // Cancel Button
    cancelButton = [CommentViewHelper getCancelButton];
    [cancelButton addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    [navigationShadow addSubview:cancelButton];
    
    // Share Button
    shareButton = [CommentViewHelper getShareButton];
    [shareButton addTarget:self action:@selector(shareButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [navigationShadow addSubview:shareButton];
    
    // Report Button
    reportButton = [CommentViewHelper getReportButton];
    [reportButton addTarget:self action:@selector(goToReportMessage:) forControlEvents:UIControlEventTouchUpInside];
    [navigationShadow addSubview:reportButton];
    
    // Favorite Button
    favoriteButton = [CommentViewHelper getFavoriteButton];
    [favoriteButton addTarget:self action:@selector(favoriteButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [navigationShadow addSubview:favoriteButton];
    
    [self layoutView];
    [ApiContent printContentInfo:currentContent];
    [self addGesture];
}

- (void)layoutView{
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(commentsTableView, sendButton, commentText, segmentedControl, cancelButton, shareButton, reportButton, navigationShadow, favoriteButton);
    // Navigation Bar
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[navigationShadow]|"                                                                      options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[navigationShadow(44)]"                                                                      options:0 metrics:nil views:viewsDictionary]];
    [navigationShadow addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[cancelButton(44)]"                                                                      options:0 metrics:nil views:viewsDictionary]];
    [navigationShadow addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[cancelButton(44)]"                                                                      options:0 metrics:nil views:viewsDictionary]];
    [navigationShadow addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[reportButton(21)]-5-[favoriteButton(28)]-5-[shareButton(28)]-5-|"                                                                      options:0 metrics:nil views:viewsDictionary]];
    [navigationShadow addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[shareButton(38)]"                                                                      options:0 metrics:nil views:viewsDictionary]];
    [navigationShadow addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[reportButton(28)]"                                                                      options:0 metrics:nil views:viewsDictionary]];
    [navigationShadow addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[favoriteButton(42)]"                                                                      options:0 metrics:nil views:viewsDictionary]];
    
    // Table View
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[commentsTableView]|"                                                                      options:0 metrics:nil views:viewsDictionary]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[commentsTableView]-60-|"                                                                      options:0 metrics:nil views:viewsDictionary]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-6-[commentText(250)]-6-[sendButton(50)]"                                                                      options:0 metrics:nil views:viewsDictionary]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[sendButton(39)]"                                                                      options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[commentText(39)]"                                                                      options:0 metrics:nil views:viewsDictionary]];
    
    heightWithoutKeyboard=10.0;
    layoutConstraintSendButtonYPosition = [NSLayoutConstraint constraintWithItem:sendButton
                                                                       attribute:NSLayoutAttributeBottom
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:self.view
                                                                       attribute:NSLayoutAttributeBottom
                                                                      multiplier:1.0
                                                                        constant:-heightWithoutKeyboard];
    
    layoutConstraintTextFieldYPosition = [NSLayoutConstraint constraintWithItem:commentText
                                                                       attribute:NSLayoutAttributeBottom
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:self.view
                                                                       attribute:NSLayoutAttributeBottom
                                                                      multiplier:1.0
                                                                        constant:-heightWithoutKeyboard];
    
    [self.view addConstraint:layoutConstraintSendButtonYPosition];
    [self.view addConstraint:layoutConstraintTextFieldYPosition];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section. should be returning the number of comments
    return [activeArray count]+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        //         cell = [[CommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        if (indexPath.row == 0){
            // Get content cell
            cell = (ContentTableViewCell *)[[ContentTableViewCell alloc] init];
        }
        else {
        cell = (CommentTableViewCell *)[[CommentTableViewCell alloc] init];
        //   cellButton.tag = kCellButtonTag;
        }
    }
    if ([cell isKindOfClass:[ContentTableViewCell class]]){
            [self setupContentCell:(ContentTableViewCell *)cell indexPath:indexPath];
    }
    else {
        [self setupCommentCell:(CommentTableViewCell *)cell indexPath:indexPath];
    }
    return cell;
}
- (void)setupContentCell:(ContentTableViewCell *)cell indexPath:(NSIndexPath *)indexPath{
//    [cell.contentImage.contentImageView setImageWithURL:[NSURL URLWithString:currentContent.photoToken[@"url"]] placeholderImage:nil];
    cell.contentImage.contentImageView.image = self.currentImage;
    cell.contentImage.delegate = self;
   // cell.contentImage.contentImageView = [ContentViewController co
    //contentImage
    cell.commentCount.text = @"REPLIES ";
    [cell sizeToFit];
    
    if ([cell respondsToSelector:@selector(layoutMargins)]) {
        cell.layoutMargins = UIEdgeInsetsZero;
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
}

- (void)setupCommentCell:(CommentTableViewCell *)cell indexPath:(NSIndexPath *)indexPath{
    [cell.touchLike addTarget:self action:@selector(likeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    // [cell.likeButton addTarget:self action:@selector(likeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    ApiComment *apiComment =(ApiComment*) [activeArray objectAtIndex:indexPath.row-1];
    cell.likeButton.didLike =[apiComment.didLike boolValue];
    cell.likeCount.text = [apiComment.likeCount stringValue];
    cell.commentCellLabel.text = apiComment.commentText;
    [cell sizeToFit];
    //   NSLog(@"comment text: %@", apiComment.commentText);
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
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
}
#pragma mark - Customize cell
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.textLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
    //   cell.backgroundColor = [UIColor greenColor]; //must do here in willDisplayCell
    //   cell.textLabel.backgroundColor = [UIColor redColor]; //must do here in willDisplayCell
    //   cell.textLabel.textColor = [UIColor greenColor]; //can do here OR in cellForRowAtIndexPath
    //   tableView.separatorColor = [UIColor orangeColor];
}

-(void)likeButtonPressed:(CustomLikeButton *)sender{
    CommentTableViewCell *cell = (CommentTableViewCell*) sender.superview;
    if(cell.likeButton.didLike==true){
        return;
    }

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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0)
    {
        return 350;
    }
    return UITableViewAutomaticDimension;
}

#pragma mark - Segmented Control
- (void) addSegmentedControl {
    NSArray *segmentItems = [NSArray arrayWithObjects: @"Recent", @"Popular", nil];
    segmentedControl = [[UISegmentedControl alloc] initWithItems: segmentItems];
    
    [segmentedControl addTarget:self action:@selector(onSegmentedControlChanged:) forControlEvents: UIControlEventValueChanged];
    
    segmentedControl.selectedSegmentIndex = kCVCommentModeRecent;
    [[UISegmentedControl appearance] setTitleTextAttributes:@{
                                                              NSForegroundColorAttributeName : [CommonUtility getColorFromHSBACVec:kAUCColorPrimary]
                                                              } forState:UIControlStateNormal];
    [[UISegmentedControl appearance] setTintColor:[CommonUtility getColorFromHSBACVec:kAUCColorPrimary]];
     segmentedControl.frame = CGRectMake(0, 0, 120, 30);
    //self.navigationItem.titleView = segmentedControl;
    //   self.tableView.tableHeaderView = segmentedControl;
    [segmentedControl setTranslatesAutoresizingMaskIntoConstraints:NO];
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
}

- (void)setupTableView{
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

- (void)keyboardWasShown:(NSNotification *)notification {
    // get keyboard size
    NSDictionary *keyboardInfo = [notification userInfo];
    NSValue *keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
    float keyboardHeight  =keyboardFrameBeginRect.size.height;
    
    layoutConstraintSendButtonYPosition.constant = -(heightWithoutKeyboard +keyboardHeight);
    layoutConstraintTextFieldYPosition.constant = -(heightWithoutKeyboard +keyboardHeight);
    [self.view layoutIfNeeded];
    commentText.text = @"";
//    [commentsTableView setContentOffset:
//    CGPointMake(0, -commentsTableView.contentInset.top) animated:YES];
//    [self.view setFrame:CGRectMake(0,0-keyboardHeight,screenW, screenH)];
//    [commentsTableView setContentOffset: CGPointMake(0, -commentsTableView.contentInset.top) animated:YES];
    
}
-(void)updateConstraints{
    [self layoutView];
}

- (void)keyboardWillBeHidden:(NSNotification *)notification {
    layoutConstraintSendButtonYPosition.constant = -heightWithoutKeyboard;
    layoutConstraintTextFieldYPosition.constant = -heightWithoutKeyboard;
    [self.view layoutIfNeeded];
}
#pragma mark - ScrollView Delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    float bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height;
    if (bottomEdge >= scrollView.contentSize.height) {
        
        [self updateCommentArrayWithMode:kAPICommentRefreshModeGetMore];
    }
}

#pragma mark - Text changes
- (void)textViewDidBeginEditing:(UITextView *)textView{
    sendButton.enabled=NO;
}
- (void)textViewDidChange:(UITextView *)textView{
    long  textLength;// =[textView.text length];
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

#pragma mark - CustomContentView Delegate Methods
- (void)contentViewUserButton:(id)sender{
    PublicProfileViewController *pvc = [[PublicProfileViewController alloc] init];
    pvc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:pvc animated:NO];
}
#pragma mark - Button Action Methods
-(void)favoriteButtonPressed:(CustomFavoriteButton *)sender{
    if(favoriteButton.didFavorite==true){
        return;
    }
    else{
        favoriteButton.didFavorite = true;
        // Send server info that content was favorited
    }
//
//    NSIndexPath *indexPath = [commentsTableView indexPathForCell:cell];
//    [self postCommentLikeWithIndexPath:(NSIndexPath *)indexPath];
}
- (void)shareButtonPressed:(id)sender {
    NSString *message = @"Found in Spark http://www.sparkapp.social/";
    
    UIImage *imageToShare = self.currentImage;
    NSArray *postItems = [[NSArray alloc] initWithObjects:imageToShare, message, nil];
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
    //[[self parentViewController] presentViewController:activityVC animated:YES completion:nil];
}
-(void)goToReportMessage:(id)sender {
    // Display report message, report it to backend
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Content offensive?" message:@"Want to report this content?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    [alert show];
}
- (void)goBack:(id)sender {
    // go back
    [self.navigationController popViewControllerAnimated:NO];
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
    ApiComment *comment =(ApiComment *)[activeArray objectAtIndex:indexPath.row-1];
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
}
@end
