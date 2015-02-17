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
    
    //self.contentImage.contentMode = UIViewContentModeScaleToFill;
    self.contentImage.contentImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    self.contentImage.contentImageView.backgroundColor = [UIColor blueColor];
    [self addSubview:contentImage];
    contentImage.backgroundColor = [UIColor redColor];
    // layout
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(contentImage);
    
    // content image
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[contentImage]"
                                                                 options:0 metrics:nil views:viewsDictionary]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[contentImage]|"
                                                                options:0 metrics:nil views:viewsDictionary]];
    
}

@end
