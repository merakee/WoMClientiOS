//
//  CVCircleDownCounter.m
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 3/6/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import "CVCircleDownCounter.h"



#import "CVCircleCounterView.h"

static CVCircleDownCounter *sharedDownCounter = nil;

@interface CVCircleDownCounter () <CVCircleCounterViewDelegate>



@end

@implementation CVCircleDownCounter

+ (CVCircleCounterView *)showCircleDownWithSeconds:(float)seconds onView:(UIView *)view {
    return [self showCircleDownWithSeconds:seconds onView:view
                                  withSize:kDefaultCounterSize
                                   andType:CircleDownCounterTypeIntegerDecre];
}

+ (CVCircleCounterView *)showCircleDownWithSeconds:(float)seconds onView:(UIView *)view withSize:(CGSize)size {
    return [self showCircleDownWithSeconds:seconds onView:view
                                  withSize:size
                                   andType:CircleDownCounterTypeIntegerDecre];
}

+ (CVCircleCounterView *)showCircleDownWithSeconds:(float)seconds onView:(UIView *)view withSize:(CGSize)size andType:(CircleDownCounterType)type {
    
    [self removeCircleViewFromView:view];
    
    CVCircleCounterView *circleView = [[CVCircleCounterView alloc] initWithFrame:[self frameOfCircleViewOfSize:size
                                                                                                        inView:view]];
    [view addSubview:circleView];
    
    circleView.delegate = [self circleDownCounter];
    
    switch (type) {
        case CircleDownCounterTypeIntegerDecre:
            [circleView startWithSeconds:seconds];
            break;
        case CircleDownCounterTypeOneDecimalDecre:
            circleView.numberFont = [UIFont fontWithName:@"Courier-Bold" size:15.0f];
            [circleView startWithSeconds:seconds andInterval:0.1f
                           andTimeFormat:@"%.1f"];
            break;
        case CircleDownCounterTypeIntegerIncre:
            circleView.circleIncre = YES;
            [circleView startWithSeconds:seconds];
            break;
        case CircleDownCounterTypeOneDecimalIncre:
            circleView.circleIncre = YES;
            circleView.numberFont = [UIFont fontWithName:@"Courier-Bold" size:15.0f];
            [circleView startWithSeconds:seconds andInterval:0.1f
                           andTimeFormat:@"%.1f"];
            break;
        default:
            break;
    }
    
    return circleView;
}

+ (CVCircleCounterView *)showCircleDownWithSeconds:(float)seconds onView:(UIView *)view withInterval:(float)interval{
    
    CGSize size= kDefaultCounterSize;
    
    [self removeCircleViewFromView:view];
    
    CVCircleCounterView *circleView = [[CVCircleCounterView alloc] initWithFrame:[self frameOfCircleViewOfSize:size
                                                                                                        inView:view]];
    [view addSubview:circleView];
    
    circleView.delegate = [self circleDownCounter];
    
    
    [circleView startWithSeconds:seconds andInterval:interval];
    
    return circleView;
}
+ (void)removeCircleViewFromView:(UIView *)view {
    CVCircleCounterView *circleView = [self circleViewInView:view];
    if (circleView)
        {
        [circleView removeFromSuperview];
        }
}

//< Utilities
+ (CGRect)frameOfCircleViewOfSize:(CGSize)size inView:(UIView *)view {
    return CGRectInset(view.bounds,
                       (CGRectGetWidth(view.bounds) - size.width)/2.0f,
                       (CGRectGetHeight(view.bounds) - size.height)/2.0f);
}

+ (CVCircleCounterView *)circleViewInView:(UIView *)view {
    for (UIView *subView in [view subviews])
        {
        if ([subView isKindOfClass:[CVCircleCounterView class]])
            {
            return (CVCircleCounterView *)subView;
            }
        }
    return nil;
}

+ (CVCircleDownCounter *)circleDownCounter {
    if (!sharedDownCounter)
        {
        sharedDownCounter = [[CVCircleDownCounter alloc] init];
        }
    return sharedDownCounter;
}

#pragma mark - CircleCounterViewDelegate
- (void)counterDownFinished:(CVCircleCounterView *)circleView {
    [circleView removeFromSuperview];
}


@end
