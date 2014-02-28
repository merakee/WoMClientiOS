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

@interface AppUIManager : NSObject

#pragma mark -  Layout methods
+(NSUInteger) getSupportedOrentation;

#pragma mark - Appwide settings
+(UIStatusBarStyle)getStatusBarStyle;

#pragma mark - Color merhods
+ (UIColor *)getColorOfType:(AUCColorType)colorType;
+ (UIColor *)getColorOfType:(AUCColorType)colorType withBrightness:(AUCColorScale)colorBrightness;
+ (UIColor *)getColorOfType:(AUCColorType)colorType withBrightness:(AUCColorScale)colorBrightness andSaturation:(AUCColorScale)colorSaturation;

#pragma mark - view elements methods:  UIView
+ (void)setUIView:(UIView *)view;
+ (void)setUIView:(UIView *)view ofType:(AUCPriorityType)pType;

#pragma mark - view elements methods:  UIImageView
+ (void)setImageView:(UIImageView *)iv;
+ (void)setRoundedCornerToImageView:(UIImageView *)iv;
+ (void)setCircularCropToImageView:(UIImageView *)iv;
    

#pragma mark - view elements methods:  UIButton
+ (void)setUIButton:(UIButton *)button;
+ (void)setUIButton:(UIButton *)button ofType:(AUCPriorityType)pType;
+ (UIButton *)setButtonWithTitle:(NSString *)text ofType:(AUCPriorityType)pType;

#pragma mark - view elements methods:  UITextView
+ (void)setTextView:(UITextView *)textView;
+ (void)setTextView:(UITextView *)textView ofType:(AUCPriorityType)pType;

#pragma mark - view elements methods: UITextFeild
+ (void)setTextField:(UITextField *)textField;
+ (void)setTextField:(UITextField *)textField ofType:(AUCPriorityType)pType;

#pragma mark - view elements methods:  UILabel
+ (void)setUILabel:(UILabel *)label;
+ (void)setUILabel:(UILabel *)label ofType:(AUCPriorityType)pType;

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

#pragma mark - view elements methods:  App logo 
+ (UIImageView *)getAppLogoView;

@end
