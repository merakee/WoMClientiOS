//
//  CACircularCounterView.m
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 3/6/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import "CVCircleCounterView.h"

@implementation CVCircleCounterView

@synthesize numberColor = mNumberColor;
@synthesize numberFont = mNumberFont;
@synthesize circleColor = mCircleColor;
@synthesize circleDoneColor = mCircleDoneColor;
@synthesize circleBorderWidth = mCircleBorderWidth;
@synthesize timeFormatString = mTimeFormatString;
@synthesize circleIncre = mCircleIncre;
@synthesize circleTimeInterval = mCircleTimeInterval;
@synthesize delegate = mDelegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)dealloc {
    
    self.numberFont = nil;
    self.numberColor = nil;
    self.circleDoneColor = nil;
    self.circleDoneColor = nil;
    self.circleBorderWidth = 0;
    self.timeFormatString = nil;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    float radius = CGRectGetWidth(rect)/2.0f - self.circleBorderWidth/2.0f;
    float angleOffset = M_PI_2;
    CGContextSetLineWidth(context, self.circleBorderWidth);
    CGContextBeginPath(context);
    if (self.circleIncre) {
        CGContextAddArc(context,
                        CGRectGetMidX(rect), CGRectGetMidY(rect),
                        radius,
                        (1.0 - mTimeInSeconds/totalTimeInSeconds)*M_PI*2 - angleOffset,
                        - angleOffset,
                        1);
        }
    else
        {
        CGContextAddArc(context,
                        CGRectGetMidX(rect), CGRectGetMidY(rect),
                        radius,
                        (1.0 - mTimeInSeconds/totalTimeInSeconds)*M_PI*2 - angleOffset,
                        2*M_PI - angleOffset,
                        0);
        }
    CGContextSetStrokeColorWithColor(context, self.circleColor.CGColor);
    CGContextStrokePath(context);

    CGContextBeginPath(context);
    if (self.circleIncre)
        {
        CGContextAddArc(context,
                        CGRectGetMidX(rect), CGRectGetMidY(rect),
                        radius,
                        (1.0 - mTimeInSeconds/totalTimeInSeconds)*M_PI*2 - angleOffset,
                        2*M_PI - angleOffset,
                        0);
        }
    else
        {
        CGContextAddArc(context,
                        CGRectGetMidX(rect), CGRectGetMidY(rect),
                        radius,
                        (1.0 - mTimeInSeconds/totalTimeInSeconds)*M_PI*2 - angleOffset,
                        - angleOffset,
                        1);
        }
    CGContextSetStrokeColorWithColor(context, self.circleDoneColor.CGColor);
    CGContextStrokePath(context);
    
    CGContextSetLineWidth(context, 1.0f);
    NSString *numberText = [NSString stringWithFormat:self.timeFormatString, mTimeInSeconds];
    //CGSize sz = [numberText sizeWithFont:self.numberFont];
    CGSize sz = [numberText sizeWithAttributes:@{NSFontAttributeName: self.numberFont} ];
    [numberText drawInRect:CGRectInset(rect, (CGRectGetWidth(rect) - sz.width)/2.0f, (CGRectGetHeight(rect) - sz.height)/2.0f)
            withAttributes:@{NSFontAttributeName: self.numberFont,NSForegroundColorAttributeName:self.numberColor}];
}

- (void)setup {
    
    mIsRunning = NO;
    
    //< Default Parameters
    self.numberColor = [UIColor blackColor];
    self.numberFont = [UIFont fontWithName:@"Courier-Bold" size:20.0f];
    self.circleColor = [UIColor blackColor];
    self.circleDoneColor = [UIColor clearColor];
    self.circleBorderWidth = 6;
    self.timeFormatString = @"%.0f";
    self.circleIncre = NO;
    self.circleTimeInterval = 1.0f;
    
    mTimeInSeconds = 20;
    mTimeInterval = 1;
    mCircleSegs = 0;
    totalTimeInSeconds = mTimeInSeconds;
    
    self.backgroundColor = [UIColor whiteColor];
}

#pragma mark - Public Methods
- (void)startWithSeconds:(float)seconds andInterval:(float)interval andTimeFormat:(NSString *)timeFormat {
    self.timeFormatString = timeFormat;
    [self startWithSeconds:seconds andInterval:interval];
}

- (void)startWithSeconds:(float)seconds andInterval:(float)interval {
    if (interval > seconds)
        {
        mTimeInterval = seconds/10.0f;
        }
    else
        {
        mTimeInterval = interval;
        }
    [self startWithSeconds:seconds];
}

- (void)startWithSeconds:(float)seconds {
    if (seconds > 0)
        {
        // keep total time
        totalTimeInSeconds  =seconds;
        
        mTimeInSeconds = seconds+mTimeInterval;
        mIsRunning = YES;
        mCircleSegs = 0;
        [self update:nil];
        [self updateTime:nil];
        }
}

- (void)stop {
    mIsRunning = NO;
    [self setTimerOff:counterTimer];
}

#pragma mark - Private Methods
- (void)update:(id)sender {
    if (mIsRunning)  {
        mCircleSegs = (mCircleSegs + 1) % kCircleSegs;
        
        //NSLog(@"CT %d, %f, %f",mCircleSegs,self.circleTimeInterval,mTimeInSeconds);
        
        if (fabs(mTimeInSeconds) < 1e-4) {
            
            //< Finished
            [self setTimerOff:(NSTimer *)sender];
            
            mCircleSegs = (kCircleSegs - 1);
            mTimeInSeconds = 0;
            // notify delegate
            if ([self.delegate respondsToSelector:@selector(counterDownFinished:)]) {
                [self.delegate counterDownFinished:self];
            }
        }
        else {
            /* [NSTimer scheduledTimerWithTimeInterval:self.circleTimeInterval/kCircleSegs
             target:self
             selector:@selector(update:)
             userInfo:nil
             repeats:NO];
             
             */
        }
        [self setNeedsDisplay];
    }
}

- (void)updateTime:(id)sender {
    if (mIsRunning)  {
        mTimeInSeconds -= mTimeInterval;
        if (fabs(mTimeInSeconds) < 1e-4){
            //< Finished
            [self setTimerOff:(NSTimer *)sender];
            mCircleSegs = (kCircleSegs - 1);
            mTimeInSeconds = 0;
            // notify delegate
            if ([self.delegate respondsToSelector:@selector(counterDownFinished:)]) {
                [self.delegate counterDownFinished:self];
                
            }
        }
        else{
            counterTimer =  [NSTimer scheduledTimerWithTimeInterval:mTimeInterval
                                                             target:self
                                                           selector:@selector(updateTime:)
                                                           userInfo:nil
                                                            repeats:NO];
        }
        
        // notify delegate
        if ([self.delegate respondsToSelector:@selector(counter:updatedWithValue:)]) {
            [self.delegate counter:self updatedWithValue:mTimeInSeconds];
        }
        
        [self setNeedsDisplay];
    }
}

- (void)setTimerOff:(NSTimer *)timer {
    if([timer isValid]) {
        [timer invalidate];
    }
    timer = nil;
}

/*
 - (void)drawRectOld:(CGRect)rect {
 
 CGContextRef context = UIGraphicsGetCurrentContext();
 
 float radius = CGRectGetWidth(rect)/2.0f - self.circleBorderWidth/2.0f;
 float angleOffset = M_PI_2;
 
 NSLog(@"...1");
 CGContextSetLineWidth(context, self.circleBorderWidth);
 CGContextBeginPath(context);
 if (self.circleIncre){
 CGContextAddArc(context,
 CGRectGetMidX(rect), CGRectGetMidY(rect),
 radius,
 -angleOffset,
 (mCircleSegs + 1)/(float)kCircleSegs*M_PI*2 - angleOffset,
 0);
 }
 else{
 CGContextAddArc(context,
 CGRectGetMidX(rect), CGRectGetMidY(rect),
 radius,
 (mCircleSegs + 1)/(float)kCircleSegs*M_PI*2 - angleOffset,
 2*M_PI - angleOffset,
 0);
 }
 CGContextSetStrokeColorWithColor(context, self.circleColor.CGColor);
 CGContextStrokePath(context);
 NSLog(@"...2");
 
 CGContextBeginPath(context);
 if (self.circleIncre)
 {
 CGContextAddArc(context,
 CGRectGetMidX(rect), CGRectGetMidY(rect),
 radius,
 -angleOffset,
 (mCircleSegs + 1)/(float)kCircleSegs*M_PI*2 - angleOffset,
 1);
 }
 else
 {
 CGContextAddArc(context,
 CGRectGetMidX(rect), CGRectGetMidY(rect),
 radius,
 (mCircleSegs + 1)/(float)kCircleSegs*M_PI*2 - angleOffset,
 2*M_PI - angleOffset,
 1);
 }
 CGContextSetStrokeColorWithColor(context, self.circleDoneColor.CGColor);
 CGContextStrokePath(context);
 
 NSLog(@"...3");
 
 CGContextSetLineWidth(context, 1.0f);
 NSString *numberText = [NSString stringWithFormat:self.timeFormatString, mTimeInSeconds];
 //CGSize sz = [numberText sizeWithFont:self.numberFont];
 CGSize sz = [numberText sizeWithAttributes:@{NSFontAttributeName: self.numberFont} ];
 [numberText drawInRect:CGRectInset(rect, (CGRectGetWidth(rect) - sz.width)/2.0f, (CGRectGetHeight(rect) - sz.height)/2.0f)
 withAttributes:@{NSFontAttributeName: self.numberFont,NSForegroundColorAttributeName:self.numberColor}];
 }
 */
@end
