////
////  SettingsDatabase.m
////  Utilities: DataBase
////
////  Created by Bijit Halder on 2/25/12.
////  Copyright (c) 2012 Indriam Inc. All rights reserved.
////
//
//#import "ApiContentDatabase.h"
//#import "LocalMacros.h"
//
//@implementation ApiContentDatabase
//@synthesize isDatabaseOpen;
//@synthesize command;
//
//- (id)init {
//    if(self = [super init]) {
//        // initialization code
//        dataArrayOut =[[NSMutableArray alloc] initWithCapacity:kLocalContentDatabaseMaxArraySize];
//        databaseError = kSQLErrorCodeNone;
//        
//        // open Database
//        sqlite = [[SQLiteAPI alloc] initWithFileName:kLocalContentDatabaseFileName
//                                             andType:kSQLDatabaseFileTypeResource
//                                               error:&databaseError];
//        isDatabaseOpen = (databaseError==kSQLErrorCodeNone) ? YES : NO;
//    }
//    return self;
//}
//
//
//#pragma mark - content methods
//- (ApiContent *)getContent{
//    int vcount = 8;
//    // get info
//    self.command = [[NSString alloc] initWithFormat:@"SELECT rowid, content_text, author_id, category_id, total_spread,  spread_count, kill_count, comment_count FROM %@ ORDER BY RANDOM() LIMIT 1", kSQLContentTable];
//    NSArray *results =[NSArray arrayWithArray:[sqlite executeGetCommand:self.command withDataArraySize:vcount]];
//    return [self convertArrayToContentInfo:results];
//}
//- (NSString *)getCategoryTextForId:(int)categoryId{
//    // get info
//    self.command = [[NSString alloc] initWithFormat:@"SELECT category_text FROM %@ WHERE rowid  = %d", kSQLCategoryTable,categoryId];
//    [dataArrayOut setArray:[sqlite executeGetCommand:command withDataArraySize:1]];
//    
//    if([dataArrayOut count]==0) {
//        return @"";
//    }
//    else{
//        return dataArrayOut[0];
//    }
//}
//
//#pragma mark - Utility Methods
//- (ApiContent *)convertArrayToContentInfo:(NSArray *)results {
//    int vcount = 8;
//    if([results count]<vcount) {
//        return nil;
//    }
//    ApiContent *ci =[[ApiContent alloc] initWithContentId:results[0]
//                                                     text:results[1]
//                                                   userId:results[2]
//                                               categoryId:results[3]
//                                               photoToken:@{}
//                                                createdAt:@""
//                                              totalSpread:results[4]
//                                              spreadCount:results[5]
//                                                killCount:results[6]
//                                          commentCount:results[7]];
//    return ci;
//}
//
//#pragma mark -  Test Code
//+ (void)test {
//    /*
//    DBLog(@"Test results---------------------------------Start");
//    ApiContentDatabase *lcd =[[ApiContentDatabase alloc] init];
//    [ApiContent printContentInfo:[lcd getContent]];
//    [ApiContent printContentInfo:[lcd getContent]];
//    [ApiContent printContentInfo:[lcd getContent]];
//    DBLog(@"%@",[lcd getCategoryTextForId:1]);
//    DBLog(@"%@",[lcd getCategoryTextForId:2]);
//    DBLog(@"%@",[lcd getCategoryTextForId:3]);
//    DBLog(@"%@",[lcd getCategoryTextForId:4]);
//    DBLog(@"%@",[lcd getCategoryTextForId:5]);
//    DBLog(@"%@",[lcd getCategoryTextForId:6]);
//    DBLog(@"%@",[lcd getCategoryTextForId:0]);
//    DBLog(@"Test results---------------------------------End");
//     */
//}
//
//@end
