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
    view.backgroundColor = [CommonUtility getColorFromHSBACVec:kAUCColorLoginBackground];
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
+ (UIButton *)getButton{
    //UIImage *image = [UIImage imageNamed:@"reply-heart-empty.png"];
    //  UIImageView *cellImageView = [[UIImageView alloc] initWithImage:image];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    //[button setImage:image forState:UIControlStateNormal];
    button.backgroundColor = [UIColor redColor];
    [button setFrame:CGRectMake(30, 10, 18.0, 18.0)];
    // custom settings
    button.tag=kPVHCellViewTagsButton;
    return button;
}
#pragma mark -  View Helper Methods: Navigation bar
+ (UIView *)getNavigationView{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [CommonUtility getColorFromHSBACVec:kAUCBorderColor];
    [view setTranslatesAutoresizingMaskIntoConstraints:NO];
    return view;
}
+ (UILabel *)getPrivateProfileTitle{
    UILabel *titleLabel =[[UILabel alloc] init];
    titleLabel.text=@"My Profile";
    titleLabel.font = [UIFont boldSystemFontOfSize:kAUAppleTitleDefault];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    // accessibilty
    [titleLabel setAccessibilityIdentifier:@"Title label"];
    return titleLabel;
}
+ (UIButton *)getCancelButton{
    UIButton *button =  [AppUIManager getTransparentUIButton];
    [button setImage:[UIImage imageNamed:kAUCCancelButtonImage] forState:UIControlStateNormal];
    [button setAccessibilityIdentifier:@"Cancel"];
    return button;
}
+ (UIButton *)getSettingsButton{
    UIButton *button =  [AppUIManager getTransparentUIButton];
    [button setImage:[UIImage imageNamed:kAUPSettingsButtonImage] forState:UIControlStateNormal];
    [button setAccessibilityIdentifier:@"Settings"];
    return button;
}
+ (UIButton *)getLikesButton{
    UIButton *button =  [AppUIManager getTransparentUIButton];
    [button setImage:[UIImage imageNamed:kAUPSettingsButtonImage] forState:UIControlStateNormal];
    [button setAccessibilityIdentifier:@"Likes"];
    return button;
}
#pragma mark - View Helper Methods: Profile Information
+ (UIView *)getProfileBackground{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor grayColor];
    [view setTranslatesAutoresizingMaskIntoConstraints:NO];
    return view;
}
+ (UIImageView *)getSpreadsIcon{
    UIImageView *si = [[UIImageView alloc] init];
    si.image = [UIImage imageNamed:kAURFilledLikeImage];
    [si setTranslatesAutoresizingMaskIntoConstraints:NO];
    return si;
}
+ (UIImageView *)getLikesIcon{
    UIImageView *li = [[UIImageView alloc] init];
    li.image = [UIImage imageNamed:kAUPLikesCountIcon];
    [li setTranslatesAutoresizingMaskIntoConstraints:NO];
    return li;
}
+ (UILabel *)getSpreadsCount{
    UILabel *label = [[UILabel alloc] init];
    [label setFont: [UIFont fontWithName:kAUCFontFamilySecondary size:kAUCFontSizeSpreadCount]];
    label.textColor = [UIColor whiteColor];
    label.shadowOffset = CGSizeMake(1, 1);
    label.textAlignment = NSTextAlignmentLeft;
    [label setTranslatesAutoresizingMaskIntoConstraints:NO];
    return label;
}
+ (UILabel *)getLikesCount{
    UILabel *label = [[UILabel alloc] init];
    [label setFont: [UIFont fontWithName:kAUCFontFamilySecondary size:kAUPFontSizeLikeCountText]];
    label.textColor = [UIColor whiteColor];
    label.shadowOffset = CGSizeMake(1, 1);
    label.textAlignment = NSTextAlignmentLeft;
    [label setTranslatesAutoresizingMaskIntoConstraints:NO];
    label.text = @"999";

    return label;
}
+ (UIButton *)getProfilePic{
    UIButton *button = [AppUIManager getTransparentUIButton];
    //  [button setImage:[UIImage imageNamed:;] forState:UIControlStateNormal];
    [button setAccessibilityIdentifier:@"ProfilePic"];
    button.backgroundColor = [UIColor redColor];
    return button;
}
+ (UILabel *)getProfileName{
    UILabel *label = [[UILabel alloc] init];
    [label setFont: [UIFont fontWithName:kAUCFontFamilySecondary size:kAUPFontSizeNicknameText]];
    label.textColor = [UIColor whiteColor];
    label.shadowOffset = CGSizeMake(1, 1);
    label.textAlignment = NSTextAlignmentLeft;
    [label setTranslatesAutoresizingMaskIntoConstraints:NO];
    label.text = @"Username";
    return label;
}
+ (UIButton *)getProfilePicBlur{
    UIButton *button = [AppUIManager getTransparentUIButton];
    //  [button setImage:[UIImage imageNamed:;] forState:UIControlStateNormal];
    [button setAccessibilityIdentifier:@"ProfilePic"];
    button.backgroundColor = [UIColor redColor];
    return button;
}
#pragma mark - Profile Location/Bio
+ (UIView *)getUserInformation{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor blueColor];
    [view setTranslatesAutoresizingMaskIntoConstraints:NO];
    return view;
}
+ (UILabel *)getUserBio{
    UILabel *label = [[UILabel alloc] init];
    [label setFont: [UIFont fontWithName:kAUCFontFamilySecondary size:kAUPFontSizeBioText]];
    label.textColor = [UIColor whiteColor];
    label.shadowOffset = CGSizeMake(1, 1);
    label.textAlignment = NSTextAlignmentLeft;
    [label setTranslatesAutoresizingMaskIntoConstraints:NO];
    label.text = @"User Bio";
    return label;
}
+ (UILabel *)getUserLocation{
    UILabel *label = [[UILabel alloc] init];
    [label setFont: [UIFont fontWithName:kAUCFontFamilySecondary size:kAUPFontSizeLocationText]];
    label.textColor = [UIColor whiteColor];
    label.shadowOffset = CGSizeMake(1, 1);
    label.textAlignment = NSTextAlignmentLeft;
    [label setTranslatesAutoresizingMaskIntoConstraints:NO];
    label.text = @"User Location";
    return label;
}
+ (UITextField *)getEditableBio{
    UITextField *textField = [[UITextField alloc] init];
    textField = [[UITextField alloc] init];
    textField.adjustsFontSizeToFitWidth = YES;
    textField.placeholder = @"introduce yourself...";
    textField.returnKeyType = UIReturnKeyDone;
    [textField setTranslatesAutoresizingMaskIntoConstraints:NO];
    return textField;
}
#pragma mark - Social View
+ (UIView *)getProfileSocial{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor greenColor];
    [view setTranslatesAutoresizingMaskIntoConstraints:NO];
    return view;
}
+ (UIImageView *)getSocialTitle{
    UIImageView *imageview = [[UIImageView alloc] init];
    imageview.image = [UIImage imageNamed:kAUPSocialTitleImage];
    [imageview setTranslatesAutoresizingMaskIntoConstraints:NO];
    return imageview;
}
+ (UIImageView *)getInstagramIcon{
    UIImageView *imageview = [[UIImageView alloc] init];
    imageview.image = [UIImage imageNamed:kAUPInstagramImage];
    [imageview setTranslatesAutoresizingMaskIntoConstraints:NO];
    return imageview;
}
+ (UIImageView *)getTumblrIcon{
    UIImageView *imageview = [[UIImageView alloc] init];
    imageview.image = [UIImage imageNamed:kAUPTumblrImage];
    [imageview setTranslatesAutoresizingMaskIntoConstraints:NO];
    return imageview;
}
+ (UIImageView *)getSnapchatIcon{
    UIImageView *imageview = [[UIImageView alloc] init];
    imageview.image = [UIImage imageNamed:kAUPSnapchatImage];
    [imageview setTranslatesAutoresizingMaskIntoConstraints:NO];
    return imageview;
}
+ (UIImageView *)getTwitterIcon{
    UIImageView *imageview = [[UIImageView alloc] init];
    imageview.image = [UIImage imageNamed:kAUPTwitterImage];
    [imageview setTranslatesAutoresizingMaskIntoConstraints:NO];
    return imageview;
}
+ (UILabel *)getInstagramName{
    UILabel *label = [[UILabel alloc] init];
    [label setFont: [UIFont fontWithName:kAUCFontFamilySecondary size:kAUPFontSizeSocialText]];
    label.textColor = [UIColor whiteColor];
    label.shadowOffset = CGSizeMake(1, 1);
    label.textAlignment = NSTextAlignmentLeft;
    [label setTranslatesAutoresizingMaskIntoConstraints:NO];
    label.text = @"Instagram";
    return label;
}
+ (UILabel *)getTumblrName{
    UILabel *label = [[UILabel alloc] init];
    [label setFont: [UIFont fontWithName:kAUCFontFamilySecondary size:kAUPFontSizeSocialText]];
    label.textColor = [UIColor whiteColor];
    label.shadowOffset = CGSizeMake(1, 1);
    label.textAlignment = NSTextAlignmentLeft;
    [label setTranslatesAutoresizingMaskIntoConstraints:NO];
    label.text = @"Tumblr";
    return label;
}
+ (UILabel *)getSnapchatName{
    UILabel *label = [[UILabel alloc] init];
    [label setFont: [UIFont fontWithName:kAUCFontFamilySecondary size:kAUPFontSizeSocialText]];
    label.textColor = [UIColor whiteColor];
    label.shadowOffset = CGSizeMake(1, 1);
    label.textAlignment = NSTextAlignmentLeft;
    [label setTranslatesAutoresizingMaskIntoConstraints:NO];
    label.text = @"Snapchat";
    return label;
}
+ (UILabel *)getTwitterName{
    UILabel *label = [[UILabel alloc] init];
    [label setFont: [UIFont fontWithName:kAUCFontFamilySecondary size:kAUPFontSizeSocialText]];
    label.textColor = [UIColor whiteColor];
    label.shadowOffset = CGSizeMake(1, 1);
    label.textAlignment = NSTextAlignmentLeft;
    [label setTranslatesAutoresizingMaskIntoConstraints:NO];
    label.text = @"Twitter";
    return label;
}
+ (UITextField *)getInstagramText{
    UITextField *textField = [[UITextField alloc] init];
    [textField setFont: [UIFont fontWithName:kAUCFontFamilySecondary size:kAUPFontSizeSocialText]];
    textField.adjustsFontSizeToFitWidth = YES;
    textField.placeholder = @"Add your instagram username..";
    textField.returnKeyType = UIReturnKeyDone;
    [textField setTranslatesAutoresizingMaskIntoConstraints:NO];
    return textField;
}
+ (UITextField *)getTumblrText{
    UITextField *textField = [[UITextField alloc] init];
    [textField setFont: [UIFont fontWithName:kAUCFontFamilySecondary size:kAUPFontSizeSocialText]];
    textField.adjustsFontSizeToFitWidth = YES;
    textField.placeholder = @"Add your tumblr username..";
    textField.returnKeyType = UIReturnKeyDone;
    [textField setTranslatesAutoresizingMaskIntoConstraints:NO];
    return textField;
}
+ (UITextField *)getSnapchatText{
    UITextField *textField = [[UITextField alloc] init];
    [textField setFont: [UIFont fontWithName:kAUCFontFamilySecondary size:kAUPFontSizeSocialText]];
    textField.adjustsFontSizeToFitWidth = YES;
    textField.placeholder = @"Add your snapchat username..";
    textField.returnKeyType = UIReturnKeyDone;
    [textField setTranslatesAutoresizingMaskIntoConstraints:NO];
    return textField;
}
+ (UITextField *)getTwitterText{
    UITextField *textField = [[UITextField alloc] init];
    [textField setFont: [UIFont fontWithName:kAUCFontFamilySecondary size:kAUPFontSizeSocialText]];
    textField.adjustsFontSizeToFitWidth = YES;
    textField.placeholder = @"Add your twitter username..";
    textField.returnKeyType = UIReturnKeyDone;
    [textField setTranslatesAutoresizingMaskIntoConstraints:NO];
    return textField;
}
#pragma mark - Favorite View
+ (UIView *)getFavoriteView{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor blueColor];
    [view setTranslatesAutoresizingMaskIntoConstraints:NO];
    return view;
}
+ (UIImageView *)getFavoriteTitle{
    UIImageView *imageview = [[UIImageView alloc] init];
    imageview.image = [UIImage imageNamed:kAUPFavoritesTitleImage];
    [imageview setTranslatesAutoresizingMaskIntoConstraints:NO];
    return imageview;
}
#pragma mark - History View
+ (UIView *)getHistoryView{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor blueColor];
    [view setTranslatesAutoresizingMaskIntoConstraints:NO];
    return view;
}
+ (UIImageView *)getHistoryTitle{
    UIImageView *imageview = [[UIImageView alloc] init];
    imageview.image = [UIImage imageNamed:kAUPSocialTitleImage];
    [imageview setTranslatesAutoresizingMaskIntoConstraints:NO];
    return imageview;
}
@end
