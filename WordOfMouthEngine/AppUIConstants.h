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
const static float kAUCColorSecondary[4] ={180.0/360.0, 0.71, 0.39, 1.0} ;//{kAUCHueSecondary,0.8,1.0,1.0};
const static float kAUCColorTertiary[4] = {179.0/360.0, 0.94 , 0.91, 1.0};//{kAUCHueTertiary,1.0,0.8,1.0};
const static float kAUCColorQuaternary[4] = {0.0/360.0, 0.0, 0.94, 1.0};
const static float kAUCColorQuinary[4] = {0.0/360.0, 0.0, 0.89, 1.0};

const static float kAUCColorLoginBackground[4] = {176.0/360.0, 0.86, 0.84, 1.0};
const static float kAUCColorLoginTextField[4] = {176.0/360.0, 0.86, 0.53, 1.0};
const static float kAUCColorLoginField[4] = {176.0/360.0, 0.86, 0.77, 1.0};
const static float kAUCColorLineView[4] = {176.0/360.0, 0.86, 0.53, 1.0};

const static float kAUCColorTextPrimary[4] = {176.0/360.0, 0.86, 0.77, 1.0};//{kAUCHuePrimary,0.8,1.0,1.0};
const static float kAUCColorTextSecondary[4] ={0.0/360.0, 0.0, 1.00, 1.0} ;//{kAUCHueSecondary,0.8,1.0,1.0};
const static float kAUCColorTextTertiary[4] = {0.0/360.0, 0.0, 0.80, 1.0};//{kAUCHueTertiary,1.0,0.8,1.0};
const static float kAUCColorTextQuaternary[4] = {0.0/360.0, 0.0, .90, 1.0};
const static float kAUCColorTextQuinary[4] = {0.0/360.0, 0.0, 0.55, 1.0};
const static float kAUCColorTextStroke[4] = {176.0/360.0, 1.0, 0.22, 1.0};

const static float kAUCPlaceHolderColor[4] = {176.0/360.0, 0.0, 0.57, 1.0};

const static float kAUTextColorDefault[4] = {0.0/360.0, 0.0 , 0.24, 0};
const static float kAUTextColor1[4] = {146.0/360.0, 0.06, 1.0, 1.0};
const static float kAUTextColor2[4] = {32.0/360.0, 0.32 , 0.16, 1.0};
const static float kAUTextColor3[4] = {325.0/360.0, 0.96, 0.11, 1.0};
const static float kAUTextColor4[4] = {180.0/360.0, .07, 0.12, 1.0};

const static float kAUShadowColorDefault[4] = {0.0/360.0, 0.0 , 0.24, 1};
const static float kAUShadowColor1[4] = {0.0/360.0, 0.0 , 0.44, 1};

const static float kAUTextFieldColor[4] = {0.0/360.0, 0.0, 0.59, 1};

const static float kAUBackgroundColor1[4] = {156.0/360.0, .21, 1.0, 1.0};
const static float kAUBackgroundColor2[4] = {21.0/360.0, .59, .99, 1.0};
const static float kAUBackgroundColor3[4] = {68.0/360.0, .03, 1.0, 1.0};
const static float kAUBackgroundColor4[4] = {49.0/360.0, .80, 1.00, 1.0};
const static float kAUBackgroundColor5[4] = {200.0/360.0, .08, 1.0, 1.0};
const static float kAUBackgroundColor6[4] = {347.0/360.0, 0.62, .99, 1.0};
const static float kAUBackgroundColor7[4] = {182.0/360.0, .97, 1.0, 1.0};
const static float kAUBackgroundColor8[4] = {235.0/360.0, .28, .99, 1.0};

const static float kAUTextStrokeColor[4] = {32.0/360.0, 0.32, 0.16, 1.0};

const static float kAUCommentTextColor[4] = {0/360.0, 0, 0.90, 1.0};

const static float kAUContentBackgroundColor[4] = {330.0/360.0, 0.01, 0.94, 1.0};

// Compose View colors
const static float kAUCBorderColor[4] = {176.0/360.0, 0.86, 0.84, 1.0};

// Settings colors
const static float kAUSSettingColor[4] = {179.0/360.0, 0.98, 0.36, 1.0};

//const static float kAUCColorGray[4] = {kAUCHueGray,0.1,0.9,1.0};
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
static NSString * kAUCFontFamilyThird = @"GillSansLight";
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
const static CGFloat kAUCFontSizeComposeText = 24.0;//36px;
const static CGFloat kAUCFontSizePlaceholder1 = 26.0;
const static CGFloat kAUCFontSizePlaceholder2 = 20.0;

const static CGFloat kAUCFontSizeDescriptionText = 16.0;
const static CGFloat kAUCFontSizeLoginText = 16.0;
const static CGFloat kAUCFontSizeRepliesText = 16.0;

const static CGFloat kAUCFontSizeLikeLabel = 12.0;

const static CGFloat kAUCFontSizeCommentCount = 12.0;
const static CGFloat kAUCFontSizeSpreadCount = 14.0;
const static CGFloat kAUCFontSizeNicknameText = 16.0;

const static CGFloat kAUPFontSizeNicknameText = 15.0;
const static CGFloat kAUPFontSizeLikeCountText = 10.0;
const static CGFloat kAUPFontSizeBioText = 12.0;
const static CGFloat kAUPFontSizeLocationText = 11.0;
const static CGFloat kAUPFontSizeSocialText = 11.0;
// Other style
const static float kAUCRectCornerRadius = 4.0;
const static float kAUCRectBorderWidth = 1.0;

// Apple Default
const static float kAUAppleTitleDefault = 20.0f;
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

// Content View Images
static NSString *kAUCSpreadButtonImage =@"spread-btn.png";
static NSString *kAUCSpreadButtonFilledImage= @"spread-btn-full.png";
static NSString *kAUCKillButtonImage =@"kill-btn.png";
static NSString *kAUCKillButtonFilledImage= @"kill-btn-full.png";
static NSString *kAUCComposeButtonImage =@"compose.png";
static NSString *kAUCSignOutButtonImage =@"logout-menu.png";
static NSString *kAUCLogInMenuButtonImage =@"signup-menu.png";
static NSString *kAUCPageLogoImage =@"logo-nav.png";
static NSString *kAUCReplyButtonImage =@"reply-btn.png";
static NSString *kAUCReportButtonImage =@"flag-btn.png";
static NSString *kAUCSettingsButtonImage =@"profile-btn.png";
static NSString *kAUCContentLoadingImage =@"content-loading";
static NSString *kAUCAlertOnImage = @"alert-on.png";
static NSString *kAUCSpreadIcon = @"spread-icon.png";

// SignIn Images
static NSString *kAUCCancelButtonImage =@"close-btn.png";
static NSString *kAUCLogInButtonImage =@"signedup.png";
static NSString *kAUCSignupButtonImage =@"signup.png";
static NSString *kAUCNextButtonImage = @"next-a.png";
static NSString *kAUCTermsButtonImage =@"Privacy-policy-Terms.png";
static NSString *kAUCForgotPasswordImage =@"forgot password.png";
static NSString *kAUCGoButtonImage = @"go.png";
static NSString *kAUCLoginTitleImage = @"login-header.png";
static NSString *kAUCSignupTitleImage = @"signup-header";
static NSString *kAUCFullExperienceImage = @"experience.png";
static NSString *kAUCDoneButtonImage = @"done-a.png";

// Compose Images
static NSString *kAUCPostButtonImage =@"post-active-btn.png";
static NSString *kAUCPostInactiveButtonImage =@"post-inactive-btn.png";
static NSString *kAUCCameraOptionsButtonImage =@"cam-btn.png";
static NSString *kAUCComposeSpreadButtonImage = @"spread-a.png";
static NSString *kAUCDeleteImageButtonImage = @"delete-img-btn.png";
static NSString *kAUCBackButtonImage =@"back-btn.png";
static NSString *kAUCKeyboardButtonImage =@"keyboard-icon.png";
static NSString *kAUCKeyboardActiveButtonImage = @"keyboard-active-icon.png";
static NSString *kAUCTextColorButtonImage = @"txt-color.png";
static NSString *kAUCTextColorActiveButtonImage = @"text-color-icon-active.png";
static NSString *kAUCCheckIconButtonImage = @"check-icon.png";
static NSString *kAUCClearIconButtonImage = @"clear-icon.png";
static NSString *kAUCPostSuccessImage = @"spreadsuccess.png";
static NSString *kAUCPostFailureImage = @"error-spreading.png";
static NSString *kAUCComposeBackgroundImage = @"compose-empty-bg.png";
static NSString *kAUCCameraButtonImage = @"camera-sm-btn.png";
static NSString *kAUCSystemImageButtonImage = @"bg-bt.png";
static NSString *kAUCFilterButtonImage = @"filter-btn.png";
static NSString *kAUCShareButtonImage =@"share.png";

// Comment Images
static NSString *kAURSendButtonImage = @"send-btn.png";
static NSString *kAUREmptyLikeImage = @"reply-heart-empty.png";
static NSString *kAURFilledLikeImage = @"reply-heart-full.png";
static NSString *kAURCloseButtonImage = @"close-btn.png";

// Profile Images
static NSString *kAUPSettingsButtonImage = @"settings.png";
static NSString *kAUPSocialTitleImage = @"Findme-label.png";
static NSString *kAUPLikesCountIcon = @"heart-count-icon.png";
static NSString *kAUPHistroyLabel = @"history-label.png";
static NSString *kAUPInstagramImage = @"insta-icon.png";
static NSString *kAUPSnapchatImage = @"snap-icon.png";
static NSString *kAUPTumblrImage = @"tumblr-icon.png";
static NSString *kAUPTwitterImage = @"twitter-icon.png";
