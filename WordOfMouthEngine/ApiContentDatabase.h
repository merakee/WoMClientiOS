////
////  SettingsDatabase.h
////  Utilities: DataBase
////
////  Created by Bijit Halder on 2/25/12.
////  Copyright (c) 2012 Indriam Inc. All rights reserved.
////
//
//
//#import <UIKit/UIKit.h>
//#import "SQLiteAPI.h"
//#import "ApiContent.h"
//
///*===========================================
//   User Info DataBase
//   ===========================================*/
//static NSString * kLocalContentDatabaseFileName   =      @"LocalContent_DB.sqlite";
//static const int  kLocalContentDatabaseMaxArraySize =    20;
//
//
//// date formatting strings
//// see here for details:
//// http://unicode.org/reports/tr35/tr35-6.html#Date_Format_Patterns
//
//
//// table name and other constants
//static NSString * kSQLContentTable = @"content_table";
//static NSString * kSQLCategoryTable = @"category_table";
//
//@interface ApiContentDatabase : NSObject {
//    SQLiteAPI                  *sqlite;
//
//
//    NSMutableArray             *dataArrayOut;
//    SQLErrorCode               databaseError;
//}
//
//@property (readonly) BOOL isDatabaseOpen;
//@property (strong, nonatomic)   NSString    *command;
//
//
//#pragma mark - content methods
//- (ApiContent *)getContent;
//- (NSString *)getCategoryTextForId:(int)categoryId;
//
//#pragma mark -  Test Code
//+ (void)test;
//
//@end
//
///*
// CREATE TABLE category_table (
// category_text TEXT DEFAULT ' ' NOT NULL);
// 
// 
// CREATE TABLE content_table (
// content_text TEXT DEFAULT ' ' NOT NULL,
// author_id INTEGER DEFAULT '0' NOT NULL,
// category_id INTEGER DEFAULT '0' NOT NULL,
// total_spread INTEGER DEFAULT '0' NOT NULL,
// kill_count INTEGER DEFAULT '0' NOT NULL,
// spread_count INTEGER DEFAULT '0' NOT NULL,
// comment_count INTEGER DEFAULT '0' NOT NULL
// );
// sqli
//
// */