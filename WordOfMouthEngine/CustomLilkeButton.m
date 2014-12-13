//
//  CustomLilkeButton.m
//  WordOfMouthEngine
//
//  Created by Kevin Moy on 12/4/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import "CustomLilkeButton.h"
#import "CommentViewHelper.h"

@implementation CustomLilkeButton

@synthesize didLike = _didLike;

- (void)setDidLike:(bool)didLike_ {
    _didLike = didLike_;
    if (didLike_){
        [self setImage:[UIImage imageNamed:kAURFilledLikeImage] forState:UIControlStateNormal];
    }
    else {
        [self setImage:[UIImage imageNamed:kAUREmptyLikeImage] forState:UIControlStateNormal];
    }
}

@end