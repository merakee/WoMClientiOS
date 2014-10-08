//
//  SettingsDatabase.h
//  Utilities: DataBase
//
//  Created by Bijit Halder on 2/25/12.
//  Copyright (c) 2012 Indriam Inc. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "SQLiteAPI.h"
#import "ApiUser.h"

/*===========================================
   User Info DataBase
   ===========================================*/
static NSString *kUDLocalUserInfoDatabaseFileName = @"LocalUserInfo_DB.sqlite";
static int kUDLocalUserInfoDatabaseMaxArraySize = 20;


// date formatting strings
// see here for details:
// http://unicode.org/reports/tr35/tr35-6.html#Date_Format_Patterns


// table name and other constants
static NSString * kUDSQLUserTable  = @"user_table";
static NSString * kUDSQLAnonymousUserTable =  @"anonymous_user_table";

@interface ApiUserDatabase : NSObject {
    SQLiteAPI                  *sqlite;


    NSMutableArray             *dataArrayOut;
    SQLErrorCode               databaseError;
}

@property (readonly) BOOL isDatabaseOpen;
@property (strong, nonatomic)   NSString    *command;


#pragma mark - user info methods
- (ApiUser *)getUser;
- (BOOL)saveUserInfo:(ApiUser *)user;
- (BOOL)deleteUserInfo;
- (ApiUser *)getAnonymousUser;
- (BOOL)saveAnonymousUserInfo:(ApiUser *)user;
- (BOOL)deleteAnonymousUserInfo;

#pragma mark -  Test Code
+ (void)test;

@end

/*
 CREATE TABLE user_table (
 user_id INTEGER NOT NULL,
 user_type_id INTEGER NOT NULL,
 email TEXT NOT NULL,
 authentication_token TEXT,
 signed_in INTEGER NOT NULL
 );
 
 CREATE TABLE user_table (
 user_type_id INTEGER NOT NULL,
 email TEXT NOT NULL,
 authentication_token TEXT,
 signed_in INTEGER NOT NULL
 );
 
 
 */