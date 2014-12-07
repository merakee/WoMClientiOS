//
//  CustomLilkeButton.m
//  WordOfMouthEngine
//
//  Created by Kevin Moy on 12/4/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import "CustomLilkeButton.h"

@implementation CustomLilkeButton

@synthesize didLike = _didLike;

- (void)setDidLike:(bool)didLike_ {
    _didLike = didLike_;
    if (didLike_){
        self.imageView.image = [UIImage imageNamed:@"reply-heart-full.png"];
    }
    else {
        self.imageView.image = [UIImage imageNamed:@"reply-heart-empty.png"];
        
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
