//
//  CVCircularProgressLayer.h
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 3/6/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CVCircularProgressLayer : CALayer

@property(nonatomic, strong) UIColor *trackTintColor;
@property(nonatomic, strong) UIColor *progressTintColor;
@property(nonatomic) NSInteger roundedCorners;
@property(nonatomic) CGFloat thicknessRatio;
@property(nonatomic) CGFloat progress;
@property(nonatomic) NSInteger clockwiseProgress;

@end
