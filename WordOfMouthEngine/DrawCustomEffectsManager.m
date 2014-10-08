//
//  CustomEffectsManager.m
//  MathSchool
//
//  Created by Bijit Halder on 6/6/12.
//  Copyright (c) 2012 Indriam Inc. All rights reserved.
//

#import "DrawCustomEffectsManager.h"

@implementation DrawCustomEffectsManager

#pragma mark - Class Methods: Core functions
+ (void)setClippingAreaForRect:(CGRect)maskRect withCornerRadius:(float)radius ofType:(CEMMaskType)maskType inContext:(CGContextRef)context {
    [DrawCustomEffectsManager setPathForRect:maskRect withCornerRadius:radius ofType:maskType inContext:context];
    // clip
    CGContextClip (context);
}

+ (void)setPathForRect:(CGRect)maskRect withCornerRadius:(float)radius ofType:(CEMMaskType)maskType inContext:(CGContextRef)context {
    
    // adjust radius: limit max value
    radius = (radius>(maskRect.size.height/2)) ? maskRect.size.height/2 : radius;
    radius = (radius>(maskRect.size.width/2)) ? maskRect.size.width/2 : radius;
    
    // retangular box with round corner
    if(maskType==kCEMMaskTypeRectangular) {
        if(radius>0.0) {
            // rounded corner
            CGFloat minx = CGRectGetMinX(maskRect), midx = CGRectGetMidX(maskRect), maxx = CGRectGetMaxX(maskRect);
            CGFloat miny = CGRectGetMinY(maskRect), midy = CGRectGetMidY(maskRect), maxy = CGRectGetMaxY(maskRect);
            
            CGContextBeginPath (context);
            // Start at 1
            CGContextMoveToPoint(context, minx, midy);
            // Add an arc through 2 to 3
            CGContextAddArcToPoint(context, minx, miny, midx, miny, radius);
            // Add an arc through 4 to 5
            CGContextAddArcToPoint(context, maxx, miny, maxx, midy, radius);
            // Add an arc through 6 to 7
            CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
            // Add an arc through 8 to 9
            CGContextAddArcToPoint(context, minx, maxy, minx, midy, radius);
            
            CGContextClosePath (context);
        }
        else{
            CGContextBeginPath (context);
            CGContextAddRect(context,maskRect);
            CGContextClosePath (context);
        }
    }
    // elliptical shape
    if(maskType==kCEMMaskTypeElliptical) {
        CGContextBeginPath (context);
        CGContextAddEllipseInRect(context,maskRect);
        CGContextClosePath (context);
    }
    
}

+ (void)setPathForRect:(CGRect)maskRect
withPoststampEdgeOfSize:(float)eSize
                andGap:(float)gap
             inContext:(CGContextRef)context {
    // calculate parameters
    float radius=eSize/2.0;
    int xcuts= floor(maskRect.size.width/(eSize+gap));
    int ycuts= floor(maskRect.size.height/(eSize+gap));
    float xgap = (maskRect.size.width-xcuts*eSize)/xcuts;
    float ygap = (maskRect.size.height-ycuts*eSize)/ycuts;
    
    // draw path
    CGContextBeginPath (context);
    CGPoint cp;
    
    
    
    // start at top left
    cp=CGPointMake(maskRect.origin.x,maskRect.origin.y);
    // from top left to top right
    CGContextMoveToPoint(context,cp.x,cp.y);
    for(int ind=0; ind<xcuts; ind++) {
        cp =[CommonUtility  getPoint:cp withXOffset:(xgap+eSize)/2];
        CGContextAddArc(context, cp.x, cp.y, radius,M_PI, 0, 1);
        
        if(ind==xcuts-1) {
            cp =CGPointMake(maskRect.origin.x+maskRect.size.width,maskRect.origin.y);
        }else{
            cp =[CommonUtility  getPoint:cp withXOffset:xgap+radius];
        }
        CGContextAddLineToPoint(context,cp.x,cp.y);
    }
    
    // from top right to bottom right
    for(int ind=0; ind<ycuts; ind++) {
        cp =[CommonUtility  getPoint:cp withYOffset:(ygap+eSize)/2];
        CGContextAddArc(context, cp.x, cp.y, radius, -M_PI*0.5,M_PI*0.5, 1);
        if(ind==ycuts-1) {
            cp =CGPointMake(maskRect.origin.x+maskRect.size.width,maskRect.origin.y+maskRect.size.height);
        }else{
            cp =[CommonUtility  getPoint:cp withYOffset:ygap+radius];
        }
        CGContextAddLineToPoint(context,cp.x,cp.y);
    }
    
    // from  bottom right to  bottom left
    for(int ind=0; ind<xcuts; ind++) {
        cp =[CommonUtility  getPoint:cp withXOffset:-(xgap+eSize)/2];
        CGContextAddArc(context, cp.x, cp.y, radius,0, M_PI, 1);
        if(ind==xcuts-1) {
            cp =CGPointMake(maskRect.origin.x,maskRect.origin.y+maskRect.size.height);
        }else{
            cp =[CommonUtility  getPoint:cp withXOffset:-xgap-radius];
        }
        CGContextAddLineToPoint(context,cp.x,cp.y);
    }
    
    
    // from bottom left to top left
    for(int ind=0; ind<ycuts; ind++) {
        cp =[CommonUtility  getPoint:cp withYOffset:-(ygap+eSize)/2];
        CGContextAddArc(context, cp.x, cp.y, radius,M_PI*.5,-M_PI*.5, 1);
        if(ind==ycuts-1) {
            cp =CGPointMake(maskRect.origin.x,maskRect.origin.y);
        }else{
            cp =[CommonUtility  getPoint:cp withYOffset:-ygap-radius];
        }
        CGContextAddLineToPoint(context,cp.x,cp.y);
    }
    
    
    // close path and clip
    CGContextClosePath (context);
}

+ (void)setPathForArrowRect:(CGRect)maskRect usingPath:(CGMutablePathRef)mpath {
    //points
    CGPoint sp =[CommonUtility getLeftTopPointOfRect:maskRect];
    CGPoint ep =[CommonUtility getRightBottomPointOfRect:maskRect];
    float xSize = maskRect.size.width;
    float ySize = maskRect.size.height;
    float fac1=0.15; //arrow height
    float fac2=0.5; // arrow size
    float fac3=0.16; // arrow width
    
    // start path
    CGPoint cp = CGPointMake(sp.x, sp.y+ySize*0.15);
    CGPathMoveToPoint(mpath, NULL, cp.x,cp.y);
    
    cp =[CommonUtility getPoint:cp withXOffset:xSize*fac2];
    CGPathAddLineToPoint(mpath, NULL, cp.x,cp.y);
    
    cp =[CommonUtility getPoint:cp withXOffset:-ySize*fac1 andYOffset:-ySize*fac1];
    CGPathAddLineToPoint(mpath, NULL, cp.x,cp.y);
    
    cp =[CommonUtility getPoint:cp withXOffset:xSize*fac3];
    CGPathAddLineToPoint(mpath, NULL, cp.x,cp.y);
    
    cp =[CommonUtility getPoint:cp withXOffset:ySize*fac2 andYOffset:ySize*fac2];
    CGPathAddLineToPoint(mpath, NULL, cp.x,cp.y);
    
    cp =[CommonUtility getPoint:cp withXOffset:-ySize*fac2 andYOffset:ySize*fac2];
    CGPathAddLineToPoint(mpath, NULL, cp.x,cp.y);
    
    cp =[CommonUtility getPoint:cp withXOffset:-xSize*fac3];
    CGPathAddLineToPoint(mpath, NULL, cp.x,cp.y);
    
    cp =[CommonUtility getPoint:cp withXOffset:ySize*fac1 andYOffset:-ySize*fac1];
    CGPathAddLineToPoint(mpath, NULL, cp.x,cp.y);
    
    cp =[CommonUtility getPoint:cp withXOffset:-xSize*fac2];
    CGPathAddLineToPoint(mpath, NULL, cp.x,cp.y);
    
    // close sub path
    CGPathCloseSubpath(mpath);
    
    // start next arrow
    cp = CGPointMake(ep.x-xSize*fac3-ySize*fac2,sp.y);
    CGPathMoveToPoint(mpath, NULL, cp.x,cp.y);
    
    cp =[CommonUtility getPoint:cp withXOffset:xSize*fac3];
    CGPathAddLineToPoint(mpath, NULL, cp.x,cp.y);
    
    cp =[CommonUtility getPoint:cp withXOffset:ySize*fac2 andYOffset:ySize*fac2];
    CGPathAddLineToPoint(mpath, NULL, cp.x,cp.y);
    
    cp =[CommonUtility getPoint:cp withXOffset:-ySize*fac2 andYOffset:ySize*fac2];
    CGPathAddLineToPoint(mpath, NULL, cp.x,cp.y);
    
    cp =[CommonUtility getPoint:cp withXOffset:-xSize*fac3];
    CGPathAddLineToPoint(mpath, NULL, cp.x,cp.y);
    
    cp =[CommonUtility getPoint:cp withXOffset:ySize*fac2 andYOffset:-ySize*fac2];
    CGPathAddLineToPoint(mpath, NULL, cp.x,cp.y);
    
    // close sub path
    CGPathCloseSubpath(mpath);
}
#pragma mark - Class Methods: Stroke
+ (void)strokeRect:(CGRect)maskRect
         lineWidth:(float)lineWidth
          andColor:(UIColor *)strokeColor
         inContext:(CGContextRef)context {
    [DrawCustomEffectsManager strokeRect:maskRect
                                  ofType:kCEMMaskTypeRectangular
                        withCornerRadius:0.0
                               lineWidth:lineWidth
                                andColor:strokeColor
                               inContext:context];
    
    
}
+ (void)strokeEllipseInRect:(CGRect)maskRect
                  lineWidth:(float)lineWidth
                   andColor:(UIColor *)strokeColor
                  inContext:(CGContextRef)context {
    [DrawCustomEffectsManager strokeRect:maskRect
                                  ofType:kCEMMaskTypeElliptical
                        withCornerRadius:0.0
                               lineWidth:lineWidth
                                andColor:strokeColor
                               inContext:context];
    
    
}
+ (void)strokeRect:(CGRect)maskRect
            ofType:(CEMMaskType)maskType
  withCornerRadius:(float)radius
         lineWidth:(float)lineWidth
          andColor:(UIColor *)strokeColor
         inContext:(CGContextRef)context {
    // save State
    CGContextSaveGState(context);
    // set path
    [DrawCustomEffectsManager setPathForRect:maskRect withCornerRadius:radius ofType:maskType inContext:context];
    // stroke
    CGContextSetLineWidth(context,lineWidth);
    float rgbVec[4];
    [CommonUtility getRGBValues:rgbVec fromUIColor:strokeColor];
    CGContextSetRGBStrokeColor(context, rgbVec[0], rgbVec[1], rgbVec[2], rgbVec[3]);
    CGContextStrokePath(context);
    // restore CG Sate
    CGContextRestoreGState(context);
}

#pragma mark - Class Methods: Fill
+ (void)fillEllipseInRect:(CGRect)rect withColor:(UIColor *)color inContext:(CGContextRef)context {
    // save State
    CGContextSaveGState(context);
    [DrawCustomEffectsManager setFillColor:color inContext:context];
    CGContextFillEllipseInRect(context, rect);
    // restore CG Sate
    CGContextRestoreGState(context);
}

+ (void)fillRect:(CGRect)rect withColor:(UIColor *)color inContext:(CGContextRef)context {
    // save State
    CGContextSaveGState(context);
    [DrawCustomEffectsManager setFillColor:color inContext:context];
    CGContextFillRect(context, rect);
    // restore CG Sate
    CGContextRestoreGState(context);
}
#pragma mark - Class Methods: Gradrient
+ (void)addLinearGradientToRect:(CGRect)gradientMask
                      andColors:(NSArray *)gradientColors
                      inContext:(CGContextRef)context {
    [DrawCustomEffectsManager addGradientOfType:kCEMGradientTypeLinear
                                         toRect:gradientMask
                               withCornerRadius:0.0
                                       maskType:kCEMMaskTypeRectangular
                                      direction:kCEMGradientDirectionUpDown
                                     startPoint:0
                                      andColors:gradientColors
                                      inContext:context];
    
}
+ (void)addRadialGradientToRect:(CGRect)gradientMask
                     withColors:(NSArray *)gradientColors
                  andStartPoint:(CEMGradientRadialStartPoint)startPoint
                      inContext:(CGContextRef)context {
    [DrawCustomEffectsManager addGradientOfType:kCEMGradientTypeRadial
                                         toRect:gradientMask
                               withCornerRadius:0.0
                                       maskType:kCEMMaskTypeRectangular
                                      direction:0
                                     startPoint:startPoint
                                      andColors:gradientColors
                                      inContext:context];
    
}

+ (void)addGradientOfType:(CEMGradientType)gradientType
                   toRect:(CGRect)gradientMask
         withCornerRadius:(float)gradientCornerRadius
                 maskType:(CEMMaskType)gradientMaskType
                direction:(CEMGradientDirection)gradientDirection
               startPoint:(CEMGradientRadialStartPoint)gradientStartPoint
                andColors:(NSArray *)gradientColors
                inContext:(CGContextRef)context {
    // nedd at least two colors
    if(gradientColors.count<2) {
        return;
    }
    // save State
    CGContextSaveGState(context);
    // set clipping
    [DrawCustomEffectsManager setClippingAreaForRect:gradientMask withCornerRadius:gradientCornerRadius ofType:gradientMaskType inContext:context];
    
    // create gradient ref
    // create color space Ref
    CGColorSpaceRef cSpaceRef = CGColorSpaceCreateDeviceRGB ();
    int totalColors = [gradientColors count];
    size_t num_locations = totalColors;
    CGFloat locations[totalColors];
    //locations[0]=0.0;
    CGFloat components[4*totalColors];
    for(int ind=0; ind<totalColors; ind++) {
        locations[ind]=ind/(totalColors-1);
        [CommonUtility getRGBValues:&components[ind*4] fromUIColor:[gradientColors objectAtIndex:ind]];
    }
    
    CGGradientRef gradientRef= CGGradientCreateWithColorComponents (cSpaceRef, components,
                                                                    locations, num_locations);
    
    if(gradientType==kCEMGradientTypeRadial) {
        [DrawCustomEffectsManager drawRadialGradient:gradientRef withMask:gradientMask andStartingPoint:gradientStartPoint inContext:context];
    }
    else {
        [DrawCustomEffectsManager drawLinearGradient:gradientRef withMask:gradientMask inDirection:gradientDirection inContext:context];
    }
    
    
    //release Color space ref
    CGColorSpaceRelease(cSpaceRef);
    
    // relase gradient ref
    CGGradientRelease(gradientRef);
    
    // restore CG Sate
    CGContextRestoreGState(context);
}

+ (void)drawLinearGradient:(CGGradientRef)gradientRef withMask:(CGRect)mask inDirection:(CEMGradientDirection)direction inContext:(CGContextRef)context {
    CGPoint startPoint, endPoint;
    if(direction==kCEMGradientDirectionRightTopLeftBottom) {
        startPoint.x = mask.origin.x+mask.size.width;
        startPoint.y = mask.origin.y;
        endPoint.x = mask.origin.x;
        endPoint.y = mask.origin.y+mask.size.height;
    }
    else if(direction==kCEMGradientDirectionRightBottomLeftTop) {
        startPoint.x = mask.origin.x+mask.size.width;
        startPoint.y = mask.origin.y+mask.size.height;
        endPoint.x = mask.origin.x;
        endPoint.y = mask.origin.y;
    }
    else if(direction==kCEMGradientDirectionLeftTopRightBottom) {
        startPoint.x = mask.origin.x;
        startPoint.y = mask.origin.y;
        endPoint.x = mask.origin.x+mask.size.width;
        endPoint.y = mask.origin.y+mask.size.height;
    }
    else if(direction==kCEMGradientDirectionLeftBottomRightTop) {
        startPoint.x = mask.origin.x;
        startPoint.y = mask.origin.y+mask.size.height;
        endPoint.x = mask.origin.x+mask.size.width;
        endPoint.y = mask.origin.y;
    }
    else if(direction==kCEMGradientDirectionDownUp) {
        startPoint.x = mask.origin.x;
        startPoint.y = mask.origin.y+mask.size.height;
        endPoint.x = mask.origin.x;
        endPoint.y = mask.origin.y;
    }
    else if(direction==kCEMGradientDirectionRightLeft) {
        startPoint.x = mask.origin.x+mask.size.width;
        startPoint.y = mask.origin.y;
        endPoint.x = mask.origin.x;
        endPoint.y = mask.origin.y;
    }
    else if(direction==kCEMGradientDirectionLeftRight) {
        startPoint.x = mask.origin.x;
        startPoint.y = mask.origin.y;
        endPoint.x = mask.origin.x+mask.size.width;
        endPoint.y = mask.origin.y;
    }
    //else if(direction==kCEMGradientDirectionUpDown){
    else{
        startPoint.x = mask.origin.x;
        startPoint.y = mask.origin.y;
        endPoint.x = mask.origin.x;
        endPoint.y = startPoint.y+mask.size.height;
    }
    
    // draw gradient
    CGContextDrawLinearGradient (context, gradientRef,startPoint, endPoint, 0);
}

+ (void)drawRadialGradient:(CGGradientRef)gradientRef withMask:(CGRect)mask andStartingPoint:(CEMGradientRadialStartPoint)rstartPoint inContext:(CGContextRef)context {
    CGPoint startPoint, endPoint;
    CGFloat startRadius, endRadius;
    if(rstartPoint==kCEMGradientRadialStartPointTopLeft) {
        startPoint.x = mask.origin.x+0.1*mask.size.width;
        startPoint.y = mask.origin.y+0.1*mask.size.height;
    }
    else if(rstartPoint==kCEMGradientRadialStartPointTopRight) {
        startPoint.x = mask.origin.x+mask.size.width-0.1*mask.size.width;
        startPoint.y = mask.origin.y+0.1*mask.size.height;
    }
    else if(rstartPoint==kCEMGradientRadialStartPointBottomLeft) {
        startPoint.x = mask.origin.x+0.1*mask.size.width;
        startPoint.y = mask.origin.y+mask.size.height-0.1*mask.size.height;
    }
    else if(rstartPoint==kCEMGradientRadialStartPointBottomRight) {
        startPoint.x = mask.origin.x+mask.size.width-0.1*mask.size.width;
        startPoint.y = mask.origin.y+mask.size.height-0.1*mask.size.height;
    }
    else if(rstartPoint==kCEMGradientRadialStartPointSphereEffect) {
        startPoint.x = mask.origin.x+0.3*mask.size.width;
        startPoint.y = mask.origin.y+0.3*mask.size.height;
    }
    else{
        startPoint.x = mask.origin.x+mask.size.width/2;
        startPoint.y = mask.origin.y+mask.size.height/2;
    }
    
    endPoint.x = startPoint.x; //mask.origin.x+mask.size.width;
    endPoint.y  = startPoint.y; //mask.origin.y+mask.size.height;
    startRadius = 0.0;
    // half of the diagonal
    endRadius =sqrt(mask.size.width*mask.size.width+mask.size.height*mask.size.height)/2.0;
    // half of the max side
    //endRadius =fmax(mask.size.width,mask.size.height)/2.0;
    
    // draw gradient
    CGContextDrawRadialGradient (context, gradientRef, startPoint,
                                 startRadius, endPoint, endRadius,
                                 kCGGradientDrawsAfterEndLocation);
}

#pragma mark - Class Methods: Shadow
+ (void)setInnerShadowWithOffset:(CGSize)offset
                            blur:(float)blur
                           color:(UIColor *)shadowColor
                   colorSapceRef:(CGColorSpaceRef)colorSpaceRef
                  shadowColorRef:(CGColorRef)shadowColorRef
                       inContext:(CGContextRef)context {
    // create color space Ref
    colorSpaceRef = CGColorSpaceCreateDeviceRGB ();
    
    // add inner shadow
    // set shadow
    float rgbVec[4];
    [CommonUtility getRGBValues:rgbVec fromUIColor:shadowColor];
    shadowColorRef = CGColorCreate(colorSpaceRef,rgbVec);// object is released by the calling function
    CGContextSetShadowWithColor(context,offset,blur,shadowColorRef);
}

+ (void)setDropShadowWithOffset:(CGSize)offset
                           blur:(float)blur
                          color:(UIColor *)shadowColor
                  colorSapceRef:(CGColorSpaceRef)colorSpaceRef
                 shadowColorRef:(CGColorRef)shadowColorRef
                      inContext:(CGContextRef)context {
    // create color space Ref
    colorSpaceRef = CGColorSpaceCreateDeviceRGB ();
    
    // add drop shadow
    // set shadow
    float rgbVec[4];
    [CommonUtility getRGBValues:rgbVec fromUIColor:shadowColor];
    shadowColorRef = CGColorCreate(colorSpaceRef,rgbVec);  // object is released by the calling function
    CGContextSetShadowWithColor(context,offset,blur,shadowColorRef);
}
+ (void)releaseShadowColorRef:(CGColorRef)shadowColorRef
             forColorSapceRef:(CGColorSpaceRef)colorSpaceRef
                    inContext:(CGContextRef)context {
    // release shadow color
    CGColorRelease(shadowColorRef);
    //release Color space ref
    CGColorSpaceRelease(colorSpaceRef);;
}


#pragma mark - Class Methods: Text
+(void)addText:(NSString *)text_ inRect:(CGRect)rect withFontName:(NSString *)fontName fontSize:(float)fontSize
         color:(UIColor *)tColor autoFit:(BOOL)autoFit andAllCaps:(BOOL)allCaps inContext:(CGContextRef)context {
    NSString *text =[NSString stringWithString:[CommonUtility trimString:text_]];
    
    if([CommonUtility isEmptyString:text]) {
        return;
    }
    if(allCaps) {
        text = [text uppercaseString];
    }
    
    // text rect
    CGRect textRect = [CommonUtility scaleRect:rect byScale:0.9];
    CGSize textSize;
    UIFont *textFont=[UIFont fontWithName:fontName size:fontSize];
    
    if(autoFit) {
        // get text font size
        // calculate text size to center
        float fSize;
        textSize = [DrawCustomEffectsManager getFontSize:&fSize
                                                 forText:text
                                            withFontName:fontName
                                                  ofSize:fontSize
                                              andMinSize:kCEMMinTextFontsize
                                            withRectSize:textRect.size];
        fontSize=fSize;
        textFont = [UIFont fontWithName:fontName size:fontSize];
    }
    else{
        // Repalced textsize calculation due to deprecation warning: not tested
        //textSize = [text sizeWithFont:textFont constrainedToSize:textRect.size lineBreakMode:NSLineBreakByWordWrapping];
        
        textSize = [text boundingRectWithSize:textRect.size
                                      options:NSStringDrawingUsesLineFragmentOrigin
                                   attributes:@{NSFontAttributeName:textFont}
                                      context:nil].size;
    }
    textRect = [CommonUtility getRectOfSize:textSize centeredToRect:rect];
    
    // save State
    CGContextSaveGState(context);
    
    // text color
    [DrawCustomEffectsManager setFillColor:tColor inContext:context];
    
    // add drop shadow
    // set shadow
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB ();
    float rgbVec[4];
    [CommonUtility getRGBValues:rgbVec fromUIColor:
     [CommonUtility getColorFromHSBACVec:kCRDTextLetterPressShadowColor]];
    CGColorRef shadowColorRef = CGColorCreate(colorSpaceRef,rgbVec);
    CGContextSetShadowWithColor(context,CGSizeMake(1,1),1.0,shadowColorRef);
    
    // draw text
    // Repalced textsize calculation due to deprecation warning: not tested
    //[text drawInRect:textRect withFont:textFont lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
    [text drawInRect:textRect withAttributes:@{NSFontAttributeName:textFont, NSParagraphStyleAttributeName:[NSParagraphStyle defaultParagraphStyle]}];
    
    // release shadow
    [DrawCustomEffectsManager releaseShadowColorRef:shadowColorRef
                                   forColorSapceRef:colorSpaceRef
                                          inContext:context];
    
    // restore CG Sate
    CGContextRestoreGState(context);
}

/*
 - (void)addText:(NSString *)text_ withFontName:(NSString *)fontName fontsize:(float)desiredFontSize inRect:(CGRect)rect inContext:(CGContextRef)context{
 // trim text and check if text is empty
 NSString *text = [NSString stringWithString:[CommonUtility trimString:text]];
 if([CommonUtility isEmptyString:text]||fontName==nil) {
 return;
 }
 if(desiredFontSize<0){
 desiredFontSize = kCEMMinTextFontsize;
 }
 
 // text font
 float fontSize;
 
 // calculate text size to center
 CGSize textSize = [DrawCustomEffectsManager getFontSize:&fontSize
 forText:text
 withFontName:fontName
 ofSize:desiredFontSize
 andMinSize:kCEMMinTextFontsize
 withRectSize:rect.size];
 
 CGRect textRect = [CommonUtility getRectOfSize:textSize centeredToRect:rect];
 
 // save State
 CGContextSaveGState(context);
 
 // text color
 [CommonUtility getRGBValues:rgbVec fromUIColor:textColor];
 CGContextSetRGBFillColor(context,rgbVec[0],rgbVec[1],rgbVec[2],rgbVec[3]);
 
 if(self.textEffect==kCEMTextEffectNone) {
 // draw text
 [self.text drawInRect:textRect withFont:textFont lineBreakMode:UILineBreakModeTailTruncation alignment:self.textAlignment];
 // restore CG Sate
 CGContextRestoreGState(context);
 
 return;
 }
 
 // add inner shadow for letter press effect
 if(self.textEffect==kCEMTextEffectLetterPress) {
 // set inner shadow
 [self setInnerShadowWithColor:self.innerShadowColor];
 // draw text
 [self.text drawInRect:textRect withFont:textFont lineBreakMode:UILineBreakModeTailTruncation alignment:UITextAlignmentCenter];
 
 // release shadow
 [self releaseShadow];
 }
 
 // add drop shadow
 // set shadow
 if(self.textEffect==kCEMTextEffectLetterPress) {
 [self setDropShadowWithColor:self.dropShadowColor];
 }
 else{
 [self setDropShadowWithColor:self.textShadowColor];
 }
 // draw text
 [self.text drawInRect:textRect withFont:textFont lineBreakMode:UILineBreakModeTailTruncation alignment:UITextAlignmentCenter];
 
 // release shadow
 [self releaseShadow];
 
 // restore CG Sate
 CGContextRestoreGState(context);
 }
 */
#pragma mark - Class Methods: Utility
+ (CGSize)getFontSize:(float *)fontSize
              forText:(NSString *)text
         withFontName:(NSString *)fontName
               ofSize:(float)desiredFontSize
           andMinSize:(float)minSize
         withRectSize:(CGSize)rectSize {
    if(minSize<=0) {
        minSize=kCEMMinTextFontsize;
    }
    
    CGSize tSize = CGSizeMake(rectSize.width,rectSize.height*100);
    BOOL doesNotFit=YES;
    *fontSize = desiredFontSize;
    UIFont *font =[UIFont fontWithName:fontName size:*fontSize];
    
    while (doesNotFit) {
        
        // Repalced textsize calculation due to deprecation warning: not tested
        //tSize = [text sizeWithFont:font constrainedToSize:tSize lineBreakMode:UILineBreakModeWordWrap];
        tSize = [text boundingRectWithSize:tSize
                                   options:NSStringDrawingUsesLineFragmentOrigin
                                attributes:@{NSFontAttributeName:font}
                                   context:nil].size;
        
        if((tSize.height<=rectSize.height)||(*fontSize<=minSize)) {
            doesNotFit=NO;
        }
        else{
            // change
            *fontSize -=1;
            font =[UIFont fontWithName:fontName size:*fontSize];
            tSize = CGSizeMake(rectSize.width, tSize.height);
        }
    }
    
    return tSize;
}

//+ (CGSize)getFontSize:(float*)fontSize
//              forText:(NSString *)text
//         withFontName:(NSString *)fontName
//               ofSize:(float)desiredFontSize
//           andMinSize:(float)minSize
//             forWidth:(float)width {
//    if(minSize<=0) {
//        minSize=kCEMMinTextFontsize;
//    }
//
//    *fontSize = desiredFontSize;
//    UIFont *font =[UIFont fontWithName:fontName size:*fontSize];
//
//
//
//    // Repalced textsize calculation due to deprecation warning: not tested
//    //  [text sizeWithFont:font minFontSize:minSize actualFontSize:fontSize forWidth:width lineBreakMode:UILineBreakModeWordWrap];
//    CGSize tSize = [text boundingRectWithSize:tSize
//                               options:NSStringDrawingUsesLineFragmentOrigin
//                            attributes:@{NSFontAttributeName:font}
//                               context:nil].size;
//
//    return tSize;
//}

+ (void)setFillColor:(UIColor *)color inContext:(CGContextRef)context {
    float rgbVec[4];
    [CommonUtility getRGBValues:rgbVec fromUIColor:color];
    CGContextSetRGBFillColor(context, rgbVec[0],rgbVec[1],rgbVec[2],rgbVec[3]);
}
+ (void)setStrokeColor:(UIColor *)color inContext:(CGContextRef)context {
    float rgbVec[4];
    [CommonUtility getRGBValues:rgbVec fromUIColor:color];
    CGContextSetStrokeColor(context,rgbVec);
}

#pragma mark -  Image processing methods
+(UIImage *)getImageFromView:(UIView *)view {
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO,0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}
+ (void)drawImage:(UIImage *)image inRect:(CGRect)rect inContext:(CGContextRef)context{
    // begin a new image context
    UIGraphicsBeginImageContextWithOptions(rect.size,NO,0);
    // draw image
    CGContextDrawImage(context, rect, [self flipCGIImage:image.CGImage]);
    UIGraphicsEndImageContext();
}
+ (CGImageRef)flipCGIImage:(CGImageRef)iRef{
    CGSize isize =CGSizeMake(CGImageGetWidth(iRef), CGImageGetHeight(iRef));
    UIGraphicsBeginImageContext(isize);
    CGContextDrawImage(UIGraphicsGetCurrentContext(),
                       CGRectMake(0,0,isize.width, isize.height), iRef);
    CGImageRef iRefFlip = [UIGraphicsGetImageFromCurrentImageContext() CGImage];
    UIGraphicsEndImageContext();
    return iRefFlip;
}
#pragma mark - inner shadow ceation method
+ (UIImage*)blackSquareOfSize:(CGSize)size inContext:(CGContextRef)context {
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    [[UIColor blackColor] setFill];
    CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
    UIImage *blackSquare = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return blackSquare;
}

+ (CGImageRef)createMaskWithSize:(CGSize)size shape:(void (^)(void))block inContext:(CGContextRef)context {
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    block();
    CGImageRef shape = [UIGraphicsGetImageFromCurrentImageContext ()CGImage];
    UIGraphicsEndImageContext();
    CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(shape),
                                        CGImageGetHeight(shape),
                                        CGImageGetBitsPerComponent(shape),
                                        CGImageGetBitsPerPixel(shape),
                                        CGImageGetBytesPerRow(shape),
                                        CGImageGetDataProvider(shape), NULL, false);
    return mask; // mask is released by the calling function
}

+ (void)drawText:(NSString *)text_ font:(UIFont *)font withInnerShadowInRect:(CGRect)rect inContext:(CGContextRef)context {
    // save State
    CGContextSaveGState(context);
    
    //CGSize fontSize = [text_ sizeWithFont:font];
    
    CGImageRef mask = [DrawCustomEffectsManager createMaskWithSize:rect.size shape:^{
        [[UIColor blackColor] setFill];
        CGContextFillRect (context, rect);
        [[UIColor whiteColor] setFill];
        // custom shape goes here
        // Replaced due to deprecation warning: not tested
        // [text_ drawAtPoint:CGPointMake (rect.origin.x, rect.origin.y) withFont:font];
        [text_ drawAtPoint:CGPointMake(rect.origin.x, rect.origin.y)
            withAttributes:@{NSFontAttributeName:font}];
        
        
        // Replaced due to deprecation warning: not tested
        //[text_ drawAtPoint:CGPointMake (rect.origin.x, rect.origin.y-1) withFont:font];
        [text_ drawAtPoint:CGPointMake(rect.origin.x, rect.origin.y-1)
            withAttributes:@{NSFontAttributeName:font}];
        
    } inContext:context];
    
    CGImageRef cutoutRef = CGImageCreateWithMask([DrawCustomEffectsManager blackSquareOfSize:rect.size inContext:context].CGImage, mask);
    CGImageRelease(mask);
    UIImage *cutout = [UIImage imageWithCGImage:cutoutRef scale:[[UIScreen mainScreen] scale] orientation:UIImageOrientationUp];
    CGImageRelease(cutoutRef);
    
    CGImageRef shadedMask = [DrawCustomEffectsManager createMaskWithSize:rect.size shape:^{
        [[UIColor whiteColor] setFill];
        CGContextFillRect (context, rect);
        CGContextSetShadowWithColor (context, CGSizeMake (0, 1), 1.0f, [[UIColor colorWithWhite:0.0 alpha:0.5] CGColor]);
        [cutout drawAtPoint:CGPointZero];
    } inContext:context];
    
    // create negative image
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [[UIColor blackColor] setFill];
    // custom shape goes here
    
    // Replaced due to deprecation warning: not tested
    //  [text_ drawAtPoint:CGPointMake(rect.origin.x, rect.origin.y-1) withFont:font];
    
    [text_ drawAtPoint:CGPointMake(rect.origin.x, rect.origin.y-1)
        withAttributes:@{NSFontAttributeName:font}];
    
    
    UIImage *negative = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGImageRef innerShadowRef = CGImageCreateWithMask(negative.CGImage, shadedMask);
    CGImageRelease(shadedMask);
    UIImage *innerShadow = [UIImage imageWithCGImage:innerShadowRef scale:[[UIScreen mainScreen] scale] orientation:UIImageOrientationUp];
    CGImageRelease(innerShadowRef);
    
    // draw actual image
    [[UIColor whiteColor] setFill];
    // Replaced due to deprecation warning: not tested
    //[text_ drawAtPoint:CGPointMake(rect.origin.x, rect.origin.y-0.5) withFont:font];
    [text_ drawAtPoint:CGPointMake(rect.origin.x, rect.origin.y-0.5)
        withAttributes:@{NSFontAttributeName:font}];
    
    [[UIColor colorWithWhite:0.76 alpha:1.0] setFill];
    // Replaced due to deprecation warning: not tested
    //[text_ drawAtPoint:CGPointMake(rect.origin.x, rect.origin.y-1) withFont:font];
    
    [text_ drawAtPoint:CGPointMake(rect.origin.x, rect.origin.y-1)
        withAttributes:@{NSFontAttributeName:font}];
    
    // finally apply shadow
    [innerShadow drawAtPoint:CGPointZero];
    
    // restore CG Sate
    CGContextRestoreGState(context);
}

@end
