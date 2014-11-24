////
////  ContentManager.h
////  WordOfMouthEngine
////
////  Created by Bijit Halder on 2/13/14.
////  Copyright (c) 2014 Bijit Halder. All rights reserved.
////
//
//#import <Foundation/Foundation.h>
//#import "ApiContent.h"
//#import "ApiContentDatabase.h"
//#import "AppConstants.h"
//
//static NSString *  kAppErrorDomainContent = @"ContentErrorDomain";
//
//typedef enum {
//    kContentErrorNone=0,
//    kContentErrorPostEmpty,
//    kContentErrorPostTooShort,
//    kContentErrorPostTooLong,
//    kContentErrorInvalidCategory,
//    kContentErrorPostInvalid,
//} ACMContentErrorCode;
//
//static const int kContentPostLengthMin = 5;
//static const int kContentPostLengthMax = 500;
//
//
//@protocol ContentManagerDelegate <NSObject>
//@required
//-(void)contentPostedSuccessfully;
//-(void)contentPostFailedWithError:(NSError *)error;
//@optional
//
//@end
//
//
//@interface ContentManagerOLd : NSObject{
//    ApiContentDatabase  *localContentDatabase;
//}
//
//@property (assign, nonatomic) id <ContentManagerDelegate>  delegate;
//
//#pragma mark -  instance Methods
//- (void)postContent:(ApiContent *)ci;
//
//#pragma mark - Content methods
//- (ApiContent *)getContent;
//+ (void)killContent:(ApiContent *)ci;
//+ (void)spreadContent:(ApiContent *)ci;
//
//#pragma mark - Utility methods
//+ (NSArray *)getActiveCategoryList;
//+ (NSString *)getCategoryTextForId:(kAPIContentCategory)category;
//+ (kAPIContentCategory)getCategoryIDForText:(NSString *)categoryText;
//@end
