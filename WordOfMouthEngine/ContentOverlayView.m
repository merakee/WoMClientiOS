//
//  ContentOverlayView.m
//  WordOfMouthEngine
//
//  Created by Kevin Moy on 1/14/15.
//  Copyright (c) 2015 Bijit Halder. All rights reserved.
//

#import "ContentOverlayView.h"
#import "CommonUtility.h"

@interface ContentOverlayView ()
//@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation ContentOverlayView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) return nil;
   // self.imageView = [[UIImageView alloc] init];
   // [self.imageView setTranslatesAutoresizingMaskIntoConstraints:NO];
   
   // [self addSubview:self.imageView];
  //  self.backgroundColor.image = [UIImage imageNamed:@"kill-btn.png"];
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:kAUCReleaseToSpread]];
    return self;
}

- (void)setMode:(OverlayViewMode)mode
{
    if (_mode == mode) return;
    
    _mode = mode;
    if (mode == OverlayViewModeLeft) {
    //    self.imageView.backgroundColor = [UIColor redColor];
         self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:kAUCReleaseToKill]];
//        CGPoint fromLocation = ccvl.center;
//        [CommonUtility printPoint:self.imageView.image.center];
    } else {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:kAUCReleaseToSpread]];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
//    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(self.imageView);
//    //image view
//    [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[contentImageView]|"
//                                                                        options:0 metrics:nil views:viewsDictionary]];
//    
//    [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[contentImageView]|"
//                                                                        options:0 metrics:nil views:viewsDictionary]];
}

@end