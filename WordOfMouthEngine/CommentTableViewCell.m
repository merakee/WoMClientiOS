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
- (id)init {
    if (self = [super init]) {
        [self setView];
    }
    return self;
}

- (void)setView{
    self.commentCellLabel = [CommentViewHelper getCellText];
    self.likeButton = [CommentViewHelper getCellButton];
  //  self.commentCellLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 40)];
    [self addSubview:self.commentCellLabel];
    [self addSubview:self.likeButton];
    // layout
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(likeButton,commentCellLabel);
    
    // like Button
//    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[likeButton(18)]-5-|"                                                                      options:0 metrics:nil views:viewsDictionary]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-2-[likeButton]-2-|"                                                                      options:0 metrics:nil views:viewsDictionary]];

    // Comment label
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[commentCellLabel]-20-[likeButton(18)]-5-|"                                                                      options:0 metrics:nil views:viewsDictionary]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-2-[commentCellLabel]-2-|"                                                                      options:0 metrics:nil views:viewsDictionary]];


}

@end
