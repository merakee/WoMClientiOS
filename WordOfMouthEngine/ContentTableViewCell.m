//
//  CommentTableViewCell.m
//  WordOfMouthEngine
//
//  Created by Kevin Moy on 11/18/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import "ContentTableViewCell.h"
#import "CommentViewHelper.h"

@implementation ContentTableViewCell
@synthesize contentImage;
@synthesize commentCountView;
@synthesize commentCount;

- (id)init {
    if (self = [super init]) {
        [self setView];
    }
    return self;
}

- (void)setView{
    self.contentImage = [[CustomContentView alloc] init];
    [self.contentImage setView];
    [self.contentImage setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    self.contentImage.contentImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    self.contentImage.contentImageView.backgroundColor = [UIColor blueColor];
    [self addSubview:contentImage];
    contentImage.backgroundColor = [UIColor redColor];
    
    self.commentCountView = [CommentViewHelper getCommentCountView];
    [self addSubview:commentCountView];
    
    self.commentCount = [CommentViewHelper getCommentCount];
    [commentCountView addSubview:commentCount];
    // layout
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(contentImage, commentCountView, commentCount);
    
    // content image
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[contentImage]-0-[commentCountView(20)]"
                                                                 options:0 metrics:nil views:viewsDictionary]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[contentImage]|"
                                                                options:0 metrics:nil views:viewsDictionary]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[commentCountView]|"
                                                                 options:0 metrics:nil views:viewsDictionary]];
    [commentCountView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[commentCount(14)]"
                                                                 options:0 metrics:nil views:viewsDictionary]];
    [commentCountView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[commentCount]"
                                                                             options:0 metrics:nil views:viewsDictionary]];
    [AppUIManager verticallyCenterElement:commentCount inView:commentCountView];
    [AppUIManager horizontallyCenterElement:commentCount inView:commentCountView];
}

@end
