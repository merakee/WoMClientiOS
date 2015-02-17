//
//  TermsViewController.m
//  WordOfMouthEngine
//
//  Created by Kevin Moy on 12/10/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import "TermsViewController.h"
#import "SignInViewHelper.h"

@interface TermsViewController ()

@end

@implementation TermsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setView{
    textView = [[UITextView alloc] init];
    textView.text = [textView.text stringByAppendingString:kAUCTermsAndPrivacyText];
     textView.backgroundColor = [UIColor whiteColor];
    [textView setTranslatesAutoresizingMaskIntoConstraints:NO];
    textView.textColor = [UIColor blackColor];
    textView.textAlignment = NSTextAlignmentLeft;
    [textView setFont:[UIFont systemFontOfSize:15]];
    [self.view setBackgroundColor:[UIColor clearColor]];

    [self.view addSubview:textView];
    [self layoutView];
    [textView setUserInteractionEnabled:TRUE];
//    [[self navigationController] setNavigationBarHidden:NO animated:YES];
//    [self setNavigationBar];
//    termsWebView = [[UIWebView alloc] init];
//    [termsWebView setTranslatesAutoresizingMaskIntoConstraints:NO];
//    [termsWebView setDelegate:self];
//    [termsWebView sizeToFit];
//    NSURL *url = [NSURL URLWithString:@"http://www.sparkapp.social/terms.html"];
//    NSURLRequest *requestURL=[NSURLRequest requestWithURL:url];
//    [termsWebView loadRequest:requestURL];
//    [self.view addSubview:termsWebView];
//    [self.view setBackgroundColor:[UIColor blueColor]];
    [self layoutView];
}

- (void)layoutView{
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(textView);
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[textView]|"
                                                                      options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[textView]|"
                                                                      options:0 metrics:nil views:viewsDictionary]];
}
//- (void)webViewDidFinishLoad:(UIWebView *)webView{
//    CGSize contentSize = webView.scrollView.contentSize;
//    CGSize viewSize = self.view.bounds.size;
//    
//    float rw = viewSize.width / contentSize.width;
//    
//    webView.scrollView.minimumZoomScale = rw;
//    webView.scrollView.maximumZoomScale = rw;
//    webView.scrollView.zoomScale = rw;
//}
//- (void) setNavigationBar{
//    UIButton *cancelBtn = [CommentViewHelper getCancelButton];
//    [cancelBtn addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithCustomView:cancelBtn];
//    self.navigationItem.leftBarButtonItem = cancelButton;
//}
//- (void)goBack:(id)sender {
//    // go back
//    [self.navigationController popViewControllerAnimated:NO];
//}
@end
