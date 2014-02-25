//
//  CommonResourceDefintions.h
//  
//
//  Created by Bijit Halder on 5/10/12.
//  Copyright (c) 2012 Indriam Inc. All rights reserved.
//

/*---------------------------
   Emuns
   -----------------------------*/
// app states
typedef enum {
    kCRDAppStateSignIn,
    kCRDAppStateViewContent
} CRDAppState;


/*---------------------------
   Images
   -----------------------------*/

// tag bar icons
// User
#define kCRDTabBarIconUserProfile     @"ProfileIcon.png"
#define kCRDTabBarIconUserHistory     @"HistoryIcon.png"

/*---------------------------
   Font Names
   -----------------------------*/
#define kCRDGillSansFont                @"GillSans"
#define kCRDGillSansBoldFont            @"GillSans-Bold"
#define kCRDGeorgiaFont                 @"Georgia"
#define kCRDGeorgiaBoldFont             @"Georgia-Bold"
#define kCRDMarkerFeltFont              @"Marker Felt"
#define kCRDChalkboardSEFont            @"ChalkboardSE-Regular"
#define kCRDArialRundedBoldFont         @"ArialRoundedMTBold"
#define kCRDArialBoldFont               @"Arial-BoldMT"
#define kCRDNoteworthyBold              @"Noteworthy-Bold"
#define kCRDEurostile                   @"Eurostile Regular"
#define kCRDEurostileBold               @"Eurostile Bold"
#define kCRDOptimaFont                  @"Optima"
#define kCRDOptimaBoldFont              @"Optima-Bold"

#define kCRDAppFont                     @"Optima"
#define kCRDAppBoldFont                 @"Optima-Bold"
#define kCRDButtonFont                  @"Optima"
#define kCRDKeyboardFont                @"Optima"
#define kCRDNavbarButtonFont            @"Optima"
#define kCRDBarButtonFont               @"Optima-Bold"

static const float kCRDTextMinFontSize =10.0;


/*---------------------------
   Strings
   -----------------------------*/
// date formatting strings
// see here for details:
// http://unicode.org/reports/tr35/tr35-6.html#Date_Format_Patterns

// This is too long
//#define kDateFormattingStringForDisplay         @"d MMM yyyy, EEEE h:mm a"
//#define kDateFormattingStringForDisplay         @"d MMM yyyy, h:mm a"
//#define kDateFormattingStringForStorage         @"yyyy-MM-dd HH:mm:ss ZZZ"

#define kDateFormattingStringForDisplayFullTimeAndDate         @"HH:mm:ss d MMM yyyy"
#define kDateFormattingStringForDisplayLPS         @"MMM d"
#define kDateFormatForStorageDateOnly            @"yyyyMMdd"
#define kDateFormatForStorageDateAndTime         @"yyyyMMddHHmmss"
#define kDateFormatForScoreGraph                @"MM/dd"

#define kNotAvilableString    @"na"
/*---------------------------
   Timing
   -----------------------------*/
static const float kCRDPerformSelectorDelay =0.25;

/*---------------------------
   Web Sites
   -----------------------------*/
#define kWoMSiteURL @"http://www.freelogue.com"
#define kWoMSiteTitle @"Word of Mouth Engine"

/*---------------------------
   Email Support
   -----------------------------*/
#define kAppSupportEmailAddress @"appsupport@indriam.com"
#define kAppSupportEmailSubjectFeedback @"User Feedback"
#define kAppSupportEmailSubjectSuggestions @"User Suggestions"

#define kAppSupportEmailBodyFeedback @"Please send us your question, suggestion, comment, or request for features. We always appreciate your feedback. Thank you.\n-------------------------------\n\n"
#define kRiSupportEmailBodySuggestions @"Please tell us what we can improve\n-------------------------------\n\n"


