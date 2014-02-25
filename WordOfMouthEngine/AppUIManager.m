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


#pragma mark - Color merhods
+ (UIColor *)getColorOfType:(AUCColorType)colorType{
    return [AppUIManager getColorOfType:colorType andBrightness:kAUCColorBrightnessNormal];
}
+ (UIColor *)getColorOfType:(AUCColorType)colorType andBrightness:(AUCColorBrightness)colorBrightness{
    UIColor *color = [UIColor whiteColor];
    
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
        case kAUCColorTypeBackground:
            color=[CommonUtility getColorFromHSBACVec:kAUCColorBackground];
            break;
        case kAUCColorTypeTint:
            color=[CommonUtility getColorFromHSBACVec:kAUCColorTint];
            break;
        case kAUCColorTypeText:
            color=[CommonUtility getColorFromHSBACVec:kAUCColorText];
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
    switch (colorBrightness) {
        case kAUCColorBrightnessLighter:
            color = [CommonUtility getColor:color withScaledBrightness:kAUCColorBrightnessLighterScale];
            break;
        case kAUCColorBrightnessDarker:
            color = [CommonUtility getColor:color withScaledBrightness:kAUCColorBrightnessDarkerScale];
            break;
        default:
            break;
    }
    
    return color;
}

#pragma mark - view elements methods:  UIview
+ (void)setUIView:(UIView *)view{
    [AppUIManager setUIView:view ofType:kAUCPriorityTypePrimary];
}

+ (void)setUIView:(UIView *)view ofType:(AUCPriorityType)pType{
    
}
#pragma mark - view elements methods:  UITextView
+ (void)setTextView:(UITextView *)textView{
        [AppUIManager setTextView:textView ofType:kAUCPriorityTypePrimary];
}

+ (void)setTextView:(UITextView *)textView ofType:(AUCPriorityType)pType{
    
}
#pragma mark - view elements methods: UITextFeild
+ (void)setTextField:(UITextField *)textFeild{
        [AppUIManager setTextField:textFeild ofType:kAUCPriorityTypePrimary];
}

+ (void)setTextField:(UITextField *)textFeild ofType:(AUCPriorityType)pType{
    
}
#pragma mark - view elements methods:  UILabel
+ (void)setUILabel:(UILabel *)label{
        [AppUIManager setUILabel:label ofType:kAUCPriorityTypePrimary];
}

+ (void)setUILabel:(UILabel *)label ofType:(AUCPriorityType)pType{
    
}
#pragma mark - view elements methods:  Navbar
+ (void)setNavbar:(UINavigationBar *)navbar{
    
}


#pragma mark - view elements methods:  Tabbar
+ (void)setTabbar:(UITabBar *)tabbar{
    
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
    
}

+ (void)setTableCell:(UITableViewCell *)tableViewCell ofType:(AUCPriorityType)pType{
    
}


@end
