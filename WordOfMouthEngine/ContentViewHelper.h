//
//  ContentViewHelper.h
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 2/15/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppUIManager.h"

@interface ContentViewHelper : NSObject


#pragma mark -  View Helper Methods: Views


#pragma mark -  View Helper Methods: TextViews
+ (void)setContentTextView:(UITextView *)tv withDelegate:(id)delegate;

#pragma mark -  View Helper Methods: Buttons
+ (UIButton *)getSpreadButton;
+ (UIButton *)getKillButton;
@end
