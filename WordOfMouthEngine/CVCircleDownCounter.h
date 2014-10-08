//
//  CVCircleDownCounter.h
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 3/6/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CVCircleCounterView.h"

typedef enum {
    CircleDownCounterTypeIntegerDecre = 0, //< Default
    CircleDownCounterTypeOneDecimalDecre,
    CircleDownCounterTypeIntegerIncre,
    CircleDownCounterTypeOneDecimalIncre
} CircleDownCounterType;

static const CGSize  kDefaultCounterSize = {44,44};



@interface CVCircleDownCounter : NSObject <CVCircleCounterViewDelegate>

+ (CVCircleCounterView *)showCircleDownWithSeconds:(float)seconds onView:(UIView *)view;
+ (CVCircleCounterView *)showCircleDownWithSeconds:(float)seconds onView:(UIView *)view withSize:(CGSize)size;
+ (CVCircleCounterView *)showCircleDownWithSeconds:(float)seconds onView:(UIView *)view withSize:(CGSize)size andType:(CircleDownCounterType)type;

+ (CVCircleCounterView *)showCircleDownWithSeconds:(float)seconds onView:(UIView *)view withInterval:(float)interval;

//< Utilities
+ (CGRect)frameOfCircleViewOfSize:(CGSize)size inView:(UIView *)view;
+ (CVCircleCounterView *)circleViewInView:(UIView *)view;

+ (CVCircleDownCounter *)circleDownCounter;
+ (void)removeCircleViewFromView:(UIView *)view;

@end
