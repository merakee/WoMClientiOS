//
//  CommonUtility.h
//  Untility: General
//
//  Created by Bijit Halder on 5/6/10.
//  Copyright 2010 Indriam Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
//#import <MessageUI/MessageUI.h>
#import "LocalMacros.h"

/* ---------------------------
 Define all constants
 ---------------------------*/
#define kiOSDeviceTagUnknown                                            @"Unknown"
#define kiOSDeviceTagSimulatoriPhone                            @"Sim-32-iPhone"
#define kiOSDeviceTagSimulatoriPad                                      @"Sim-32-iPad"
#define kiOSDeviceTagiPodFirstGeneration                @"iPod-1G"
#define kiOSDeviceTagiPodSecondGeneration               @"iPod-2G"
#define kiOSDeviceTagiPodThirdGeneration                @"iPod-3G"
#define kiOSDeviceTagiPodForthGeneration                @"iPod-4G"
#define kiOSDeviceTagiPhoneFirstGeneration              @"iPhone-1G"
#define kiOSDeviceTagiPhoneThirdGeneration              @"iPhone-3G"
#define kiOSDeviceTagiPhoneThirdGenerationS             @"iPhone-3GS"
#define kiOSDeviceTagiPhoneForthGeneration              @"iPhone-4G"
#define kiOSDeviceTagiPhoneForthGenerationV             @"iPhone-4G(Verizon)"
#define kiOSDeviceTagiPhoneForthGenerationS             @"iPhone-4GS"
#define kiOSDeviceTagiPadFirstGeneration                @"iPad-1G"
#define kiOSDeviceTagiPadSecondGenerationWF             @"iPad-2G(WiFi)"
#define kiOSDeviceTagiPadSecondGenerationGSM            @"iPad-2G(GSM)"
#define kiOSDeviceTagiPadSecondGenerationCDMA           @"iPad-2G(CDMA)"

#define kCUActionSheetViewTag                       347826902 //  a number that won't likely be used as other view tag

/* -------------------------------
 // date formatting strings
 // see here for details:
 // http://unicode.org/reports/tr35/tr35-6.html#Date_Format_Patterns
 -----------------------*/
// This is too long
//#define kDateFormattingStringForDisplay         @"d MMM yyyy, EEEE h:mm a"
//#define kDateFormattingStringForStorage         @"yyyy-MM-dd HH:mm:ss ZZZ"
#define kDateFormatDefault              @"yyyyMMddHHmmss"


@interface CommonUtility : NSObject {
    
}

#pragma mark -  Class methods

#pragma mark -  Device Methods
//+ (NSString *)getAppleDeviceTag;
+ (NSString *)getUUID;
+ (BOOL)isiPad;
+ (float)getDisplayPPI;
+ (float)getDisplayDPI;

#pragma mark -  App Info Methods
+(NSString *)getDeviceModel;
+ (NSString *)getOSVersion;
+ (NSString *)getAppVersion;
+ (NSString *)getAppName;
+ (NSString *)getAppInfo;
+ (NSString *)getAppDeviceAndOSInfo;

#pragma mark -  Display Methods
+ (void)displayActionSheetWithTitle:(NSString *)title
                       cancelButton:(NSString *)cancelButton
                  destructiveButton:(NSString *)destructiveButton
                      customButtons:(NSArray *)buttonTextArray
                           delegate:(id)delegate;
+ (void)displayActionSheetFromTabBarWithTitle:(NSString *)title
                                 cancelButton:(NSString *)cancelButton
                            destructiveButton:(NSString *)destructiveButton
                                customButtons:(NSArray *)buttonTextArray
                                     delegate:(id)delegate;
+ (void)displayAlertViewWithTitle:(NSString *)title
                          message:(NSString *)message
                     cancelButton:(NSString *)cancelButton
                    customButtons:(NSArray *)buttonTextArray
                         delegate:(id)delegate;
+ (void)displayAlertWithTitle:(NSString *)title message:(NSString *)msg delegate:(id)delegate;

#pragma mark -  Math Methods
+ (NSInteger)hexToDec:(NSString *)hexString;

#pragma mark -  String functions
+ (BOOL)isEmptyString:(NSString *)string;
+ (NSString *)trimString:(NSString *)string;

#pragma mark -  Vec functions
+ (float)vecMax:(float *)vec ofSize:(int)aSize maxIndex:(int *)maxInd;
+ (float)vecMin:(float *)vec ofSize:(int)aSize minIndex:(int *)minInd;
+ (float)intvecMax:(int *)vec ofSize:(int)aSize maxIndex:(int *)maxInd;
+ (float)intvecMin:(int *)vec ofSize:(int)aSize minIndex:(int *)minInd;

#pragma mark -  Array functions
+ (float)maxValInArray:(NSArray *)fArray;
+ (float)minValInArray:(NSArray *)fArray;
+ (NSArray *)getArrayWithIntFrom:(NSInteger)lLim to:(NSInteger)uLim;
+ (NSArray *)reverseArray:(NSArray *)array;
+ (NSArray *)attchTag:(NSString *)tag toTextArray:(NSArray *)array;
+(NSArray *)filterArray:(NSArray *)sArray withElementsThatEndsWith:(NSString *)estring;
+ (NSArray *)sortArrayWithString:(NSArray *)sarray;

#pragma mark -  Randomization and vector Methods
+ (void)normalizeArray:(float *)array withSize:(int)size;
+ (int)isNumber:(int)number inArray:(int *)array withSize:(int)arraySize;
+ (int)removeInt:(int)number fromArray:(int *)arrayName withSize:(int)arraySize;
+ (void)randomizeArray:(int *)array withSize:(int)arraySize;
+ (NSArray *)randomizeNSArray:(NSArray *)array withCorrectIndex:(int *)cind;
+ (int)pickRandom:(int)maxInt;
+ (int)pickRandomFrom:(int)minLimit to:(int)maxLimit;
+ (BOOL)findRandomIndices:(int *)array withSize:(int)arraySize forMaxInd:(int)maxInd;
//+(BOOL)generateChoiceVec:(int *)choices ofSize:(int)vecSize withMax:(int)maxVal min:(int)minVal correctVal:(int)correctVal andIndex:(int *)index;
//+(BOOL)generateRandomVec:(int *)choices ofSize:(int)vecSize withMax:(int)maxVal min:(int)minVal excludingVal:(int)correctVal;

#pragma mark -  File Manager Methods with file path
+ (BOOL)createDir:(NSString *)dir;
+ (BOOL)deleteDir:(NSString *)dir;
+ (BOOL)deleteFile:(NSString *)filePath;
+ (BOOL)createEmptyFile:(NSString *)fileName inDir:(NSString *)dir;
+ (BOOL)doesFileExist:(NSString *)path;
+ (BOOL)doesFileExistInResourceDir:(NSString *)fileName;
+ (NSString *)getResourceRootDirectory;
+ (NSString *)getDocumentRootDirectory;
+ (NSArray *)getFileListInDir:(NSString *)path;
+ (NSArray *)getFileListByNameInDir:(NSString *)path;
+ (NSArray *)getFileListByCreationDateInDir:(NSString *)path;
+ (NSArray *)getFileListByMidificationDateInDir:(NSString *)path;

#pragma mark -  File Manager Methods with URL - preffered for iOS 4.0+
+(NSURL *)getURLForDocumentDirectory;
+(NSURL *)getURLForSupportDirectory;
+ (BOOL)createDirectoryInDocumentDirectory:(NSString *)dir;
+ (BOOL)createDirectoryInSupportDirectory:(NSString *)dir;
+(BOOL)createDirectoryWithFullURL:(NSURL *)url;

#pragma mark -  Debug Log File Methods
+ (NSString *)getDebugFilePath;
+ (BOOL)writeToDebugFile:(NSString *)text;
+ (BOOL)appendToDebugFile:(NSString *)text;


#pragma mark -  Legal Info
+ (NSString *)getCopyRightText;
+ (NSString *)getBrandText;

#pragma mark -  Font Related Methods
+ (NSArray *) getAllFontFamilyList;
+ (NSArray *) getAllFontList;
+ (NSString *) getRandomFont;

#pragma mark - Number methods
+(NSString *)wordsForInt:(NSInteger)val;
+(NSString *)wordsForFloat:(float)val;
+(NSString *)wordsForNumber:(NSNumber *)val;

#pragma mark - Size and Shape methods
+ (CGRect)scaleRect:(CGRect)rect byScale:(float)scale;
+ (CGRect)scaleRect:(CGRect)rect byXScale:(float)xscale byYScale:(float)yscale;
+ (CGRect)shrinkRect:(CGRect)rect byXPoints:(float)xpoints yPoints:(float)ypoints;
+ (CGRect)shrinkRect:(CGRect)rect byPoints:(float)points;
+ (CGRect)expandRect:(CGRect)rect byXPoints:(float)xpoints yPoints:(float)ypoints;
+ (CGRect)expandRect:(CGRect)rect byPoints:(float)points;
+ (CGRect)resetAndShrinkRect:(CGRect)rect byPoints:(float)points;
+ (CGRect)resetAndExpandRect:(CGRect)rect byPoints:(float)points;
+ (CGRect)offSetRect:(CGRect)rect byX:(float)xpoints byY:(float)ypoints;
+ (CGRect)offSetRectToOrigin:(CGRect)rect;
+ (CGRect)centerRect:(CGRect)rect toPoint:(CGPoint)point;
+ (CGRect)centerRect:(CGRect)rect toRect:(CGRect)rectt;
+ (void)printRect:(CGRect)rect;
+ (void)printPoint:(CGPoint)point;
+ (CGPoint)flipXYCoordinates:(CGPoint)point;
+ (CGRect)flipRect:(CGRect)rect;
+ (CGRect)getRectOfSize:(CGSize)size;
+ (CGRect)getRectOfSize:(CGSize)size withCenter:(CGPoint)center;
+ (CGRect)getRectOfSize:(CGSize)size centeredToRect:(CGRect)rect;
+ (CGPoint)getCenterOfRect:(CGRect)rect;
+ (CGPoint)getLeftTopPointOfRect:(CGRect)rect;
+ (CGPoint)getRightTopPointOfRect:(CGRect)rect;
+ (CGPoint)getLeftBottomPointOfRect:(CGRect)rect;
+ (CGPoint)getRightBottomPointOfRect:(CGRect)rect;
+ (CGPoint)getPoint:(CGPoint)point withXOffset:(float)xoffset;
+ (CGPoint)getPoint:(CGPoint)point withYOffset:(float)yoffset;
+ (CGPoint)getPoint:(CGPoint)point withXOffset:(float)xoffset andYOffset:(float)yoffset;
+ (float)distanceBetweenPoint:(CGPoint)point1 point:(CGPoint)ponit2;


#pragma mark -  Color Methods
+(void)getRGBValues:(CGFloat *)rgb fromUIColor:(UIColor *)color;
+ (UIColor *)getColorFromHSBAVec:(float *)hsba;
+ (UIColor *)getColorFromHSBACVec:(const float *)hsba;
+ (UIColor *)getColor:(UIColor *)color withOpacity:(float)opacity;
+ (UIColor *)getColor:(UIColor *)color withScaledOpacity:(float)scale;
+ (UIColor *)getColor:(UIColor *)color withBrightness:(float)brightness;
+ (UIColor *)getColor:(UIColor *)color withScaledBrightness:(float)scale;
+ (UIColor *)getColor:(UIColor *)color withSaturation:(float)saturation;
+ (UIColor *)getColor:(UIColor *)color withScaledSaturation:(float)scale;
+ (UIColor *)getColor:(UIColor *)color withBrightness:(float)brightness andSaturation:(float)saturation;
+ (UIColor *)getColor:(UIColor *)color withScaledBrightness:(float)bscale andScaledSaturation:(float)sscale;

+ (UIColor *)getColor:(UIColor *)color withHue:(float)hue;
+ (UIColor *)mixColor:(UIColor *)color1 withColor:(UIColor *)color2;
+ (UIColor *)getColorWithRandomHue;

#pragma mark -  Date and Time Methods
+(NSString *)getStringFromDate:(NSDate *)date withFormatter:(NSString *)format;
+(NSString *)getDateStringForNowWithFormatter:(NSString *)format;
+(NSString *)convertDateString:(NSString *)dateString withFormat:(NSString *)sformat toFormat:(NSString *)tformat;
+(NSDate *)getDateFromString:(NSString *)dateString withFormatter:(NSString *)format;
+(NSDate *)getDateByAddingDays:(float)days toDate:(NSDate *)date;
+(float)numberOfDaysBetweenDate:(NSDate *)startDate andDate:(NSDate *)endDate;
+ (NSDate *)getFirstDateOfTheYearForDate:(NSDate *)date;
+ (NSDate *)getLastDateOfTheYearForDate:(NSDate *)date;
+ (NSDate *)getFirstDateOfTheMonthForDate:(NSDate *)date;
+ (NSDate *)getLastDateOfTheMonthForDate:(NSDate *)date;
+ (NSDate *)getFirstDateOfTheWeekForDate:(NSDate *)date;
+ (NSDate *)getLastDateOfTheWeekForDate:(NSDate *)date;

+ (NSDate *)getFirstDateOfThisYear;
+ (NSDate *)getLastDateOfThisYear;
+ (NSDate *)getFirstDateOfThisMonth;
+ (NSDate *)getLastDateOfThisMonth;
+ (NSDate *)getFirstDateOfThisWeek;
+ (NSDate *)getLastDateOfThisWeek;

+ (NSInteger)getCurrentYear;
+ (NSString *)getFullMonthNameForDate:(NSDate *)date;
+ (NSString *)getMinuteSecStringFromSecs:(float)secs;
+ (NSString *)getTimerTextFromSecs:(float)secs;
+ (NSString *)getTimeInWordForTime:(NSString *)timeString;

#pragma mark - NSError Generation method
+ (NSError *)getErrorWithDomain:(NSString *)domain
                           code:(NSInteger)code
                    description:(NSString *)description
                         reason:(NSString *)reason
                     suggestion:(NSString *)suggestion;


#pragma mark - image methods
+ (NSData *)getJPGImageDataForImage:(UIImage *)image withQuality:(float)compression;
+(UIImage *)getImageFromView:(UIView *)view;

#pragma mark - email methods
//+ (void)addImage:(UIImage *)image asJPEGWithCompression:(float)compression andFileName:(NSString *)fileName toEmailComposer:(MFMailComposeViewController *)composer;
#pragma mark - currency methods
+ (NSString *)convertCentsToCurrencyString:(NSInteger)cents;

#pragma mark - View Utility Method
+ (BOOL)isViewVisible:(UIViewController *)viewController;
+ (void)hideAllSubviews:(UIView *)view;
+ (void)unhideAllSubviews:(UIView *)view;
+ (NSArray *)listAllSubviews:(UIView *)view;

#pragma mark -  Vector print methods
+ (void)printIntVec:(int *)vec ofSize:(int)size;
+ (void)printFloatVec:(float *)vec ofSize:(int)size;

#pragma mark - C Functions
double deg2rad (double degrees);
@end
