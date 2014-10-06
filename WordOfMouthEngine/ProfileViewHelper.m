//
//  ProfileViewHelper.m
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 2/15/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import "ProfileViewHelper.h"

@implementation ProfileViewHelper

#pragma mark -  View Helper Methods: Views
+ (void)setView:(UIView *)view{
    // set app defaults
    [AppUIManager setUIView:view ofType:kAUCPriorityTypePrimary];
    
    // set custom textview properties
    
}

#pragma mark - Table view
+ (void)setTableView:(UITableView *)tableView{
    // set app defaults
    [AppUIManager setTableView:tableView ofType:kAUCPriorityTypePrimary];
    
    // cutom settings
}

+ (void)setCellProperties:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath {
    // auto layout
    [cell setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    
    // add accessory button
    //cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    
    // Add background image
    //UIImage *image = [UIImage imageNamed:kSLVTableCellBackgroundImage];
    //UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    //imageView.contentMode = UIViewContentModeScaleToFill;
    //cell.frame = [CommonUtility  offSetRect:kIVTableCellFrame byX:45 byY:0];
    //cell.frame = kIVTableCellFrame;
    //cell.backgroundView = [InfoViewHelper getBackgroundViewWithMode:kCVEMTableCellModeNormal];
    //cell.backgroundColor = [AppUIManager getColorOfType:kAUCColorTypePrimary];
    //cell.selectedBackgroundView =  [InfoViewHelper getBackgroundViewWithMode:kCVEMTableCellModeSelected];
    //cell.selectionStyle = UITableViewCellSelectionStyleGray;
    //cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
}

#pragma mark - Text label mathods
+ (UILabel *)getTextLabelForIndexPath:(NSIndexPath *)indexPath{
    // no label
    //if(indexPath.section==0&&indexPath.row==4) {
    //   return nil;
    //}
    UILabel *textLabel= [[UILabel alloc] init];
    textLabel.tag = kPVHCellViewTagsLabel;
    textLabel.textColor = [AppUIManager getColorOfType:kAUCColorTypeTextPrimary];
    [textLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    //[CommonViewElementManager setTextLabelProperties:textLabel
    //                                   withFontSize:kIVTableCellTitleFontSize
    //                                    minFontsize:0
    //                               andNumberOfLines:3];
    
    return textLabel;
}


#pragma mark -  View Helper Methods: Buttons
+ (UIButton *)getButton{
    UIButton *button;  //= //[AppUIManager setButtonWithTitle:@"Sign out" andColor:[UIColor redColor]];
    
    // custom settings
    button.tag=kPVHCellViewTagsButton;

    return button;
}

@end
