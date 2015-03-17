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
    
#pragma mark -  View Helper Methods: Navigation View
+ (UIView *)getNavigationView;
+ (UIButton *)getButton;
+ (UIButton *)getCancelButton;
+ (UIButton *)getSettingsButton;
+ (UIButton *)getLikesButton;
+ (UILabel *)getPrivateProfileTitle;

#pragma mark - Profile Information
+ (UIView *)getProfileBackground;
+ (UIImageView *)getSpreadsIcon;
+ (UIImageView *)getLikesIcon;
+ (UILabel *)getSpreadsCount;
+ (UILabel *)getLikesCount;
+ (UIImageView *)getProfilePic;
+ (UILabel *)getProfileName;
+ (UIImageView *)getProfilePicBlur;

#pragma mark - Profile City/Bio
+ (UIView *)getUserInformation;
+ (UILabel *)getUserBio;
+ (UILabel *)getUserLocation;
+ (UITextField *)getEditableBio;

#pragma mark - Profile Social
+ (UIView *)getProfileSocial;
+ (UIImageView *)getSocialTitle;
+ (UIImageView *)getInstagramIcon;
+ (UIImageView *)getTumblrIcon;
+ (UIImageView *)getSnapchatIcon;
+ (UIImageView *)getTwitterIcon;
+ (UILabel  *)getInstagramName;
+ (UILabel  *)getTumblrName;
+ (UILabel  *)getSnapchatName;
+ (UILabel  *)getTwitterName;

+ (UITextField *)getInstagramText;
+ (UITextField *)getTumblrText;
+ (UITextField *)getSnapchatText;
+ (UITextField *)getTwitterText;

#pragma mark - Favorite View
+ (UIView *)getFavoriteView;
+ (UIImageView *)getFavoriteTitle;

#pragma mark - History View
+ (UIView *)getHistoryView;
+ (UIImageView *)getHistoryTitle;

@end
