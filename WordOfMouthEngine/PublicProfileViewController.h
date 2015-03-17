//
//  PublicProfileViewController.h
//  WordOfMouthEngine
//
//  Created by Kevin Moy on 2/25/15.
//  Copyright (c) 2015 Bijit Halder. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PublicProfileViewController : UIViewController <UIScrollViewDelegate> {
    
    // Whole view is a scroll View except navigation bar
    UIScrollView    *mainScrollView;
    
    
    // Navigation Bar
    UIView      *navigationView;
    UIButton    *cancelButton;
    UIButton    *likesButton;
    UILabel     *profileTitle;
    
    // Profile Data
    UIImageView     *profilePic;
    UIImageView     *profilePicBlur;
    
    UIView          *profileBackground;
    UIImageView     *likesIcon;
    UILabel         *nicknameLabel;
    UILabel         *likesCount;
    
    UIView          *userInformation;
    UILabel         *userBio;
    UILabel         *userLocation;
    
    UIView          *divider;
    UIView          *profileSocial;
    UIImageView     *socialTitle;
    UIImageView     *instagramIcon;
    UIImageView     *tumblrIcon;
    UIImageView     *snapchatIcon;
    UIImageView     *twitterIcon;
    UILabel         *instagramName;
    UILabel         *tumblrName;
    UILabel         *snapchatName;
    UILabel         *twitterName;
    
    UIView          *favoritesView;
    UIImageView         *favoritesTitle;
    
}

@end
