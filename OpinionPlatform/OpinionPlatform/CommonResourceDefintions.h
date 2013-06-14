//
//  CommonResourceDefintions.h
//  MathSchool
//
//  Created by Bijit Halder on 5/10/12.
//  Copyright (c) 2012 Indriam Inc. All rights reserved.
//

/*---------------------------
   Emuns
   -----------------------------*/
// app states
typedef enum {
    kCRDAppStateHomeView,
    kCRDAppStatePracticeView,
    kCRDAppStateAdminView,
    kCRDAppStateStudentAdminView
} CRDAppState;


// grades
typedef enum {
    kCRDGradeK=0,
    kCRDGrade1=1,
    kCRDGrade2=2,
    kCRDGrade3=3,
    kCRDGrade4=4,
    kCRDGrade5=5,
    kCRDGrade6=6,
    kCRDGrade7=7,
    kCRDGrade8=8,
    kCRDGrade9=9,
    kCRDGrade10=10

} CRDGrade;


// lesson plans
typedef enum {
    kCRDCoursePlanTypeManual=0,
    kCRDCoursePlanTypeAuto,
    kCRDCoursePlanTypeScheduled
} CRDCoursePlanType;

typedef enum {
    kCRDCoursePlanScheduledTypeDaily=0,
    kCRDCoursePlanScheduledTypeWeekly,
    kCRDCoursePlanScheduledTypeMonthly
} CRDCoursePlanScheduledType;


typedef enum {
    kCRDTimeIntervalTypeToday=0,
    kCRDTimeIntervalTypeThisWeek,
    kCRDTimeIntervalTypeThisMonth,
    kCRDTimeIntervalTypeThisYear,

} CRDTimeIntervalType;

/*---------------------------
   Images
   -----------------------------*/
// textures
#define kCRDTextureMetal      @"MetalTexture.png"
#define kCRDTextureBubble      @"BubbleTexture.png"

// tag bar icons
// admin
#define kCRDTabBarIconAdminCurriculum      @"CurriculumIcon.png"
#define kCRDTabBarIconAdminCoursePlan      @"CoursePlanIcon.png"
#define kCRDTabBarIconAdminScore           @"ScoreIcon.png"
#define kCRDTabBarIconAdminInfo            @"InfoIcon.png"
#define kCRDTabBarIconAdminStudentsList    @"StudentListIcon.png"
#define kCRDTabBarIconAdminRewards         @"RewardIcon.png"
#define kCRDTabBarIconAdminLPPrint         @"LessonPlanIcon.png"
// student admin
#define kCRDTabBarIconStudentAdminProfile         @"ProfileIcon.png"
#define kCRDTabBarIconStudentAdminSummary         @"SummaryIcon.png"
#define kCRDTabBarIconStudentAdminScore           @"ScoreIcon.png"
#define kCRDTabBarIconStudentAdminAchievements    @"RewardIcon.png"
// general
#define kCRDIconRedo                        @"RedoIcon.png"
#define kCRDIconSettings                    @"SettingsIcon.png"

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
#define kCommonCoreURL @"http://www.corestandards.org"
#define kCommonCoreSiteTitle @"Common Core"
#define kMathCoreURL @"http://www.mobkoo.com"
#define kMathCoreSiteTitle @"Mobkoo Products"

/*---------------------------
   Email Support
   -----------------------------*/
#define kAppSupportEmailAddress @"appsupport@indriam.com"
#define kAppSupportEmailSubjectFeedback @"User Feedback"
#define kAppSupportEmailSubjectSuggestions @"User Suggestions"

#define kAppSupportEmailBodyFeedback @"Please send us your question, suggestion, comment, or request for features. We always appreciate your feedback. Thank you.\n-------------------------------\n\n"
#define kRiSupportEmailBodySuggestions @"Please tell us what we can improve\n-------------------------------\n\n"


