//
//  SettingsViewHelper.h
//  WordOfMouthEngine
//
//  Created by Kevin Moy on 10/24/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppUIManager.h"
#import "ApiContent.h"

@interface SettingsViewHelper : UITableViewCell
#pragma mark -  View Helper Methods: Views
+ (void)setView:(UIView *)view;

#pragma mark - Setting Buttons
//@property (nonatomic, strong) UILabel *getLoginOutLabel;
//@property (nonatomic, strong) UILabel *getHistoryLabel;

@property (nonatomic, strong) UILabel *getDescriptionLabel;

@end
