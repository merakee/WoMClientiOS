//
//  ImageSearchViewController.m
//  WordOfMouthEngine
//
//  Created by Kevin Moy on 1/14/15.
//  Copyright (c) 2015 Bijit Halder. All rights reserved.
//

#import "ImageSearchViewController.h"

@interface ImageSearchViewController ()

@end

@implementation ImageSearchViewController

- (void)viewDidLoad {
 //   [super viewDidLoad];
    [self setView];
}

- (void)didReceiveMemoryWarning {
  //  [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setView{
  //  [[self navigationController] setNavigationBarHidden:NO animated:YES];
    webImageSearch = [[UIWebView alloc] init];
    [webImageSearch setTranslatesAutoresizingMaskIntoConstraints:NO];
  //  [webImageSearch setDelegate:self];
    [webImageSearch sizeToFit];
    [self addSubview:webImageSearch];
    [self setBackgroundColor:[UIColor blueColor]];
    [self layoutView];
}
- (void)layoutView{
    // Constraints
    
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(webImageSearch);
    //image view
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[webImageSearch]|"
                                                                        options:0 metrics:nil views:viewsDictionary]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[webImageSearch]|"
                                                                        options:0 metrics:nil views:viewsDictionary]];
}
@end
