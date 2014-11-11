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
//    [composeTextView becomeFirstResponder];
//    [self textViewDidChange:composeTextView];
}

- (void)viewWillDisappear:(BOOL)animated {
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

    // scrollView
    scrollView = [RepliesViewHelper getScrollView];
    [self.view addSubview:scrollView];
    
    
    //activity indicator view
    activityIndicator =[[UIActivityIndicatorView alloc] init];
    [AppUIManager addActivityIndicator:activityIndicator toView:self.view];

  // [scrollView setContentOffset:CGPointMake(x, y) animated:YES];
    
 //   [self layoutView];
}

- (void)layoutView{
//     NSDictionary *viewsDictionary = 
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
- (void)clearViewAfterSuccessfulPostOrCancel{
    repliesTextView.text=nil;
}
@end
