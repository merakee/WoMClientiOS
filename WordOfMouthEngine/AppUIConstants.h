//
//  AppUIConstants.h
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 2/15/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

//-----------------------------------
// Colors
// HSB color hues
/*
 static const float kAUCHueRed =0.0/360.0;
 static const float kAUCHueScarlet=10.0/360.0;
 static const float kAUCHueVermilion=18.0/360.0;
 static const float kAUCHueInternationalOrange=20.0/360.0;
 static const float kAUCHueDarkOrange=30.0/360.0;
 static const float kAUCHueOrange=40.0/360.0;
 static const float kAUCHueGold=50.0/360.0;
 static const float kAUCHueYellow=60.0/360.0;
 static const float kAUCHueElectricLime=70.0/360.0;
 static const float kAUCHueSpringBud=80.0/360.0;
 static const float kAUCHueChartreuse=90.0/360.0;
 static const float kAUCHueBrightGreen=100.0/360.0;
 static const float kAUCHueHarlequin=110.0/360.0;
 static const float kAUCHueLime=120.0/360.0;
 static const float kAUCHueFreeSpeechGreen=130.0/360.0;
 static const float kAUCHueSpringGreen=140.0/360.0;
 static const float kAUCHueMediumSpringGreen = 160.0/360.0;
 static const float kAUCHueBrightTurquoise=170.0/360.0;
 static const float kAUCHueAqua=180.0/360.0;
 static const float kAUCHueDeepSkyBlue=190.0/360.0;
 static const float kAUCHueDodgerBlue=210.0/360.0;
 static const float kAUCHueNavyBlue=220.0/360.0;
 static const float kAUCHueBlue=230.0/360.0;
 static const float kAUCHueElectricIndigo=260.0/360.0;
 static const float kAUCHueElectricPurple=280.0/360.0;
 static const float kAUCHuePsychedelicPurple=290.0/360.0;
 static const float kAUCHueMagenta=300.0/360.0;
 static const float kAUCHueHotMagenta=310.0/360.0;
 static const float kAUCHueHollywoodCerise=320.0/360.0;
 static const float kAUCHueDeepPink=330.0/360.0;
 static const float kAUCHueTorchRed=340.0/360.0;
 */

// color definitions
//const static float kAUCHuePrimary = 36.0/360.0; // 42, 136, 216
//const static float kAUCHuePrimary = 25.0/360.0; // 42, 136, 216, 25 orange
//const static float kAUCHuePrimary = 200.0/360.0;
//const static float kAUCHueSecondary = 200.0/360.0;// 192 - kAUCHuePrimary+0.5-24.0/360.0;
//const static float kAUCHueTertiary = 136.0/360.0;//kAUCHuePrimary+0.5+45.0/360.0;
//const static float kAUCHueGray = 200.0/360.0;

//const static float kAUCColorPrimary[4] = {kAUCHuePrimary,0.8,1.0,1.0};
const static float kAUCColorPrimary[4] = {176.0/360.0, 0.86, 0.770, 1.0};//{kAUCHuePrimary,0.8,1.0,1.0};
const static float kAUCColorSecondary[4] ={180.0/360.0, 0.71, 39.0, 1.0} ;//{kAUCHueSecondary,0.8,1.0,1.0};
const static float kAUCColorTertiary[4] = {179.0/360.0, 0.94 , 0.91, 1.0};//{kAUCHueTertiary,1.0,0.8,1.0};
const static float kAUCColorQuaternary[4] = {0.0/360.0, 0.0, 0.94, 1.0};
const static float kAUCColorQuinary[4] = {0.0/360.0, 0.0, 0.89, 1.0};

const static float kAUCColorTextPrimary[4] = {176.0/360.0, 0.86, 0.77, 1.0};//{kAUCHuePrimary,0.8,1.0,1.0};
const static float kAUCColorTextSecondary[4] ={0.0/360.0, 0.0, 1.00, 1.0} ;//{kAUCHueSecondary,0.8,1.0,1.0};
const static float kAUCColorTextTertiary[4] = {0.0/360.0, 0.0, 0.80, 1.0};//{kAUCHueTertiary,1.0,0.8,1.0};
const static float kAUCColorTextQuaternary[4] = {0.0/360.0, 0.0, .90, 1.0};
const static float kAUCColorTextQuinary[4] = {0.0/360.0, 0.0, 0.55, 1.0};
const static float kAUCColorTextStroke[4] = {176.0/360.0, 1.0, 0.22, 1.0};


////const static float kAUCColorGray[4] = {kAUCHueGray,0.1,0.9,1.0};
//
//const static float kAUCColorBackground[4] = {kAUCHueGray,0.03,0.95,1.0};
//
//const static float kAUCColorTint[4] = {kAUCHuePrimary,0.0,1.0,1.0};//{kAUCHuePrimary,0.8,1.0,1.0};
//const static float kAUCColorTintSelected[4] = {kAUCHuePrimary,1.0,0.7,1.0};//{kAUCHueSecondary,1.0,1.0,1.0};
//const static float kAUCColorTintUnselected[4] = {kAUCHuePrimary,0.8,1.0,1.0};//{kAUCHuePrimary,0.0,1.0,1.0};
//
//const static float kAUCColorTextPrimary[4] = {kAUCHuePrimary,1.0,0.3,1.0};
//const static float kAUCColorTextPrimaryLight[4] = {kAUCHuePrimary,0.0,1.0,1.0};
//const static float kAUCColorTextSecondary[4] = {kAUCHueSecondary,1.0,1.0,1.0};
//const static float kAUCColorTextTertiary[4] = {kAUCHueTertiary,1.0,1.0,1.0};
//
//const static float kAUCColorContentNews[4] = {200.0/360.0,0.2,1.0,1.0};
//const static float kAUCColorContentSecret[4] = {32.0,0.2,1.0,1.0};
//const static float kAUCColorContentRumor[4] = {280.0/360.0,0.2,1.0,1.0};
//const static float kAUCColorContentLocalInfo[4] = {110.0/360.0,0.2,1.0,1.0};
//const static float kAUCColorContentOther[4] = {0.0/360.0,0.0,1.0,1.0};
//
//const static float kAUCColorScaleFactor=0.2;
//
//// colors - version 1
//const static float kAUCColorBrandTeal[4]={ 176.0/360.0, 0.77,0.76,1.0};
//const static float kAUCColorLightTeal[4]={  179.0/360.0, 0.81 , 0.91,1.0};
//const static float kAUCColorDarkTeal[4]={  180.0/360.0, 0.71, 0.39,1.0};
//const static float kAUCColorTextTeal[4]={  177.0/360.0, 0.86, 0.86, 1.0};
//const static float kAUCColorGray[4]={0.0, 0.0, 0.96, 1.0};

//----------------------------------
// Typography
// Text font family
/*
 NSString *constkAUCFontFamilyPrimary = @"";
 NSString *constkAUCFontFamilySecondary = @"";
 NSString *constkAUCFontFamilyTertiary = @"";
 */
// Custom fonts
/*
 Fira Sans: FiraSans-Bold
 Utility: UtilityBoldCondensed
 */

static NSString * kAUCFontFamilyPrimary = @"Utility";//@"FiraSans-Bold";   //@"HelveticaNeue-Light";
static NSString * kAUCFontFamilySecondary  = @"GillSans";//@"UtilityBoldCondensed";   //@"HelveticaNeue-Light";

//static NSString * kAUCFontFamilyTertiary  = @"GillSans";//@"UtilityBoldCondensed"; //@"HelveticaNeue-Light";

// Text font size
const static CGFloat kAUCFontSizePrimary = 36.0;
const static CGFloat kAUCFontSizeSecondary = 32.0;
const static CGFloat kAUCFontSizeTertiary = 20.0;

const static CGFloat kAUCFontSizePageLabel =57.0;// 114;
const static CGFloat kAUCFontSizeButtonNormal =27.0;// 54;
const static CGFloat kAUCFontSizeButtonLarge =44.0;// 88;
const static CGFloat kAUCFontSizeButtonSmall =18.0;// 32;

const static CGFloat kAUCFontSizeTextField = 24.0;
const static CGFloat kAUCFontSizeContentText = 24.0;//42px;
const static CGFloat kAUCFontSizeComposeText = 22.0;//36px;

// Other style
const static float kAUCRectCornerRadius = 4.0;
const static float kAUCRectBorderWidth = 1.0;

//----------------------------------
// App Images
/*
 NSString *const kAUCCoreFunctionTabbarImageContent  =  @"TabbarIconContent.png";
 NSString *const kAUCCoreFunctionTabbarImageCompose  =  @"TabbarIconNew.png";
 NSString *const kAUCCoreFunctionTabbarImageHistory  =  @"TabbarIconFavorites.png";
 NSString *const kAUCCoreFunctionTabbarImageProfile  =  @"TabbarIconContact.png";
 NSString *const kAUCCoreFunctionTabbarImageSettings =  @"TabbarIconSettings.png";
 */

/*
static NSString * kAUCCoreFunctionTabbarImageContent  =  @"TabbarIconContent.png";
static NSString * kAUCCoreFunctionTabbarImageCompose  =  @"TabbarIconNew.png";
static NSString * kAUCCoreFunctionTabbarImageHistory  =  @"TabbarIconFavorites.png";
static NSString * kAUCCoreFunctionTabbarImageProfile  =  @"TabbarIconContact.png";
static NSString * kAUCCoreFunctionTabbarImageSettings =  @"TabbarIconSettings.png";
*/

// app logo
static NSString * kAUCAppLogoImage  = @"AppIcon.png";
const static float kAUCAppLogoDefaultSize = 64.0;

//----------------------------------
// Enums
// color types
typedef enum {
    kAUCColorTypePrimary=0,
    kAUCColorTypeSecondary,
    kAUCColorTypeTertiary,
    kAUCColorTypeQuaternary,
    kAUCColorTypeQuinary,
    kAUCColorTypeTextPrimary,
    kAUCColorTypeTextSecondary,
    kAUCColorTypeTextTertiary,
    kAUCColorTypeTextQuaternary,
    kAUCColorTypeTextQuinary,
    kAUCColorTypeTextStroke,
} AUCColorType;

//typedef enum {
//    kAUCColorScaleNormal=0,
//    kAUCColorScaleLight,
//    kAUCColorScaleDark,
//    kAUCColorScaleLighter,
//    kAUCColorScaleDarker,
//    kAUCColorScaleLightest,
//    kAUCColorScaleDarkest
//} AUCColorScale;

typedef enum {
    kAUCPriorityTypePrimary=0,
    kAUCPriorityTypeSecondary,
    kAUCPriorityTypeTertiary,
} AUCPriorityType;

//typedef enum {
//    kAUCFontFamilyTypePrimary=0,
//    kAUCFontFamilyTypeSecondary,
//} AUCFontFamilyType;


//// Core function tabbar
//typedef enum {
//    kCFVTabbarIndexContent=0,
//    kCFVTabbarIndexCompose,
//    kCFVTabbarIndexProfile,
//    kCFVTabbarIndexHistory,
//    kCFVTabbarIndexSettings
//} CFVTabbarIndex;

//-----------------
// App constants
const static float kAUCAppContentTimerMax = 60.0;
const static float kAUCAppContentTimerWarning = 5.0;

// Commom images

// SignIn Images
static NSString *kAUCCancelButtonImage =@"close-btn.png";
static NSString *kAUCLogInButtonImage =@"login-nav-btn.png";




