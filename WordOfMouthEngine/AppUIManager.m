//
//  AppUIManager.m
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 2/13/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import "AppUIManager.h"

@implementation AppUIManager


#pragma mark -  Layout methods
+(NSUInteger) getSupportedOrentation{
    return UIInterfaceOrientationMaskPortrait |  UIInterfaceOrientationMaskPortraitUpsideDown;
}

#pragma mark - Appwide settings
+(UIStatusBarStyle)getStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

#pragma mark - Color merhods
+ (UIColor *)getColorOfType:(AUCColorType)colorType{
    return [AppUIManager getColorOfType:colorType withBrightness:kAUCColorScaleNormal andSaturation:kAUCColorScaleNormal];
}


+ (UIColor *)getColorOfType:(AUCColorType)colorType withBrightness:(AUCColorScale)colorBrightness{
    return [AppUIManager getColorOfType:colorType withBrightness:colorBrightness  andSaturation:kAUCColorScaleNormal];
}

+ (UIColor *)getColorOfType:(AUCColorType)colorType withBrightness:(AUCColorScale)colorBrightness andSaturation:(AUCColorScale)colorSaturation{
    UIColor *color;// = [UIColor whiteColor];
    
    switch (colorType) {
        case kAUCColorTypePrimary:
            color=[CommonUtility getColorFromHSBACVec:kAUCColorPrimary];
            break;
        case kAUCColorTypeSecondary:
            color=[CommonUtility getColorFromHSBACVec:kAUCColorSecondary];
            break;
        case kAUCColorTypeTertiary:
            color=[CommonUtility getColorFromHSBACVec:kAUCColorTertiary];
            break;
        case kAUCColorTypeGray:
            color=[CommonUtility getColorFromHSBACVec:kAUCColorGray];
            break;
        case kAUCColorTypeBackground:
            color=[CommonUtility getColorFromHSBACVec:kAUCColorBackground];
            break;
        case kAUCColorTypeTint:
            color=[CommonUtility getColorFromHSBACVec:kAUCColorTint];
            break;
        case kAUCColorTypeTintSelected:
            color=[CommonUtility getColorFromHSBACVec:kAUCColorTintSelected];
            break;
        case kAUCColorTypeTintUnselected:
            color=[CommonUtility getColorFromHSBACVec:kAUCColorTintUnselected];
            break;
        case kAUCColorTypeTextPrimary:
            color=[CommonUtility getColorFromHSBACVec:kAUCColorTextPrimary];
            break;
        case kAUCColorTypeTextPrimaryLight:
            color=[CommonUtility getColorFromHSBACVec:kAUCColorTextPrimaryLight];
            break;
        case kAUCColorTypeTextSecondary:
            color=[CommonUtility getColorFromHSBACVec:kAUCColorTextSecondary];
            break;
        case kAUCColorTypeTextTertiary:
            color=[CommonUtility getColorFromHSBACVec:kAUCColorTextTertiary];
            break;
            
        default:
            color=[CommonUtility getColorFromHSBACVec:kAUCColorPrimary];
            break;
    }
    // brightness
    float bscaleFactor=[AppUIManager getValueForColorScaleFactor:colorBrightness];
    float sscaleFactor=[AppUIManager getValueForColorScaleFactor:colorSaturation];
    color  = [CommonUtility getColor:color withScaledBrightness:bscaleFactor andScaledSaturation:sscaleFactor];
    
    return color;
}

+ (float)getValueForColorScaleFactor:(AUCColorScale)scale{
    float scaleFactor = 1.0;
    
    switch (scale){
        case kAUCColorScaleLight:
            scaleFactor += kAUCColorScaleFactor;
            break;
        case kAUCColorScaleDark:
            scaleFactor -= kAUCColorScaleFactor;
            break;
        case kAUCColorScaleLighter:
            scaleFactor += 2*kAUCColorScaleFactor;
            break;
        case kAUCColorScaleDarker:
            scaleFactor -= 2*kAUCColorScaleFactor;
            break;
        case kAUCColorScaleLightest:
            scaleFactor += 3*kAUCColorScaleFactor;
            break;
        case kAUCColorScaleDarkest:
            scaleFactor -= 3*kAUCColorScaleFactor;
            break;
        default:
            break;
    }
    
    // min and max limit
    if(scaleFactor<0.0){
        scaleFactor=0.0;
    }
    
    return scaleFactor;
}

+ (UIColor *)getContentTextColorForCategory:(ACMContentCategory)category andState:(UIControlState)state{
    UIColor *color =[AppUIManager getContentColorForCategory:category];
    
    float bscaleFactor=1.0, sscaleFactor=1.0;
    // change brightness and saturation for text
    if(state==UIControlStateSelected){
        bscaleFactor=[AppUIManager getValueForColorScaleFactor:kAUCColorScaleDarker];
        sscaleFactor=[AppUIManager getValueForColorScaleFactor:kAUCColorScaleLightest];
    }
    else{
        bscaleFactor=[AppUIManager getValueForColorScaleFactor:kAUCColorScaleDark];
        sscaleFactor=[AppUIManager getValueForColorScaleFactor:kAUCColorScaleLightest];
    }
    color  = [CommonUtility getColor:color withScaledBrightness:bscaleFactor andScaledSaturation:sscaleFactor];
    
    return color;
}

+ (UIColor *)getContentColorForCategory:(ACMContentCategory)category{
    UIColor *color;
    switch (category) {
        case kContentCategoryNews:
            color=[CommonUtility getColorFromHSBACVec:kAUCColorContentNews];
            break;
        case kContentCategoryGossip:
            color=[CommonUtility getColorFromHSBACVec:kAUCColorContentGossip];
            break;
        case kContentCategorySecret:
            color=[CommonUtility getColorFromHSBACVec:kAUCColorContentSecret];
            break;
        case kContentCategoryLocal:
            color=[CommonUtility getColorFromHSBACVec:kAUCColorContentLocal];
            break;
        default:
            color=[CommonUtility getColorFromHSBACVec:kAUCColorContentOther];
            break;
    }
    
    
    return color;
}

#pragma mark - view elements methods:  UIview
+ (void)setUIView:(UIView *)view{
    [AppUIManager setUIView:view ofType:kAUCPriorityTypePrimary];
}

+ (void)setUIView:(UIView *)view ofType:(AUCPriorityType)pType{
    // set view properties
    //view.backgroundColor = [AppUIManager getColorOfType:kAUCColorTypeGray];
    
    // add gradient
    [AppUIManager addColorGradient:view];
}

+ (void)addColorGradient:(UIView *)view{
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = view.bounds;
    gradient.colors = @[(id)[[AppUIManager getColorOfType:kAUCColorTypeBackground withBrightness:kAUCColorScaleNormal andSaturation:kAUCColorScaleLightest] CGColor],
                        // (id)[[AppUIManager getColorOfType:kAUCColorTypePrimary withBrightness:kAUCColorScaleLightest
                        //                   andSaturation:kAUCColorScaleDarkest] CGColor],
                        (id)[[AppUIManager getColorOfType:kAUCColorTypeBackground withBrightness:kAUCColorScaleLight
                                            andSaturation:kAUCColorScaleDark] CGColor],
                        (id)[[AppUIManager getColorOfType:kAUCColorTypeBackground withBrightness:kAUCColorScaleNormal andSaturation:kAUCColorScaleLightest] CGColor]];
    [view.layer insertSublayer:gradient atIndex:1];
}

#pragma mark - view elements methods:  UIImageView
+ (void)setImageView:(UIImageView *)iv{
    iv.backgroundColor  =[AppUIManager getColorOfType:kAUCColorTypeGray withBrightness:kAUCColorScaleDark];
    
    // rounder cover
    [AppUIManager setRoundedCornerToImageView:iv];
    // for auto layout
    [iv setTranslatesAutoresizingMaskIntoConstraints:NO];
}


#pragma mark - view elements methods:  UIButton
+ (void)setUIButton:(UIButton *)button{
    [AppUIManager setUIButton:button  ofType:kAUCPriorityTypePrimary];
}
+ (void)setUIButton:(UIButton *)button ofType:(AUCPriorityType)pType{
    // colors and fonts
    [AppUIManager setClearButton:button ofType:pType];
    //[AppUIManager setSolidButton:button ofType:pType];
    
    // set button properties
    // titleLabel  property
    //titleForState:
    // – setTitle:forState:
    //– attributedTitleForState:
    //– setAttributedTitle:forState:
    
    //[button setTitleColor:[AppUIManager getColorOfType:kAUCColorTypeTextPrimary] forState:UIControlStateNormal];
    //[button setBackgroundColor:[UIColor whiteColor]];
    
    // – setTitleColor:forState:
    // – titleShadowColorForState:
    // – setTitleShadowColor:forState:
    // reversesTitleShadowWhenHighlighted  property
    
    // rounded corner
    [AppUIManager setRoundedCorner:button];
    
    
    
    // for auto layout
    [button setTranslatesAutoresizingMaskIntoConstraints:NO];
    
}

+ (void)setSolidButton:(UIButton *)button ofType:(AUCPriorityType)pType{
    // colors and fonts
    switch (pType) {
        case kAUCPriorityTypeSecondary:
            button.backgroundColor = [AppUIManager getColorOfType:kAUCColorTypeSecondary];
            [button setTitleColor:[AppUIManager getColorOfType:kAUCColorTypeTextPrimaryLight] forState:UIControlStateNormal];
            break;
        case kAUCPriorityTypeTertiary:
            button.backgroundColor = [AppUIManager getColorOfType:kAUCColorTypeTertiary];
            [button setTitleColor:[AppUIManager getColorOfType:kAUCColorTypeTextPrimaryLight] forState:UIControlStateNormal];
            break;
        default:
            button.backgroundColor = [AppUIManager getColorOfType:kAUCColorTypePrimary];
            [button setTitleColor:[AppUIManager getColorOfType:kAUCColorTypeTextPrimaryLight] forState:UIControlStateNormal];
            break;
    }
    
}
+ (void)setClearButton:(UIButton *)button ofType:(AUCPriorityType)pType{
    // colors and fonts
    button.backgroundColor = [UIColor clearColor];
    switch (pType) {
        case kAUCPriorityTypeSecondary:
            [button setTitleColor:[AppUIManager getColorOfType:kAUCColorTypeSecondary] forState:UIControlStateNormal];
            // border
            [AppUIManager setBorder:button withColor:[AppUIManager getColorOfType:kAUCColorTypeSecondary]];
            break;
        case kAUCPriorityTypeTertiary:
            [button setTitleColor:[AppUIManager getColorOfType:kAUCColorTypeTertiary] forState:UIControlStateNormal];
            // border
            [AppUIManager setBorder:button withColor:[AppUIManager getColorOfType:kAUCColorTypeTertiary]];
            break;
        default:
            [button setTitleColor:[AppUIManager getColorOfType:kAUCColorTypePrimary] forState:UIControlStateNormal];
            // border
            [AppUIManager setBorder:button withColor:[AppUIManager getColorOfType:kAUCColorTypePrimary]];
            break;
    }
    
}

+ (UIButton *)setButtonWithTitle:(NSString *)text ofType:(AUCPriorityType)pType{
    UIButton *button  = [UIButton buttonWithType:UIButtonTypeCustom];
    // set app defaults
    [AppUIManager setUIButton:button ofType:pType];
    [button setTitle:text forState:UIControlStateNormal];
    
    return button;
}
+ (UIButton *)setButtonWithTitle:(NSString *)text andColor:(UIColor *)bColor{
    UIButton *button  = [UIButton buttonWithType:UIButtonTypeCustom];
    // set app defaults
    [AppUIManager setUIButton:button];
    
    // cumtom
    [button setTitleColor:bColor forState:UIControlStateNormal];
    [AppUIManager setBorder:button withColor:bColor];
    [button setTitle:text forState:UIControlStateNormal];
    
    return button;
}

#pragma mark - view elements methods:  UISegmentedControl
+ (void)setUISegmentedControl:(UISegmentedControl *)sControl{
    
    // for auto layout
    [sControl setTranslatesAutoresizingMaskIntoConstraints:NO];
}
#pragma mark - view elements methods:  UITextView
+ (void)setTextView:(UITextView *)textView{
    [AppUIManager setTextView:textView ofType:kAUCPriorityTypePrimary];
}

+ (void)setTextView:(UITextView *)textView ofType:(AUCPriorityType)pType{
    // set textview properties
    // colors and fonts
    switch (pType) {
        case kAUCPriorityTypeSecondary:
            textView.backgroundColor = [AppUIManager getColorOfType:kAUCColorTypeSecondary];
            textView.font = [UIFont fontWithName:kAUCFontFamilySecondary size:kAUCFontSizeSecondary];
            textView.textColor = [AppUIManager getColorOfType:kAUCColorTypeTextSecondary];
            break;
        case kAUCPriorityTypeTertiary:
            textView.backgroundColor = [AppUIManager getColorOfType:kAUCColorTypeTertiary];
            textView.font = [UIFont fontWithName:kAUCFontFamilyTertiary size:kAUCFontSizeTertiary];
            textView.textColor = [AppUIManager getColorOfType:kAUCColorTypeTextTertiary];
            break;
            
        default:
            textView.backgroundColor = [AppUIManager getColorOfType:kAUCColorTypePrimary];
            textView.font = [UIFont fontWithName:kAUCFontFamilyPrimary size:kAUCFontSizePrimary];
            textView.textColor = [AppUIManager getColorOfType:kAUCColorTypeTextPrimary];
            break;
    }
    
    textView.backgroundColor = [UIColor whiteColor];
    
    // other properties
    
    // textView.text=@"";
    //textView.attributedText =
    //
    //
    
    // others
    //textView.editable = NO;
    //textView.selectable = YES;
    //textView.allowsEditingTextAttributes = NO;
    //textView.dataDetectorTypes = UIDataDetectorTypeAll ;
    textView.textAlignment = NSTextAlignmentCenter;
    //textView.typingAttributes =
    // textView.linkTextAttributes =
    //textView.textContainerInset =
    //[textView sizeToFit];
    
    // text shadow: use layer property (UIView)
    //textView.layer.shadowColor = [HEXCOLOR (kCRDShadowWhiteColor) CGColor];
    //textView.layer.shadowColor = [HEXCOLOR (kCRDTextDropShadowColor) CGColor];
    // textView.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    // textView.layer.shadowOpacity = 0.6f;
    // textView.layer.shadowRadius = 0.0f;
    
    // set up key board
    //textView.keyboardType = UIKeyboardTypeAlphabet;
    //textView.returnKeyType = UIReturnKeyDefault;
    
    // rounded corner
    [AppUIManager setRoundedCorner:textView];
    
    // for auto layout
    [textView setTranslatesAutoresizingMaskIntoConstraints:NO];
}
+ (void)verticallyAlignTextView:(UITextView *)textView{
    CGSize size =[AppUIManager getSizeForText:textView.text  sizeWithFont:textView.font constrainedToSize:textView.frame.size];
    CGRect  nFrame =textView.frame;
    nFrame.size.height = size.height+30;
    nFrame.origin.y = (textView.superview.frame.size.height-nFrame.size.height)/2.0;
    textView.frame = nFrame;
}

#pragma mark - view elements methods: UITextFeild
+ (void)setTextField:(UITextField *)textField{
    [AppUIManager setTextField:textField ofType:kAUCPriorityTypePrimary];
}

+ (void)setTextField:(UITextField *)textField ofType:(AUCPriorityType)pType{
    // set textField properties
    // colors and fonts
    switch (pType) {
        case kAUCPriorityTypeSecondary:
            textField.backgroundColor = [AppUIManager getColorOfType:kAUCColorTypeSecondary];
            textField.font = [UIFont fontWithName:kAUCFontFamilySecondary size:kAUCFontSizeSecondary];
            textField.textColor = [AppUIManager getColorOfType:kAUCColorTypeTextSecondary];
            // add border
            [AppUIManager setBorder:textField withColor:[AppUIManager getColorOfType:kAUCColorTypeSecondary]];
            break;
        case kAUCPriorityTypeTertiary:
            textField.backgroundColor = [AppUIManager getColorOfType:kAUCColorTypeTertiary];
            textField.font = [UIFont fontWithName:kAUCFontFamilyTertiary size:kAUCFontSizeTertiary];
            textField.textColor = [AppUIManager getColorOfType:kAUCColorTypeTextTertiary];
            // add border
            [AppUIManager setBorder:textField withColor:[AppUIManager getColorOfType:kAUCColorTypeTertiary]];
            break;
        default:
            textField.backgroundColor = [AppUIManager getColorOfType:kAUCColorTypePrimary];
            textField.font = [UIFont fontWithName:kAUCFontFamilyPrimary size:kAUCFontSizePrimary];
            textField.textColor = [AppUIManager getColorOfType:kAUCColorTypeTextPrimary];
            // add border
            [AppUIManager setBorder:textField withColor:[AppUIManager getColorOfType:kAUCColorTypePrimary]];
            break;
    }
    
    textField.backgroundColor = [UIColor clearColor];
    // palce holder text color
    //textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"place holder" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    textField.textAlignment = NSTextAlignmentCenter;
    // others
    //textField.borderStyle  property
    //background  property
    // disabledBackground  property
    
    // rounded corner
    [AppUIManager setRoundedCorner:textField];
    
    
}

#pragma mark - view elements methods:  UILabel
+ (void)setUILabel:(UILabel *)label{
    [AppUIManager setUILabel:label ofType:kAUCPriorityTypePrimary];
}

+ (void)setUILabel:(UILabel *)label ofType:(AUCPriorityType)pType{
    // set label properties
    // colors and fonts
    switch (pType) {
        case kAUCPriorityTypeSecondary:
            label.backgroundColor = [AppUIManager getColorOfType:kAUCColorTypeSecondary];
            label.font = [UIFont fontWithName:kAUCFontFamilySecondary size:kAUCFontSizeSecondary];
            label.textColor = [AppUIManager getColorOfType:kAUCColorTypeTextPrimaryLight];
            // add border
            //[AppUIManager setBorder:label withColor:[AppUIManager getColorOfType:kAUCColorTypeSecondary]];
            break;
        case kAUCPriorityTypeTertiary:
            label.backgroundColor = [AppUIManager getColorOfType:kAUCColorTypeTertiary];
            label.font = [UIFont fontWithName:kAUCFontFamilyTertiary size:kAUCFontSizeTertiary];
            label.textColor = [AppUIManager getColorOfType:kAUCColorTypeTextPrimaryLight];
            // add border
            //[AppUIManager setBorder:label withColor:[AppUIManager getColorOfType:kAUCColorTypeTertiary]];
            break;
        default:
            label.backgroundColor = [AppUIManager getColorOfType:kAUCColorTypePrimary];
            label.font = [UIFont fontWithName:kAUCFontFamilyPrimary size:kAUCFontSizePrimary];
            label.textColor = [AppUIManager getColorOfType:kAUCColorTypeTextPrimaryLight];
            // add border
            //[AppUIManager setBorder:label withColor:[AppUIManager getColorOfType:kAUCColorTypePrimary]];
            break;
    }
    
    //label.backgroundColor = [UIColor clearColor];
    // palce holder text color
    //label.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"place holder" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    label.textAlignment = NSTextAlignmentCenter;
    // others
    //label.borderStyle  property
    //background  property
    // disabledBackground  property
    
    // rounded corner
    [AppUIManager setRoundedCorner:label];
    
    // for auto layout
    [label setTranslatesAutoresizingMaskIntoConstraints:NO];
}
#pragma mark - view elements methods:  Navbar
+ (void)setNavbar:(UINavigationBar *)navbar{
    //backIndicatorImage  property
    //backIndicatorTransitionMaskImage  property
    //barStyle  property
    //barTintColor  property
    //shadowImage  property
    //tintColor  property
    //navbar.tintColor  =  [AppUIManager getColorOfType:kAUCColorTypeTint];
    //translucent  property
    //navbar.translucent  =  YES;
    //– backgroundImageForBarMetrics:
    //– setBackgroundImage:forBarMetrics:
    //– backgroundImageForBarPosition:barMetrics:
    //– setBackgroundImage:forBarPosition:barMetrics:
    //– titleVerticalPositionAdjustmentForBarMetrics:
    //– setTitleVerticalPositionAdjustment:forBarMetrics:
    //titleTextAttributes  property
    
}


#pragma mark - view elements methods:  Tabbar
+ (void)setTabbar:(UITabBar *)tabbar{
    // set properties
    //tabbar.barStyle  =  UIBarStyleDefault;
    //tabbar.barTintColor  =  [AppUIManager getColorOfType:kAUCColorTypeTint];
    //tabbar.itemPositioning  =  ;
    //tabbar.itemSpacing  =  ;
    //tabbar.itemWidth  =  ;
    tabbar.tintColor  =  [AppUIManager getColorOfType:kAUCColorTypeTintSelected];
    
    //tabbar.selectedImageTintColor  =  [AppUIManager getColorOfType:kAUCColorTypeTertiary];
    tabbar.translucent  =  NO;
    //tabbar.backgroundImage  =  ;
    //tabbar.shadowImage  =  ;
    //tabbar.selectionIndicatorImage  =  ;
    
}



#pragma mark - view elements methods:  Toolbar
+ (void)setToolbar:(UIToolbar *)toolbar{
    
}


#pragma mark - view elements methods:  Table view
+ (void)setTableView:(UITableView *)tableView{
    [AppUIManager setTableView:tableView ofType:kAUCPriorityTypePrimary];
}

+ (void)setTableCell:(UITableViewCell *)tableViewCell{
    [AppUIManager setTableCell:tableViewCell ofType:kAUCPriorityTypePrimary];
}

+ (void)setTableView:(UITableView *)tableView ofType:(AUCPriorityType)pType{
    // clear backgroud
    tableView.backgroundView = nil;
    tableView.backgroundColor = [AppUIManager getColorOfType:kAUCColorTypeBackground];
    //[AppUIManager setUIView:tableView.backgroundView  ofType:kAUCPriorityTypePrimary];
    
}

+ (void)setTableCell:(UITableViewCell *)tableViewCell ofType:(AUCPriorityType)pType{
    
}

#pragma mark - view elements methods:  Activity Indicator
+ (void)addActivityIndicator:(UIActivityIndicatorView *)activityIndicator toView:(UIView *)view{
    [activityIndicator setTranslatesAutoresizingMaskIntoConstraints:NO];
    activityIndicator.hidesWhenStopped=YES;
    activityIndicator.activityIndicatorViewStyle  = UIActivityIndicatorViewStyleGray;
    [view addSubview:activityIndicator];
    
    // layout: in the center
    [view addConstraint:[NSLayoutConstraint constraintWithItem:activityIndicator
                                                     attribute:NSLayoutAttributeCenterY
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:view
                                                     attribute:NSLayoutAttributeCenterY
                                                    multiplier:1.0
                                                      constant:0.0]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:activityIndicator
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:view
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0
                                                      constant:0.0]];
}

#pragma mark - Utility methods
+ (void)setRoundedCorner:(id)view{
    // rounded corner
    ((UIView *)view).layer.cornerRadius = kAUCRectCornerRadius;
}
+ (void)setRoundedCornerToImageView:(UIImageView *)iv{
    // rounded corner
    // Get the Layer of any view
    CALayer *caLayer = [iv layer];
    [caLayer setMasksToBounds:YES];
    [caLayer setCornerRadius:kAUCRectCornerRadius];
}
+ (void)setCircularCropToImageView:(UIImageView *)iv{
    // create shape layer for circle we'll draw on top of image (the boundary of the circle)
    CAShapeLayer *circleLayer = [CAShapeLayer layer];
    circleLayer.lineWidth = 1.0;
    circleLayer.fillColor = [[UIColor whiteColor] CGColor];
    circleLayer.strokeColor = [[UIColor whiteColor] CGColor];
    
    iv.layer.mask=circleLayer;
    
    [CommonUtility  printPoint:iv.center];
    NSLog(@"%f",fminf(iv.frame.size.height,iv.frame.size.width)/2.0-circleLayer.lineWidth);
    // create circle path
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path addArcWithCenter:iv.center
                    radius:fminf(iv.frame.size.height,iv.frame.size.width)/2.0-circleLayer.lineWidth
                startAngle:0.0
                  endAngle:M_PI * 2.0
                 clockwise:YES];
    circleLayer.path = [path CGPath];
    
    
}
+ (void)setBorder:(id)view withColor:(UIColor *)color{
    ((UIView *)view).layer.borderWidth = kAUCRectBorderWidth;
    if(color==nil){
        ((UIView *)view).layer.borderColor = [UIColor whiteColor].CGColor;
    }
    else{
        ((UIView *)view).layer.borderColor = color.CGColor;
    }
}

+ (CGSize)getSizeForText:(NSString *)text sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size{
    CGRect frame = [text boundingRectWithSize:size
                                      options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                   attributes:@{NSFontAttributeName:font}
                                      context:nil];
    return frame.size;
}


#pragma mark - view elements methods:  App logo
+ (UIImageView *)getAppLogoView{
    UIImageView *iv =[[UIImageView alloc] initWithImage:[UIImage imageNamed:kAUCAppLogoImage]];
    // defautl setting
    [AppUIManager setImageView:iv];
    return iv;
}

@end
