//
//  EmailSignInViewHelper.h
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 2/15/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppUIManager.h"

@interface WomSignInViewHelper : NSObject


#pragma mark -  View Helper Methods: Views
+ (void)setView:(UIView *)view;

#pragma mark -  View Helper Methods: TextLabel 
+ (UILabel *)getPageLabel;

#pragma mark -  View Helper Methods: TextField
+ (void)setEmailTextFiled:(UITextField *)textField withDelegate:(id)delegate;
+ (void)setPasswordTextFiled:(UITextField *)textField withDelegate:(id)delegate;

#pragma mark -  View Helper Methods: Buttons
+ (UIButton *)getSignInButton;
+ (UIButton *)getCancelButton;
@end
