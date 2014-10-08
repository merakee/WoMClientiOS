//
//  SQLiteAPI.m
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 3/7/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import "SQLiteAPI.h"

@implementation SQLiteAPI

// Static variables for compiled SQL queries. This implementation choice is to be able to share a one time
// compilation of each query across all instances of the class. Each time a query is used, variables may be bound
// to it, it will be "stepped", and then reset for the next usage. When the application begins to terminate,
// a class method will be invoked to "finalize" (delete) the compiled queries - this must happen before the database
// can be closed.
static sqlite3_stmt *sql_statement =nil;
static sqlite3_stmt *get_statement =nil;
static sqlite3_stmt *insert_statement =nil;
static sqlite3_stmt *update_statement =nil;
static sqlite3_stmt *delete_statement =nil;

#pragma mark -  Init Methods
- (id)initWithFileName:(NSString *)name andType:(SQLDatabaseFileType)type error:(SQLErrorCode *)errorCode {
    if(self = [super init]) {
        // initialization code
        dataArrayOut =[[NSMutableArray alloc] init];
        databaseError = kSQLErrorCodeNone;
        
        // file name and type
        filename = [[NSString alloc] initWithString:name];
        filetype = type;
        
        // open database
        databaseOpen = [self openDataBase];
        *errorCode = (databaseOpen==YES) ? kSQLErrorCodeNone : kSQLErrorCodeCannotOpenDatabase;
    }
    
    return self;
}

- (void) dealloc {
    // close database
    if(databaseOpen==YES) {
        [self closeDataBase];
    }
}

#pragma mark -  DataBase Methods
- (NSArray *)executeGetCommand:(NSString *)commandString withDataArraySize:(int)dataArraySize {
    databaseError = kSQLErrorCodeNone;
    NSString *tempTextDB;
    
    // release all text
    [dataArrayOut removeAllObjects];
    
    // open data base
    if(databaseOpen==YES) {
        // crate sql statement
        const char *sqlquery = [commandString cStringUsingEncoding:NSUTF8StringEncoding];
        
        if (sqlite3_prepare_v2(sqlite_connection, sqlquery, -1, &sql_statement, NULL) == SQLITE_OK) {
            while (sqlite3_step(sql_statement) == SQLITE_ROW) {
                if(sqlite3_column_count(sql_statement)==dataArraySize) {
                    for(int ind=0; ind<dataArraySize; ind++) {
                        // get Data
                        if(sqlite3_column_type(sql_statement,ind)!=5) {
                            tempTextDB =[[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(sql_statement,ind)];
                            [dataArrayOut insertObject:tempTextDB atIndex:ind];
                            //[tempTextDB release];
                        }
                        else{
                            [dataArrayOut insertObject:[NSNull null] atIndex:ind];
                        }
                    }
                }
            }             // end of if(sqlite3_step)
        }         // end of if(sqlite3_prepare_v2)
        
        // close data base
        sqlite3_finalize(sql_statement);
    }    // end of if(databaseOpen==YES)
    
    // NSPLog(@"============= Data array============\n%@",dataArrayOut);
    return dataArrayOut;
}

- (SQLErrorCode)executeCommand:(NSString *)commandString {
    // open data base
    if(databaseOpen==YES) {
        // crate sql statement
        const char *sqlquery = [commandString cStringUsingEncoding:NSUTF8StringEncoding];
        
        if (sqlite3_prepare_v2(sqlite_connection, sqlquery, -1, &sql_statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(sql_statement) == SQLITE_DONE) {
                databaseError = kSQLErrorCodeNone;
            }             // end of if(sqlite3_step)
            else{
                databaseError = kSQLErrorCodeCannotCompleteStatement;                 // cannot complete statement
            }
        }         // end of if(sqlite3_prepare_v2)
        else{
            databaseError =   kSQLErrorCodeCannotPrepareStatement;             // cannot prepare statment
        }
        // close data base
        sqlite3_finalize(sql_statement);
    }    // end of if(databaseOpen==YES)
    
    return databaseError;
}


- (SQLErrorCode)insertData:(NSArray *)dataArrayIn inTable:(NSString *)tableName {
    if(dataArrayIn==nil || [dataArrayIn count]==0){
        return kSQLErrorCodeCannotInsertEmptyData;
    }
    
    databaseError = kSQLErrorCodeNone;
    // open data base
    if(databaseOpen==YES) {
        
        // crate table statement for different tables names
        NSMutableString *tempString =[[NSMutableString alloc] initWithFormat:@"INSERT INTO %@ values('%@'", tableName,dataArrayIn[0]];
        for (int ind=1;ind<[dataArrayIn count];ind++){
            [tempString appendString:[NSString stringWithFormat:@", '%@'",dataArrayIn[ind]]];
        }
        [tempString appendString:@")"];
        
        // crate table statement
        const char *sqlquery = [(NSString *)tempString cStringUsingEncoding:NSUTF8StringEncoding];
        //[tempString release];
        
        if (sqlite3_prepare_v2(sqlite_connection, sqlquery, -1, &insert_statement, NULL) == SQLITE_OK) {
            // set all the values from  data array
            //for(int ind=0;ind<kSQLiteAPIArraySize;ind++){
            //	sqlite3_bind_text(insert_statement,ind+1,(const char *) [[dataArrayIn objectAtIndex:ind] UTF8String],-1,SQLITE_TRANSIENT);
            //}
            if (sqlite3_step(insert_statement) == SQLITE_DONE) {
                databaseError = kSQLErrorCodeNone;
            }
            else {
                databaseError = kSQLErrorCodeCannotInsertData;                // cannot insert
                                                                              // NSPLog(@"Can't insert data in datase: error %s",sqlite3_errmsg(sqlite_connection));
            }
        }
        else{
            databaseError = kSQLErrorCodeCannotPrepareStatement;             // cannot prepare statment
        }
        
        sqlite3_finalize(insert_statement);
    }    // end of if(databaseOpen==YES)
    return databaseError;
}

- (SQLErrorCode)updateColumn:(NSString *)columnName withValue:(NSString *)columnValue inTable:(NSString *)tableName atRow:(int)rowId {
    databaseError = kSQLErrorCodeNone;
    // open data base
    if(databaseOpen==YES) {
        
        // crate table statement for different tables names
        NSString *tempString =[[NSString alloc] initWithFormat:@"UPDATE %@ SET %@ = %@ WHERE rowid = %d",tableName,columnName,columnValue,rowId];
        const char *sqlquery = [tempString cStringUsingEncoding:NSUTF8StringEncoding];
        //[tempString release];
        
        // crate table statement
        if (sqlite3_prepare_v2(sqlite_connection, sqlquery, -1, &update_statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(update_statement) == SQLITE_DONE) {
                databaseError = kSQLErrorCodeNone;
            }else {
                databaseError = kSQLErrorCodeCannotUpdateData;                // cannot update
                                                                              // NSPLog(@"Can't update data in datase: error %s",sqlite3_errmsg(sqlite_connection));
            }
            
        }
        else{
            databaseError = kSQLErrorCodeCannotPrepareStatement;             // cannot prepare statment
        }
        // close database
        sqlite3_finalize(update_statement);
    }    // end of if(databaseOpen==YES)
    return databaseError;
}

- (SQLErrorCode)deleteDataInTable:(NSString *)tableName atRow:(int)rowId {
    databaseError = kSQLErrorCodeNone;
    // open data base
    if(databaseOpen==YES) {
        
        // crate table statement for different tables names
        NSString *tempString =[[NSString alloc] initWithFormat:@"DELETE FROM %@ WHERE rowid = %d",tableName,rowId];
        // crate table statement
        const char *sqlquery = [tempString cStringUsingEncoding:NSUTF8StringEncoding];
        //[tempString release];
        
        
        
        if (sqlite3_prepare_v2(sqlite_connection, sqlquery, -1, &delete_statement, NULL) == SQLITE_OK) {
            
            if (sqlite3_step(delete_statement) == SQLITE_DONE) {
                databaseError = kSQLErrorCodeNone;
            }else {
                databaseError = kSQLErrorCodeCannotDeleteData;                // cannot delete
                                                                              // NSPLog(@"Can't delete data from datase: error %s",sqlite3_errmsg(sqlite_connection));
            }
        }
        else{
            databaseError = kSQLErrorCodeCannotPrepareStatement;             // cannot prepare statment
        }
        
        // close data base
        sqlite3_finalize(delete_statement);
    }    // end of if(databaseOpen==YES)
    return databaseError;
    
}

- (NSInteger)getTableSize:(NSString *)tableName {
    databaseError = kSQLErrorCodeNone;
    int numberOfRows = 0;
    
    // open data base
    if(databaseOpen==YES) {
        
        // crate table statement for different tables names
        NSString *tempString =[[NSString alloc] initWithFormat:@"SELECT COUNT(*) FROM %@",tableName];
        const char *sqlquery = [tempString cStringUsingEncoding:NSUTF8StringEncoding];
        //[tempString release];
        
        if (sqlite3_prepare_v2(sqlite_connection, sqlquery, -1, &get_statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(get_statement) == SQLITE_ROW) {
                
                // Get all data for friends timeline row
                // get id
                numberOfRows = (int) sqlite3_column_int(get_statement,0);
                
            }             // end of if(sqlite3_step)
        }         // end of if(sqlite3_prepare_v2)
        else{
            databaseError = kSQLErrorCodeCannotPrepareStatement;             // cannot prepare statment
        }
        // close data base
        sqlite3_finalize(get_statement);
        
    }    // end of if(databaseOpen==YES)
    
    return numberOfRows;
}

- (int)getLastRowId:(NSString *)tableName {
    databaseError = kSQLErrorCodeNone;
    int lastRowId= 1;
    
    // open data base
    if(databaseOpen==YES) {
        
        // crate table statement for different tables names
        NSString *tempString =[[NSString alloc] initWithFormat:@"SELECT MAX(rowid) FROM %@",tableName];
        const char *sqlquery = [tempString cStringUsingEncoding:NSUTF8StringEncoding];
        //[tempString release];
        
        
        if (sqlite3_prepare_v2(sqlite_connection, sqlquery, -1, &get_statement, NULL) == SQLITE_OK) {
            if (sqlite3_step(get_statement) == SQLITE_ROW) {
                
                // Get all data for friends timeline row
                // get id
                lastRowId = (int) sqlite3_column_int(get_statement,0);
                
            }             // end of if(sqlite3_step)
        }         // end of if(sqlite3_prepare_v2)
        
        // close data base
        sqlite3_finalize(get_statement);
    }    // end of if(databaseOpen==YES)
    
    return lastRowId;
}

#pragma mark -  Core Database Methods
- (BOOL)openDataBase {
    BOOL didOpen = YES;
    // database directory path in the resource directory: read only
    NSString *pathForDB = [self dataBaseFilePath];
    
    // check if the file exist
    NSFileManager *FileManager =[NSFileManager defaultManager];
    if([FileManager fileExistsAtPath:pathForDB]==YES) {
        
        // Open database
        if (sqlite3_open([pathForDB UTF8String], &sqlite_connection) != SQLITE_OK) {
            // cannot open database
            [self closeDataBase];
            databaseError = kSQLErrorCodeCannotOpenDatabase;            // cannot open data base
                                                                        // NSPLog(@"A: Can't open %@ database: %s",pathForDB, sqlite3_errmsg(sqlite_connection));
            didOpen = NO;
        }
    }
    else {
        databaseError = kSQLErrorCodeCannotOpenDatabaseFile;        // cannot open data base file
                                                                    // NSPLog(@"A: Can't find file: %@",pathForDB);
        didOpen = NO;
    }
    
    databaseOpen = didOpen;
    return didOpen;
}

- (BOOL)closeDataBase {
    BOOL didClose =YES;
    if (sqlite3_close(sqlite_connection) != SQLITE_OK) {
        databaseError = kSQLErrorCodeCannotCloseDatabase;         // failed to close
                                                                  // NSPLog(@"Error: failed to close database with message '%s'.", sqlite3_errmsg(sqlite_connection));
        didClose = NO;
    }
    return didClose;
}

// Implement databaseFilePath
- (NSString *)dataBaseFilePath {
    if(filetype==kSQLDatabaseFileTypeResource) {
        // For database in the resource directory: stored files
        return [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:filename];
    }
    else {
        // For database in the document directory: files created by the application
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = paths[0];
        return [documentsDirectory stringByAppendingPathComponent:filename];
    }
}

@end
