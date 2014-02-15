//
//  CoreSizeDefintions.h
//  Untility: General
//
//  Created by Bijit Halder on 4/11/12.
//  Copyright (c) 2012 Indriam Inc. All rights reserved.
//

/*-------------
   Define all constants
   --------------*/
// All pixel dimensions include highlight or stroke effects.  For example, a 30-pixel high button is actually a 29-pixel high button with a 1-pixel highlight on the bottom.

//----------------------------------------------------------
//iPhone screen size:
//Portrait 320×480 pixels
// Landscape 480×320 pixels
static const CGRect kCSiPhoneScreenRectPortrait ={0.0,0.0,320,480};
static const CGRect kCSiPhoneScreenRectLandscape ={0.0,0.0,480,320};
static const CGRect kCSiPhone5ScreenRectPortrait ={0.0,0.0,320,568};
static const CGRect kCSiPhone5ScreenRectLandscape ={0.0,0.0,568,320};

//Status Bar	20 pts
static const float kCSiPhoneStatusBarHeight= 20;

//iPhone Nav bar:
//Portrait: 44 pixels high
//Landscape: 32 pixels high
static const float kCSiPhoneNavBarHeightPortrait = 44;
static const float kCSiPhoneNavBarHeightLandscape = 32;

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

//----------------------------------------------------------
//iPad Pixel Dimensions
//iPad screen size:
//Portrait 768×1024 pixels
//Landscape 1024×768
static const CGRect kCSiPadScreenRectPortrait ={0.0,0.0,768,1024};
static const CGRect kCSiPadScreenRectLandscape ={0.0,0.0,1024,768};

//Status Bar	20 pts
static const float kCSiPadStatusBarHeight= 20;

//iPad Navigation Bar and Tool Bars: 44 pixels high
static const float kCSiPadNavBarHeight= 44;
static const float kCSiPadToolBarHeight= 44;

//iPad Nav Bar and Tool Bar buttons: 30 pixels high
static const float kCSiPadNavBarButtonHeight= 30;
static const float kCSiPadToolBarButtonHeight= 30;

//iPad Nav Bar and Tool Bar button icons: about 20×20 pixels
static const CGSize kCSiPadNavBarIconSize = {30,30};
static const CGSize kCSiPadToolBarIconSize = {30,30};

//iPad Tab Bar: 49 pixels high
static const float kCSiPadTabBarHeight= 49;

//iPad Tab Bar icons: about 30×30 pixels
static const CGSize kCSiPadTapBarIconSize = {30,30};

//iPad List View: 320 pixels wide.  This is because when the same app is on the iPhone, the 320 pixel width fits iPhone Portrait mode perfectly.

//Portrait Keyboard Height      264px
//Landscape Keyboard Height     352px
static const float kCSiPadKeyboardHeightPortrait = 264;
static const float kCSiPadKeyboardHeightLandscape = 352;

//---------------------------------------------------------
static const float kCSScaleLongsideiPadToiPhone =0.46875;
static const float kCSScaleShortsideiPhoneToiPad =2.4;
