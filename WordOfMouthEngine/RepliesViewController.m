//
//  RepliesViewController.m
//  WordOfMouthEngine
//
//  Created by Kevin Moy on 11/10/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import "RepliesViewController.h"
#import "RepliesViewHelper.h"
#import "ApiManager.h"
#import "FlurryManager.h"

@interface RepliesViewController ()

@end

@implementation RepliesViewController

- (id)init{
    if (self = [super init]) {
        
    }
    return self;
}
- (void)loadView {
    [super loadView];
    
    [self setView];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    // Analytics: Flurry
    [Flurry logEvent:[FlurryManager getEventName:kFAComposeSession] withParameters:nil timed:YES];
    // display key board
 //   [repliesTextView becomeFirstResponder];
 //   [self textViewDidChange:repliesTextView];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Local View Methods Implementation
- (void)setView {
    
    // set view
    [RepliesViewHelper setView:self.view];

    // hide navigation bar
    [self.navigationController setNavigationBarHidden:YES];

    // scrollView
    scrollView = [RepliesViewHelper getScrollView];
  //  scrollView.frame = self.view.bounds;
    [self.view addSubview:scrollView];
    
    // set TextView
    repliesTextView = [RepliesViewHelper getRepliesTextViewWithDelegate:self];
    [self.view addSubview:repliesTextView];
    
    //activity indicator view
    activityIndicator =[[UIActivityIndicatorView alloc] init];
    [AppUIManager addActivityIndicator:activityIndicator toView:self.view];

    //buttons
    backButton = [RepliesViewHelper getBackButton];
    [backButton addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    
    sendButton = [RepliesViewHelper getSendButton];
    [sendButton addTarget:self action:@selector(sendComment:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:backButton];
    [self.view addSubview:sendButton];
    
    // Placeholder label
    placeHolderLabel = [RepliesViewHelper getPlaceHolderLabel];
    [self.view addSubview:placeHolderLabel];
    
    // layout
    [self layoutView];
}

- (void)layoutView{
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(repliesTextView, backButton, sendButton, placeHolderLabel);
    
    // buttons
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[backButton(20)]"                                                                      options:0 metrics:nil views:viewsDictionary]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[backButton(20)]"                                                                      options:0 metrics:nil views:viewsDictionary]];

    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-525-[repliesTextView]-4-|"
                                                                      options:0 metrics:nil views:viewsDictionary]];
    
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-4-[repliesTextView]-50-|"
//                                                                      options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-525-[sendButton]-4-|"
                                                                      options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-4-[repliesTextView]-4-[sendButton]-4-|"
                                                                      options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-525-[placeHolderLabel]-4-|"
                                                                      options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[placeHolderLabel]|"
                                                                     options:0 metrics:nil views:viewsDictionary]];
    
}

#pragma mark - Input Accessory View
- (void)disableKeyboard{
    [repliesTextView resignFirstResponder];
}

-(void)cancelText{
    [repliesTextView resignFirstResponder];
}

#pragma mark - TextView delegate methods
- (void)textViewDidBeginEditing:(UITextView *)textView{
    repliesTextView = textView;
}

- (void)textViewDidChange:(UITextView *)textView{
//    long  textLength =[textView.text length];
//    int maxLength = 200;
//    long charLeft = maxLength - [textView.text length];
    //    NSString *substring = [NSString stringWithString:composeTextView];
    
//    //   Add swipe gesture
//    panRecognized = [[UIPanGestureRecognizer alloc]
//                     initWithTarget:self
//                     action:@selector(panRecognized:)];
//    
//    [panRecognized setMinimumNumberOfTouches:1];
//    [panRecognized setMaximumNumberOfTouches:1];
//    
//    [[self view] addGestureRecognizer:panRecognized];
//    
//    // place holder text
//    if(( textLength == 0)&&(placeHolderLabel.isHidden)){
//        placeHolderLabel.hidden=NO;
//        characterCount.text = [NSString stringWithFormat:@"%ld", charLeft];
//    }
//    else if((textLength> 0)&&(!placeHolderLabel.isHidden)){
//        placeHolderLabel.hidden=YES;
//    }
//    // Update remaining characters
//    if (textLength >0){
//        characterCount.text = [NSString stringWithFormat:@"%ld", charLeft];
//    }
//    
//    textLength =[[CommonUtility  trimString:textView.text ] length];
//    
//    // post button
//    if((textLength < kAPIValidationContentMinLength)&&(postButton.isEnabled)){
//        postButton.enabled=NO;
//    }
//    else if((textLength >= kAPIValidationContentMinLength)&&(!postButton.isEnabled)){
//        postButton.enabled=YES;
//    }

}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    // return key
    if([text isEqualToString:@"\n"]) {
        //        [self postContent:nil];
        
        
        [repliesTextView resignFirstResponder];
        return YES;
    }
    
    long totalLength = textView.text.length - range.length + text.length;
    
    if (totalLength>kAPIValidationContentMaxLength){
        return NO;
    }
    return YES;
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
    
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(repliesTextView, backButton, sendButton, placeHolderLabel);

//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-325-[sendButton]-4-|"
//                                                                      options:0 metrics:nil views:viewsDictionary]];
//    NSDictionary* info = [notification userInfo];
//    
//    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
//    
//    CGPoint buttonOrigin = sendButton.frame.origin;
//    CGFloat buttonHeight = sendButton.frame.size.height;
//    CGRect visibleRect = self.view.frame;
//
//    visibleRect.size.height -= keyboardSize.height;
//    
//    if (!CGRectContainsPoint(visibleRect, buttonOrigin)){
//        
//        CGPoint scrollPoint = CGPointMake(0.0, buttonOrigin.y - visibleRect.size.height + buttonHeight);
//        NSLog(@"scroll up nigga");
//        [scrollView setContentOffset:scrollPoint animated:YES];
//    }
}

- (void)keyboardWillBeHidden:(NSNotification *)notification {
//    [scrollView setContentOffset:CGPointZero animated:YES];
    CGRect frame = self.view.frame;
    frame.origin.y = 0;
}
#pragma mark - Button Action Methods
- (void)postContent:(id)sender {
    // Analytics: Flurry
    [Flurry logEvent:[FlurryManager getEventName:kFAComposePost]];
    
    // attempt to post content
    ApiContent *ci =[[ApiContent alloc] init];
    ci.contentText = [CommonUtility trimString:repliesTextView.text];
    ci.categoryId = [NSNumber numberWithInteger: kAPIContentCategoryNews];
    //    if(categoryControl.selectedSegmentIndex==UISegmentedControlNoSegment){
    //        ci.categoryId = [NSNumber numberWithInteger: kAPIContentCategoryOther];
    //    }
    //    else{
    //        ci.categoryId = [NSNumber numberWithInteger:categoryControl.selectedSegmentIndex+1];
    //    }
    
    // disable post button
//    postButton.enabled = NO;
    
    // post content
    [activityIndicator startAnimating];
    
    // post content user
    [activityIndicator startAnimating];
//    [[ApiManager sharedApiManager] postContentWithCategoryId:(int)ci.categoryId.integerValue
//                                                        text:ci.contentText
//                                                       photo:contentImageView.image
//                                                     success:^(ApiContent * content){
//                                                         [activityIndicator stopAnimating];
//                                                         [self actionsForSuccessfulPostContent];
//                                                     }failure:^(NSError * error){
//                                                         // Analytics: Flurry
//                                                         [Flurry logEvent:[FlurryManager getEventName:kFAComposePostFailure] withParameters:@{@"Error":error}];
//                                                         [activityIndicator stopAnimating];
//                                                         [ApiErrorManager displayAlertWithError:error withDelegate:self];
//                                                     }];
//    
}
- (void)goBack:(id)sender {
    // go back
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)sendComment:(id)sender {
    
}
- (void)clearViewAfterSuccessfulPostOrCancel{
    repliesTextView.text=nil;
}
@end
