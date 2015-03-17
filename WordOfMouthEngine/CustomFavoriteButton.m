//
//  CustomFavoriteButton.m
//  WordOfMouthEngine
//
//  Created by Kevin Moy on 3/11/15.
//  Copyright (c) 2015 Bijit Halder. All rights reserved.
//

#import "CustomFavoriteButton.h"
#import "CommentViewHelper.h"
@implementation CustomFavoriteButton

@synthesize didFavorite = _didFavorite;

- (void)setDidFavorite:(bool)didFavorite_{
    _didFavorite = didFavorite_;
    if (didFavorite_){
        NSLog(@"favorite filled");
        [self setImage:[UIImage imageNamed:kAURFilledFavoriteImage] forState:UIControlStateNormal];
    }
    else {
         NSLog(@"favorite empty");
        [self setImage:[UIImage imageNamed:kAUREmptyFavoriteImage] forState:UIControlStateNormal];
    }
}
@end
