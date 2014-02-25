//
//  ProfileViewHelper.m
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 2/15/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import "ProfileViewHelper.h"

@implementation ProfileViewHelper


#pragma mark - Text label mathods
+ (UILabel *)getTextLabelForIndexPath:(NSIndexPath *)indexPath{
    // no label
    //if(indexPath.section==0&&indexPath.row==4) {
    //   return nil;
    //}
    UILabel *textLabel= [[UILabel alloc] init];
    textLabel.tag = kPVHCellViewTagsLabel;
    [textLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    //[CommonViewElementManager setTextLabelProperties:textLabel
    //                                   withFontSize:kIVTableCellTitleFontSize
    //                                    minFontsize:0
    //                               andNumberOfLines:3];
    
    return textLabel;
}


#pragma mark -  View Helper Methods: Buttons
+ (UIButton *)getButton{
    //if(indexPath.section==0&&indexPath.row==4) {
    // log out button
    UIButton *button  = [UIButton buttonWithType:UIButtonTypeSystem];
    button.tag=kPVHCellViewTagsButton;
    button.backgroundColor = [UIColor redColor];
    // set button properties
    //button.frame = CGRectMake(1000,200,80,30);
    // for auto layout
    [button setTranslatesAutoresizingMaskIntoConstraints:NO];
    //[button setTitle:@"Sign Out" forState:UIControlStateNormal];
    return button;
    // }
    
    //return nil;
}

@end
