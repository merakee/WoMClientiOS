//
//  SQLiteAPI.h
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 3/7/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

typedef enum {
    kSQLErrorCodeNone=0,
    kSQLErrorCodeCannotOpenDatabaseFile,
    kSQLErrorCodeCannotOpenDatabase,
    kSQLErrorCodeCannotCloseDatabase,
    kSQLErrorCodeCannotPrepareStatement,
    kSQLErrorCodeCannotCompleteStatement,
    kSQLErrorCodeCannotInsertData,
    kSQLErrorCodeCannotInsertEmptyData,
    kSQLErrorCodeCannotUpdateData,
    kSQLErrorCodeCannotDeleteData,
    kSQLErrorCodeDatabaseNotOpen

} SQLErrorCode;

typedef enum {
    kSQLDatabaseFileTypeResource=0,         // For database in the resource directory: stored files
    kSQLDatabaseFileTypeDocument,    // For database in the document directory: files created by the application
} SQLDatabaseFileType;

@interface SQLiteAPI : NSObject {
    NSMutableArray             *dataArrayOut;
    // local variables
    SQLErrorCode                databaseError;
    NSString                   *filename;
    int filetype;
    BOOL databaseOpen;
    sqlite3 *sqlite_connection;
}

# pragma Init mMethods
- (id)initWithFileName:(NSString *)name andType:(SQLDatabaseFileType)type error:(SQLErrorCode *)errorCode;

#pragma mark -  DataBase Methods
- (int)getLastRowId:(NSString *)tableName;
//- (SQLErrorCode)insertData:(NSArray *)dataArrayIn inTable:(NSString *)tableName;
- (SQLErrorCode)deleteDataInTable:(NSString *)tableName atRow:(int)rowId;
//- (SQLErrorCode)updateColumn:(NSString *)columnName withValue:(NSString *)columeValue inTable:(NSString *)tableName atRow:(int)rowId;
- (NSInteger)getTableSize:(NSString *)tableName;
- (SQLErrorCode)executeCommand:(NSString *)commandString;
- (NSArray *)executeGetCommand:(NSString *)commandString withDataArraySize:(int)dataArraySize;

#pragma mark -  Core DataBase Methods
- (BOOL)openDataBase;
- (BOOL)closeDataBase;
- (NSString *)dataBaseFilePath;

@end

