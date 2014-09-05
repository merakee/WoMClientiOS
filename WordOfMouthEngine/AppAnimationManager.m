//
//  AppAnimationManager.m
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 2/13/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import "AppAnimationManager.h"

@implementation AppAnimationManager

@synthesize repeatCount;
@synthesize animationDuration;
@synthesize animationDelay;
@synthesize delegate;


#pragma mark -  Init Methods
- (id)init {
    if ((self = [super init])) {
        // init setting
        [self setAllDefaults];
    }
    return self;
}

- (void)setAllDefaults {
    self.delegate=nil;
    self.repeatCount=kCustomViewAnimationDefaultRepeatCount;
    self.animationDuration=kCustomViewAnimationDefaultAnimationDuration;
    self.animationDelay=kCustomViewAnimationDefaultAnimationDelay;
}
#pragma mark - view animation instance methods
- (void)animateView:(UIView *)view withType:(CustomViewAnimationType)animationType {
    if(animationType==kCustomViewAnimationTypePulsate) {
        [self pulsateView:view];
        return;
    }
    
    if(animationType==kCustomViewAnimationTypeWabble) {
        [self wabbleView:view];
        return;
    }
    
    //not valid animation type: notify the delegate
    [self notifyAnimationEndedForView:view ofType:animationType];
}
- (void)notifyAnimationEndedForView:(UIView *)view ofType:(CustomViewAnimationType)animationType {
    if ([self.delegate respondsToSelector:@selector(animationEndedForView:ofType:)]) {
        [self.delegate animationEndedForView:view ofType:animationType];
    }
}

- (void)pulsateView:(UIView *)view {
    // set opacity
    view.alpha=1.0;
    [UIView animateWithDuration:self.animationDuration
                          delay:self.animationDelay
                        options:(UIViewAnimationCurveEaseInOut|UIViewAnimationOptionLayoutSubviews)
                     animations:^{
                         [UIView  setAnimationRepeatCount:self.repeatCount];
                         [UIView  setAnimationRepeatAutoreverses:YES];
                         view.alpha=0.5;
                     }
                     completion:^(BOOL finished){
                         [self notifyAnimationEndedForView:view ofType:kCustomViewAnimationTypePulsate];
                     }];
    
}
- (void)wabbleView:(UIView *)view {
    // set frame
    float wabbleHeight =50.0;
    CGRect frame = view.frame;
    CGRect frameLow = CGRectMake(frame.origin.x, frame.origin.y+wabbleHeight, frame.size.width, frame.size.height);
    [UIView animateWithDuration:self.animationDuration
                          delay:self.animationDelay
                        options:(UIViewAnimationCurveEaseInOut|UIViewAnimationOptionLayoutSubviews)
                     animations:^{
                         [UIView  setAnimationRepeatCount:self.repeatCount];
                         [UIView  setAnimationRepeatAutoreverses:YES];
                         view.frame=frameLow;
                     }
                     completion:^(BOOL finished){
                         view.frame = frame;
                         [self notifyAnimationEndedForView:view ofType:kCustomViewAnimationTypeWabble];
                     }];
    
}

#pragma mark - view animation class methods
+(void) attachViewWithFade:(UIView *)view toSuperView:(UIView *)superView andDuration:(float)fadeDuration {
    if(fadeDuration<=0) {
        return;
    }
    
    // fade in animation
    view.alpha = 0.0;
    // attach to super view
    [superView addSubview:view];
    [UIView animateWithDuration:fadeDuration
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{view.alpha=1.0; }
                     completion:NULL];
}

+(void) detachViewFromSuperViewWithFade:(UIView *)view andDuration:(float)fadeDuration {
    if(fadeDuration<=0) {
        return;
    }
    // fade out animation
    [UIView animateWithDuration:fadeDuration
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{view.alpha=0.0; }
                     completion:^(BOOL finished){
                         [view removeFromSuperview];
                     }];
}

+(void) slideView:(UIView *)view fromLocation:(CGPoint)original to:(CGPoint)final andDuration:(float)duration withFinalAction:(void (^)())action{
    if(duration<=0) {
        return;
    }
    // set view
    view.center = original;
    [UIView animateWithDuration:duration
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         view.center=final;
                     }
                     completion:^(BOOL finished){
                         if (action != nil){
                             action();
                         }
                     }];
}

+(void) slideView:(UIView *)view fromLocation:(CGPoint)original through:(CGPoint)middle duration:(float)duration1 to:(CGPoint)final duration:(float)duration2 withFinalAction:(void (^)())action {
    if ((duration1<=0)||(duration2<=0)) {
        return;
    }
    // set view
    view.center = original;
    [UIView animateWithDuration:duration1
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         view.center=middle;
                     }
                     completion:^(BOOL finished){
                         [AppAnimationManager slideView:view
                                           fromLocation:middle
                                                     to:final
                                            andDuration:duration2
                                        withFinalAction:action];
                     }];
}


@end