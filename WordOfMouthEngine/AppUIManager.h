//
//  AppUIManager.h
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 2/13/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import "AppUIConstants.h"
#import "CommonUtility.h"
#import "CommonResourceDefintions.h"
#import "AppConstants.h"
#import "CustomActivityIndicator.h"
//#import "ApiContent.h"

@interface AppUIManager : NSObject

#pragma mark -  Layout methods
+(NSUInteger) getSupportedOrentation;

#pragma mark - Appwide settings
+(UIStatusBarStyle)getStatusBarStyle;

#pragma mark - Color merhods
+ (UIColor *)getColorOfType:(AUCColorType)colorType;
//+ (UIColor *)getColorOfType:(AUCColorType)colorType withBrightness:(AUCColorScale)colorBrightness;
//+ (UIColor *)getColorOfType:(AUCColorType)colorType withBrightness:(AUCColorScale)colorBrightness andSaturation:(AUCColorScale)colorSaturation;

//+ (UIColor *)getContentColorForCategory:(kAPIContentCategory)category;
//+ (UIColor *)getContentTextColorForCategory:(kAPIContentCategory)category andState:(UIControlState)state;


#pragma mark - view elements methods:  UIView
+ (void)setUIView:(UIView *)view;
+ (void)setUIView:(UIView *)view ofType:(AUCPriorityType)pType;
+ (void)addColorGradient:(NSArray *)colors toView:(UIView *)view;

#pragma mark - view elements methods:  UIImageView
+ (void)setImageView:(UIImageView *)iv;
+ (void)setRoundedCornerToImageView:(UIImageView *)iv;
+ (void)setCircularCropToImageView:(UIImageView *)iv;
    

#pragma mark - view elements methods:  UIButton
//+ (void)setUIButton:(UIButton *)button;
+ (UIButton *)getTransparentUIButton;
+ (UIButton *)getTransparentUIButtonWithTitle:(NSString *)title color:(AUCColorType)colorType font:(NSString *)fontFamily size:(CGFloat)fontSize;
//+ (void)setUIButton:(UIButton *)button ofType:(AUCPriorityType)pType;
//+ (UIButton *)setButtonWithTitle:(NSString *)text ofType:(AUCPriorityType)pType;
//+ (UIButton *)setButtonWithTitle:(NSString *)text andColor:(UIColor *)bColor;

#pragma mark - view elements methods:  UISegmentedControl
+ (void)setUISegmentedControl:(UISegmentedControl *)sControl;

#pragma mark - view elements methods:  UITextView
+ (void)setTextView:(UITextView *)textView;
+ (void)setTextView:(UITextView *)textView ofType:(AUCPriorityType)pType;
+ (void)verticallyAlignTextView:(UITextView *)textView;

#pragma mark - view elements methods: UITextFeild
+ (void)setTextField:(UITextField *)textField placeholder:(NSString *)phtext;
//+ (void)setTextField:(UITextField *)textField;
//+ (void)setTextField:(UITextField *)textField ofType:(AUCPriorityType)pType;

#pragma mark - view elements methods:  UILabel
+ (UILabel *)getUILabelWithText:(NSString *)text font:(NSString *)fontFamily ofSize:(CGFloat)fontSize color:(AUCColorType)color;
//+ (void)setUILabel:(UILabel *)label;
//+ (void)setUILabel:(UILabel *)label ofType:(AUCPriorityType)pType;

#pragma mark - view elements methods:  Navbar
+ (void)setNavbar:(UINavigationBar *)navbar;

#pragma mark - view elements methods:  Tabbar
+ (void)setTabbar:(UITabBar *)tabbar;


#pragma mark - view elements methods:  Toolbar
+ (void)setToolbar:(UIToolbar *)toolbar;

#pragma mark - view elements methods:  Table view
+ (void)setTableView:(UITableView *)tableView;
+ (void)setTableCell:(UITableViewCell *)tableViewCell;
+ (void)setTableView:(UITableView *)tableView ofType:(AUCPriorityType)pType;
+ (void)setTableCell:(UITableViewCell *)tableViewCell ofType:(AUCPriorityType)pType;

#pragma mark - view elements methods:  Activity Indicator
+ (void)addActivityIndicator:(UIActivityIndicatorView *)activityIndicator toView:(UIView *)view;
+ (void)addCustomActivityIndicator:(CustomActivityIndicator *)activityIndicator toView:(UIView *)view;

#pragma mark - view elements methods:  App logo 
+ (UIImageView *)getAppLogoView;
+ (UIImageView *)getAppLogoViewForNavTitle;

#pragma mark - Utility methods
+ (void)setBorder:(id)view withColor:(UIColor *)color;
+ (CGSize)getSizeForText:(NSString *)text sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;
+ (void)setBottomBorder:(id)view withColor:(UIColor *)color;

#pragma mark  - layout methods
+ (void)horizontallyCenterElement:(UIView *)view inView:(UIView *)sview;
+ (void)verticallyCenterElement:(UIView *)view inView:(UIView *)sview;

#pragma mark - Timing methods
+(void)dispatchBlock:(void (^)())action afterDelay:(double)delayInSeconds;
@end
