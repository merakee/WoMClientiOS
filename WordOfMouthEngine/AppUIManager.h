//
//  AppUIManager.h
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 2/13/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppUIConstants.h"
#import "CommonUtility.h"
#import "CommonResourceDefintions.h"

@interface AppUIManager : NSObject

#pragma mark -  Layout methods
+(NSUInteger) getSupportedOrentation;


#pragma mark - Color merhods
+ (UIColor *)getColorOfType:(AUCColorType)colorType;
+ (UIColor *)getColorOfType:(AUCColorType)colorType andBrightness:(AUCColorBrightness)colorBrightness;

#pragma mark - view elements methods:  UIview
+ (void)setUIView:(UIView *)view;
+ (void)setUIView:(UIView *)view ofType:(AUCPriorityType)pType;

#pragma mark - view elements methods:  UITextView
+ (void)setTextView:(UITextView *)textView;
+ (void)setTextView:(UITextView *)textView ofType:(AUCPriorityType)pType;

#pragma mark - view elements methods: UITextFeild
+ (void)setTextField:(UITextField *)textFeild;
+ (void)setTextField:(UITextField *)textFeild ofType:(AUCPriorityType)pType;

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

@end
