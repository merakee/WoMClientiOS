//
//  ProfileViewHelper.h
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 2/15/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppUIManager.h"



// app states
typedef enum {
    kPVHCellViewTagsLabel=1,
    kPVHCellViewTagsButton
} PVHCellViewTags;

static const int kPVHButtonHeight = 36;
static const int kPVHLabelHeight = 36;

@interface ProfileViewHelper : NSObject


#pragma mark -  View Helper Methods: Views
+ (void)setView:(UIView *)view;

#pragma mark - Table view
+ (void)setTableView:(UITableView *)tableView;
+ (void)setCellProperties:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath;

#pragma mark - Text label mathods
+ (UILabel *)getTextLabelForIndexPath:(NSIndexPath *)indexPath;
    
#pragma mark -  View Helper Methods: Buttons
+ (UIButton *)getButton;


@end
