//
//  PublicProfileViewHelper.h
//  WordOfMouthEngine
//
//  Created by Kevin Moy on 3/3/15.
//  Copyright (c) 2015 Bijit Halder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppUIManager.h"

@interface PublicProfileViewHelper : NSObject
#pragma mark -  View Helper Methods: Views
+ (void)setView:(UIView *)view;

#pragma mark - Navigation Bar
+ (UIButton *)getCancelButton;
+ (UIButton *)getSettingsButton;
+ (UILabel *)getProfileTitle;

@end
