//
//  CustomContentView.m
//  WordOfMouthEngine
//
//  Created by Kevin Moy on 10/21/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import "CustomContentView.h"
#import "ContentViewHelper.h"

@implementation CustomContentView

- (void)loadView {
    //[super loadView];
    // view customization code
    [self setView];
}

- (void)setView{
 //   NSLog(@"blah");
    // set customContentView
    contentView = [[UIView alloc] init];
    [contentView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    contentImageView = [ContentViewHelper getContentBackGroundView];
    contentTextView = [ContentViewHelper getContentTextViewWithDelegate:self];
  
    [self layoutView];
}

- (void)layoutView{
    // Constraints
    
//    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(contentView, contentTextView, contentImageView);
        // text view
//        [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[contentImageView]|"
//                                                                          options:0 metrics:nil views:viewsDictionary]];
//    
//        [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[contentImageView]|"
//                                                                          options:0 metrics:nil views:viewsDictionary]];
//
//    
//    
//    
//        // text view placement
//        [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-16-[contentTextView]-16-|"
//                                                                            options:0 metrics:nil views:viewsDictionary]];
//    
//        [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-16-[contentTextView]-16-|"
//                                                                            options:0 metrics:nil views:viewsDictionary]];
}
@end
