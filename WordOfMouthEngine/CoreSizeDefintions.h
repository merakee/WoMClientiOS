//
//  CoreSizeDefintions.h
//  Untility: General
//
//  Created by Bijit Halder on 4/11/14.
//  Copyright (c) 2014 Indriam Inc. All rights reserved.
//

/*-------------
   Define all constants
   --------------*/

// source http://ivomynttinen.com/blog/the-ios-7-design-cheat-sheet/

//----------------------------------------------------------
// Screen sizes
static const CGSize kCSScreenSizePortraitiPhone5 = {640,1136};
static const CGSize kCSScreenSizePortraitiPhone4 = {640,960};
static const CGSize kCSScreenSizePortraitiPhone = {320,480};
static const CGSize kCSScreenSizePortraitiPadRetina = {1536,2048};
static const CGSize kCSScreenSizePortraitiPadMini = {768,1024};
static const CGSize kCSScreenSizePortraitiPadMinRetina = {1536,2048};
static const CGSize kCSScreenSizePortraitiPad = {768,1024};

// Display resolution in PPI
static const int kCSScreenResolutioniPhone5 = 326;
static const int kCSScreenResolutioniPhone4 = 326;
static const int kCSScreenResolutioniPhone = 163;
static const int kCSScreenResolutioniPadRetina = 264;
static const int kCSScreenResolutioniPadMini = 163;
static const int kCSScreenResolutioniPadMinRetina = 326;
static const int kCSScreenResolutioniPad = 132;

// Appp icon sizes
static const CGSize kCSAppIconSizeiPhone5 = {120,120};
static const CGSize kCSAppIconSizeiPhone4 = {120,120};
static const CGSize kCSAppIconSizeiPadRetina = {152,152};
static const CGSize kCSAppIconSizeiPadMini = {76,76};
static const CGSize kCSAppIconSizeiPad = {76,76};

static const CGSize kCSAppStoreIconSizeiPhone5 = {1024,1024};
static const CGSize kCSAppStoreIconSizeiPhone4 = {1024,1024};
static const CGSize kCSAppStoreIconSizeiPadRetina = {1024,1024};
static const CGSize kCSAppStoreIconSizeiPadMini = {512,512};
static const CGSize kCSAppStoreIconSizeiPad = {512,512};

static const CGSize kCSSpotlightIconSizeiPhone5 = {80,80};
static const CGSize kCSSpotlightIconSizeiPhone4 = {80,80};
static const CGSize kCSSpotlightIconSizeiPadRetina = {80,80};
static const CGSize kCSSpotlightIconSizeiPadMini = {40,40};
static const CGSize kCSSpotlightIconSizeiPad = {40,40};

static const CGSize kCSSettingsIconSizeiPhone5 = {58,58};
static const CGSize kCSSettingsIconSizeiPhone4 = {58,58};
static const CGSize kCSSettingsIconSizeiPadRetina = {58,58};
static const CGSize kCSSettingsIconSizeiPadMini = {29,29};
static const CGSize kCSSettingsIconSizeiPad = {29,29};

// bar heights
static const int kCSStatusBarHeightiPhone5 = 40;
static const int kCSStatusBarHeightiPhone4 = 40;
static const int kCSStatusBarHeightiPadRetina = 40;
static const int kCSStatusBarHeightiPadMini = 20;
static const int kCSStatusBarHeightiPad = 20;

static const int kCSNavigationBarHeightiPhone5 = 88;
static const int kCSNavigationBarHeightiPhone4 = 88;
static const int kCSNavigationBarHeightiPhone5Landscape = 64;
static const int kCSNavigationBarHeightiPhone4Landscape = 64;
static const int kCSNavigationBarHeightiPadRetina = 88;
static const int kCSNavigationBarHeightiPadMini = 44;
static const int kCSNavigationBarHeightiPad = 44;

static const int kCSTabBarHeightiPhone5 = 98;
static const int kCSTabBarHeightiPhone4 = 98;
static const int kCSTabBarHeightiPadRetina = 112;
static const int kCSTabBarHeightiPadMini = 56;
static const int kCSTabBarHeightiPad = 56;

// bar icon sizes
/*
 
 Description
 
 
 Size for iPhone 5 and iPod touch (high resolution)
 
 
 Size for iPhone and iPod touch (high resolution)
 
 
 Size for iPad and iPad mini (high resolution)
 
 
 Size for iPad 2 and iPad mini (standard resolution)
 
 Toolbar and navigation bar icon (optional)
 
 
 About 44 x 44
 
 
 About 44 x 44
 
 
 About 44 x 44
 
 
 About 22 x 22
 
 Tab bar icon (optional)
 
 
 About 50 x 50 (maximum: 96 x 64)
 
 
 About 50 x 50 (maximum: 96 x 64)
 
 
 About 50 x 50 (maximum: 96 x 64)
 
 
 About 25 x 25 (maximum: 48 x 32)
 
 */

// font sizes
/*
Label Type 	Default Font Size 	Default Font Weight
Navigation Bar Title 	34 px 	Medium
Regular Buttons 	34 px 	Light
Table Header 	34 px 	Light
Table Label 	28 px 	Regular
Tab Bar Icon Labels 	20 px 	Regular
*/




//iPhone Nav bar buttons:
//Portrait: 30 pixels high
//Landscape: 24 pixels high
static const float kCSiPhoneNavBarButtonHeightPortrait = 30;
static const float kCSiPhoneNavBarButtonHeightLandscape = 24;

//iPhone Nav bar button icons: about 20×20 pixels (when in Landscape mode, it shrinks the 20×20 pixel icon)

//iPhone Toolbar: 44 pixels high (does not change)
static const float kCSiPhoneToolBarHeight = 44;

//iPhone Toolbar button: 30 pixels high (does not change)
static const float kCSiPhoneToolBarButtonHeight = 30;

//iPhone Toolbar button icon: about 20×20 pixels
static const CGSize kCSiPhoneToolBarButtonIconSize = {20,20};

//iPhone Tab Bar: 49 pixels high (does not change)
static const float kCSiPhoneTapBarHeight = 49;

//iPhone Tab Bar icon: about 30×30 pixels
static const CGSize kCSiPhoneTapBarIconSize = {30,30};

//Portrait Keyboard height      216 pts
//Landscape Keyboard height     162 pts
static const float kCSiPhoneKeyboardHeightPortrait = 216;
static const float kCSiPhoneKeyboardHeightLandscape = 162;


