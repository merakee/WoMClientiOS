//
//  AppAnimationManager.h
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 2/13/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppUIConstants.h"

// define all contants
// List view animation
enum {
    kCustomViewAnimationTypeNone = 0,
    kCustomViewAnimationTypePulsate,
    kCustomViewAnimationTypeShake,
    kCustomViewAnimationTypePulsateWithSize,
    kCustomViewAnimationTypeWabble,
};
typedef NSUInteger CustomViewAnimationType;
// animation times
static const float kCustomViewAnimationDefaultAnimationDuration =2.0;
static const float kCustomViewAnimationDefaultAnimationDelay =0.0;
static const int kCustomViewAnimationDefaultRepeatCount =0;

@protocol AppAnimationManagerDelegate <NSObject>
@required
-(void)animationEndedForView:(UIView *)view ofType:(CustomViewAnimationType)type;
@optional

@end

@interface AppAnimationManager : NSObject {
    
}

@property NSInteger repeatCount;
@property float animationDuration;
@property float animationDelay;


@property (assign, nonatomic) id <AppAnimationManagerDelegate>  delegate;

#pragma mark - view animation instance methods
- (void)animateView:(UIView *)view withType:(CustomViewAnimationType)animationType;


#pragma mark - view animation class methods
+(void)attachViewWithFade:(UIView *)view toSuperView:(UIView *)superView andDuration:(float)fadeDuration;
+(void)detachViewFromSuperViewWithFade:(UIView *)view andDuration:(float)fadeDuration;
+(void) fadeView:(UIView *)view fromAlpha:(double)original toAlpha:(double)final andDuration:(float)duration withFinalAction:(void (^)())action;
+(void) slideView:(UIView *)view fromLocation:(CGPoint)original to:(CGPoint)final andDuration:(float)duration withFinalAction:(void (^)())action;
+(void) slideView:(UIView *)view fromLocation:(CGPoint)original through:(CGPoint)middle duration:(float)duration1 to:(CGPoint)final duration:(float)duration2 withFinalAction:(void (^)())action;

#pragma mark - Image animation methods
+ (NSArray *)getSpreadAnimationImages;
+ (NSArray *)getKillAnimationImages;
+ (void)startAnimatingImageView:(UIImageView *)imageView withImages:(NSArray *)imageArray duration:(NSTimeInterval)duration repeatCount:(NSInteger)count;
+ (void)startAnimatingImageView:(UIImageView *)imageView withImages:(NSArray *)imageArray duration:(NSTimeInterval)duration repeatCount:(NSInteger)count withFinalAction:(void (^)())action;
+ (void)stopAnimatingImageView:(UIImageView *)imageView;


@end
