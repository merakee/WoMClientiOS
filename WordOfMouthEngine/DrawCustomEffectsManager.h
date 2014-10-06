//
//  CustomEffectsManager.h
//  MathSchool
//
//  Created by Bijit Halder on 6/6/12.
//  Copyright (c) 2012 Indriam Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "CoreSizeDefintions.h"
//#import "AppConstants.h"
#import "CommonUtility.h"

/*-------------
   Define all constants
   --------------*/
typedef enum {
    kCEMImageScaleModeNoScale,
    kCEMImageScaleModeScaleToFitBest,
    kCEMImageScaleModeScaleToFill,
    kCEMImageScaleModeScaleToFitHorizontal,
    kCEMImageScaleModeScaleToFitVertical,
    kCEMImageScaleModeScaleToFitAll
} CEMImageScaleMode;

typedef enum {
    kCEMGradientDirectionUpDown,
    kCEMGradientDirectionDownUp,
    kCEMGradientDirectionLeftRight,
    kCEMGradientDirectionRightLeft,
    kCEMGradientDirectionRightTopLeftBottom,
    kCEMGradientDirectionRightBottomLeftTop,
    kCEMGradientDirectionLeftTopRightBottom,
    kCEMGradientDirectionLeftBottomRightTop
} CEMGradientDirection;

typedef enum {
    kCEMGradientRadialStartPointTopLeft,
    kCEMGradientRadialStartPointTopRight,
    kCEMGradientRadialStartPointBottomLeft,
    kCEMGradientRadialStartPointBottomRight,
    kCEMGradientRadialStartPointCenter,
    kCEMGradientRadialStartPointSphereEffect,
} CEMGradientRadialStartPoint;

typedef enum {
    kCEMGradientTypeLinear,
    kCEMGradientTypeRadial
} CEMGradientType;

typedef enum {
    kCEMTextEffectNone,
    kCEMTextEffectDropShadow,
    kCEMTextEffectLetterPress
} CEMTextEffect;

typedef enum {
    kCEMMaskTypeRectangular,
    kCEMMaskTypeElliptical
} CEMMaskType;

typedef enum {
    kCEMShadowTypeNone,
    kCEMShadowTypeDrop,
    kCEMShadowTypeInner,
    kCEMShadowTypeDropAndInner
} CEMShadowType;

// Defaults
static const float kCEMMinTextFontsize =8;
const static float kCRDTextLetterPressShadowColor[4] = {200.0/360.0,0.2,1.0,1.0};


@interface DrawCustomEffectsManager : NSObject

#pragma mark - Class Methods: Core functions
+ (void)setClippingAreaForRect:(CGRect)maskRect
   withCornerRadius:(float)radius
   ofType:(CEMMaskType)maskType
   inContext:(CGContextRef)context;
+ (void)setPathForRect:(CGRect)maskRect
   withCornerRadius:(float)radius
   ofType:(CEMMaskType)maskType
   inContext:(CGContextRef)context;

+ (void)setPathForRect:(CGRect)maskRect
   withPoststampEdgeOfSize:(float)eSize
   andGap:(float)gap
   inContext:(CGContextRef)context;

+ (void)setPathForArrowRect:(CGRect)maskRect usingPath:(CGMutablePathRef)mpath;

#pragma mark - Class Methods: Stroke

+ (void)strokeRect:(CGRect)maskRect
   lineWidth:(float)lineWidth
   andColor:(UIColor *)strokeColor
   inContext:(CGContextRef)context;

+ (void)strokeEllipseInRect:(CGRect)maskRect
   lineWidth:(float)lineWidth
   andColor:(UIColor *)strokeColor
   inContext:(CGContextRef)context;

+ (void)strokeRect:(CGRect)maskRect
   ofType:(CEMMaskType)maskType
   withCornerRadius:(float)radius
   lineWidth:(float)lineWidth
   andColor:(UIColor *)strokeColor
   inContext:(CGContextRef)context;


#pragma mark - Class Methods: Fill
+ (void)fillEllipseInRect:(CGRect)rect withColor:(UIColor *)color inContext:(CGContextRef)context;
+ (void)fillRect:(CGRect)rect withColor:(UIColor *)color inContext:(CGContextRef)context;

#pragma mark - Class Methods: Gradrient
+ (void)addLinearGradientToRect:(CGRect)gradientMask
   andColors:(NSArray *)gradientColors
   inContext:(CGContextRef)context;

+ (void)addRadialGradientToRect:(CGRect)gradientMask
   withColors:(NSArray *)gradientColors
   andStartPoint:(CEMGradientRadialStartPoint)startPoint
   inContext:(CGContextRef)context;

+ (void)addGradientOfType:(CEMGradientType)gradientType
   toRect:(CGRect)gradientMask
   withCornerRadius:(float)gradientCornerRadius
   maskType:(CEMMaskType)gradientMaskType
   direction:(CEMGradientDirection)gradientDirection
   startPoint:(CEMGradientRadialStartPoint)gradientStartPoint
   andColors:(NSArray *)gradientColors
   inContext:(CGContextRef)context;

#pragma mark - Class Methods: Shadow
+ (void)setInnerShadowWithOffset:(CGSize)offset
   blur:(float)blur
   color:(UIColor *)shadowColor
   colorSapceRef:(CGColorSpaceRef)colorSpaceRef
   shadowColorRef:(CGColorRef)shadowColorRef
   inContext:(CGContextRef)context;

+ (void)setDropShadowWithOffset:(CGSize)offset
   blur:(float)blur
   color:(UIColor *)shadowColor
   colorSapceRef:(CGColorSpaceRef)colorSpaceRef
   shadowColorRef:(CGColorRef)shadowColorRef
   inContext:(CGContextRef)context;

+ (void)releaseShadowColorRef:(CGColorRef)shadowColorRef
   forColorSapceRef:(CGColorSpaceRef)colorSpaceRef
   inContext:(CGContextRef)context;

#pragma mark - Class Methods: Text
+(void)addText:(NSString *)text_ inRect:(CGRect)rect withFontName:(NSString *)fontName fontSize:(float)fontSize
   color:(UIColor *)tColor autoFit:(BOOL)autoFit andAllCaps:(BOOL)allCaps inContext:(CGContextRef)context;

#pragma mark - Class Methods: Glow

#pragma mark - Class Methods: Utility
+ (CGSize)getFontSize:(float *)fontSize
   forText:(NSString *)text
   withFontName:(NSString *)fontName
   ofSize:(float)desiredFontSize
   andMinSize:(float)minSize
   withRectSize:(CGSize)rectSize;

//+ (CGSize)getFontSize:(float*)fontSize
//   forText:(NSString *)text
//   withFontName:(NSString *)fontName
//   ofSize:(float)desiredFontSize
//   andMinSize:(float)minSize
//   forWidth:(float)width;

+ (void)setFillColor:(UIColor *)color inContext:(CGContextRef)context;
+ (void)setStrokeColor:(UIColor *)color inContext:(CGContextRef)context;

#pragma mark -  Image processing methods
+(UIImage *)getImageFromView:(UIView *)view;
+(void)drawImage:(UIImage *)image inRect:(CGRect)rect inContext:(CGContextRef)context;

#pragma mark - inner shadow ceation method
+ (void)drawText:(NSString *)text_ font:(UIFont *)font withInnerShadowInRect:(CGRect)rect inContext:(CGContextRef)context;

@end

