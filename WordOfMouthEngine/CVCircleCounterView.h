//
//  CVCircleCounterView.h
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 3/6/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import <UIKit/UIKit.h>

static const int  kCircleSegs  = 30;

@class CVCircleCounterView;

@protocol CVCircleCounterViewDelegate <NSObject>

- (void)counterDownFinished:(CVCircleCounterView *)circleView;

@optional
- (void)counter:(CVCircleCounterView *)circleView updatedWithValue:(float)timeInSeconds;

@end

@interface CVCircleCounterView : UIView {
    
    //< Different with mTimeInterval, this one decides how long a circle finished. 1 seconds by default
    float mCircleTimeInterval;
    
    UIColor *mNumberColor; //< Black, By Default
    UIFont *mNumberFont; //< Courier-Bold 20, By Default
    
    UIColor *mCircleColor; //< Black, By Default
    UIColor *mCircleDoneColor; //< Black, By Default
    CGFloat mCircleBorderWidth; //< 6 pixels, By Default
    
    float mTimeInSeconds; //< 20, By Default
    float totalTimeInSeconds;
    float mTimeInterval; //< 1, By Default
    NSString *mTimeFormatString; //< For Example, @"%.0f", @"%.1f"
    
    BOOL mIsRunning;
    int mCircleSegs;
    
    id<CVCircleCounterViewDelegate> mDelegate;
    
    BOOL mCircleIncre; //< Default NO, the circle is drawed incrementally, otherwise decrementally
    
    // timers
    NSTimer *counterTimer;
}

@property (nonatomic) id<CVCircleCounterViewDelegate> delegate;

@property (nonatomic, assign) BOOL circleIncre;

@property (nonatomic, retain) UIColor *numberColor;
@property (nonatomic, retain) UIFont *numberFont;

@property (nonatomic, retain) UIColor *circleColor;
@property (nonatomic, retain) UIColor *circleDoneColor;
@property (nonatomic, assign) CGFloat circleBorderWidth;
@property (nonatomic, assign) float circleTimeInterval;

- (void)startWithSeconds:(float)seconds;
- (void)startWithSeconds:(float)seconds andInterval:(float)interval;
- (void)startWithSeconds:(float)seconds andInterval:(float)interval andTimeFormat:(NSString *)timeFormat;
- (void)stop;

@property (nonatomic, retain) NSString *timeFormatString;

- (void)setup;
- (void)update:(id)sender;
- (void)updateTime:(id)sender;

@end
