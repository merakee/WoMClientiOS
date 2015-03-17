//
//  PrivateProfileViewController.h
//  WordOfMouthEngine
//
//  Created by Kevin Moy on 2/25/15.
//  Copyright (c) 2015 Bijit Halder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomContentView.h"
@interface PrivateProfileViewController : UIViewController <UIScrollViewDelegate, UITextFieldDelegate> {
    
    // Whole view is a scroll View except navigation bar
    UIScrollView    *mainScrollView;
    
    
    // Navigation Bar
    UIView      *navigationView;
    UIButton    *cancelButton;
    UIButton    *settingsButton;
    UILabel     *profileTitle;
    
    // Profile Data
   // UIImageView     *profilePic;
    UIImageView     *profilePicBlur;
    
    UIView          *profileBackground;
    UIImageView     *likesIcon;
    UILabel         *nicknameLabel;
    UILabel         *likesCount;
    
    UIView          *userInformation;
    UITextField         *userBio;
    UILabel         *userLocation;
    
    UIView          *divider;
    UIView          *profileSocial;
    UIImageView     *socialTitle;
    UIImageView     *instagramIcon;
    UIImageView     *tumblrIcon;
    UIImageView     *snapchatIcon;
    UIImageView     *twitterIcon;
    UITextField     *instagramName;
    UITextField     *tumblrName;
    UITextField     *snapchatName;
    UITextField     *twitterName;
    
    UIView          *favoritesView;
    UIImageView         *favoritesTitle;
}
@property (nonatomic) UIImageView *profilePic;
@end
