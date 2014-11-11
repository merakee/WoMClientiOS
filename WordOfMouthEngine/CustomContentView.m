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

@synthesize contentImageView;

- (void)loadView {
    //[super loadView];
    // view customization code
    [self setView];
}

- (void)setView{
    // set customContentView
    contentView = [[UIView alloc] init];
    [contentView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    [contentTextView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [contentImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
   
   
    contentImageView = [ContentViewHelper getContentBackGroundView];
    contentTextView = [ContentViewHelper getContentTextViewWithDelegate:self];

    [self addSubview:contentView];
    contentImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.clipsToBounds = YES;
    [contentView addSubview:contentImageView];
//    [contentView addSubview:contentTextView];
   // contentView.backgroundColor = [UIColor redColor];
    
    
    [self layoutView];
}

- (void)layoutView{
    // Constraints
    
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(contentView, contentImageView);
       //image view
        [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[contentImageView]|"
                                                                          options:0 metrics:nil views:viewsDictionary]];
    
        [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[contentImageView]|"
                                                                          options:0 metrics:nil views:viewsDictionary]];

    
    
    
        // text view placement
//        [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-16-[contentTextView]-16-|"
//                                                                            options:0 metrics:nil views:viewsDictionary]];
//    
//        [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-16-[contentTextView]-16-|"
//                                                                            options:0 metrics:nil views:viewsDictionary]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[contentView]|"
                                                                        options:0 metrics:nil views:viewsDictionary]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[contentView]|"
                                                                        options:0 metrics:nil views:viewsDictionary]];
   
}



- (void)setImage:(UIImage *)image{
    contentImageView.image = image;
}

- (void)setAttributedText:(NSAttributedString *)text{
    contentTextView.attributedText = text;
}
@end
