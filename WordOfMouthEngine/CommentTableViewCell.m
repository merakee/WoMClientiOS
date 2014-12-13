//
//  CommentTableViewCell.m
//  WordOfMouthEngine
//
//  Created by Kevin Moy on 11/18/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import "CommentTableViewCell.h"
#import "CommentViewHelper.h"

@implementation CommentTableViewCell
@synthesize likeButton;
@synthesize commentCellLabel;
@synthesize likeCount;
- (id)init {
    if (self = [super init]) {
        [self setView];
    }
    return self;
}

- (void)setView{
    self.commentCellLabel = [CommentViewHelper getCellText];
    self.likeButton = [CommentViewHelper getCellButton];
    self.likeCount = [CommentViewHelper getLikeCount];
    //    [self.likeButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:self.commentCellLabel];
    [self addSubview:self.likeCount];
    [self addSubview:self.likeButton];

    // layout
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(likeButton,commentCellLabel, likeCount);
    
    // like Button
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-13-[likeButton(15)]-2-[likeCount(10)]"
                                                                 options:0 metrics:nil views:viewsDictionary]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-13-[commentCellLabel]-13-|"                                                                      options:0 metrics:nil views:viewsDictionary]];
//    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[likeButton(15)]"                                                                      options:0 metrics:nil views:viewsDictionary]];
//   [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[likeCount(15)]"                                                                      options:0 metrics:nil views:viewsDictionary]];
    
    // Comment label
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[commentCellLabel]-5-[likeCount(15)]-15-|"                                                                      options:0 metrics:nil views:viewsDictionary]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[commentCellLabel]-5-[likeButton(15)]-15-|"                                                                      options:0 metrics:nil views:viewsDictionary]];

    
    
    
}

@end
