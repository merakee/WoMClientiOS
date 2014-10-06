//
//  SettingsDatabase.m
//  Utilities: DataBase
//
//  Created by Bijit Halder on 2/25/12.
//  Copyright (c) 2012 Indriam Inc. All rights reserved.
//

#import "ApiUserDatabase.h"
#import "LocalMacros.h"

@implementation ApiUserDatabase
@synthesize isDatabaseOpen;
@synthesize command;

- (id)init {
    if(self = [super init]) {
        // initialization code
        dataArrayOut =[[NSMutableArray alloc] initWithCapacity:kUDLocalUserInfoDatabaseMaxArraySize];
        databaseError = kSQLErrorCodeNone;
        
        // open Database
        sqlite = [[SQLiteAPI alloc] initWithFileName:kUDLocalUserInfoDatabaseFileName
                                             andType:kSQLDatabaseFileTypeDocument
                                               error:&databaseError];
        isDatabaseOpen = (databaseError==kSQLErrorCodeNone) ? YES : NO;
        
        // check if sucessful - otherwise create database file and tables
        if(isDatabaseOpen==NO) {
            // crate databse and tables
            isDatabaseOpen = [self createDatabase];
        }
        
        //DBLog(@"DBOpen? %d",isDatabaseOpen);
        
    }
    return self;
}


#pragma mark - user info methods
- (ApiUser *)getUser{
    int vcount = 5;
    // get user info
    self.command = [[NSString alloc] initWithFormat:@"SELECT user_id, user_type_id, email, authentication_token, signed_in FROM %@ LIMIT 1", kUDSQLUserTable];
    NSArray *results =[NSArray arrayWithArray:[sqlite executeGetCommand:self.command withDataArraySize:vcount]];
    return [self convertArrayToUser:results];
}
- (BOOL)saveUserInfo:(ApiUser *)user{
    if([user.userTypeId intValue]!=2){
        return false;
    }
    // delete all other users
    [self deleteUserInfo];
    // insert user info
    self.command = [[NSString alloc] initWithFormat:@"INSERT INTO %@ (user_id, user_type_id, email, authentication_token, signed_in) VALUES ('%d', '%d','%@','%@','%d') ", kUDSQLUserTable,[user.userId intValue],[user.userTypeId intValue],user.email,user.authenticationToken,[user.signedIn boolValue]?1:0];
    return [sqlite executeCommand:self.command]==0;
}

- (BOOL)deleteUserInfo{
    // delete all data
    self.command = [[NSString alloc] initWithFormat:@"DELETE FROM %@", kUDSQLUserTable];
    BOOL isSucessful= [sqlite executeCommand:self.command]==0;
    self.command = @"VACUUM";
    return isSucessful &&[sqlite executeCommand:self.command]==0;
}
- (ApiUser *)getAnonymousUser{
    int vcount = 5;
    // get user info
    self.command = [[NSString alloc] initWithFormat:@"SELECT user_id, user_type_id, email, authentication_token, signed_in FROM %@ LIMIT 1", kUDSQLAnonymousUserTable];
    NSArray *results =[NSArray arrayWithArray:[sqlite executeGetCommand:self.command withDataArraySize:vcount]];
    return [self convertArrayToUser:results];
}
- (BOOL)saveAnonymousUserInfo:(ApiUser *)user{
    if([user.userTypeId intValue]!=1){
        return false;
    }
    // delete all other anonymous users
    [self deleteAnonymousUserInfo];
    
    // insert user info
    self.command = [[NSString alloc] initWithFormat:@"INSERT INTO %@ (user_id, user_type_id, email, authentication_token, signed_in) VALUES ('%d', '%d','%@','%@','%d') ", kUDSQLAnonymousUserTable,[user.userId intValue],[user.userTypeId intValue],user.email,user.authenticationToken,[user.signedIn boolValue]?1:0];
    return [sqlite executeCommand:self.command]==0;
}
- (BOOL)deleteAnonymousUserInfo{
    // delete all data
    self.command = [[NSString alloc] initWithFormat:@"DELETE FROM %@", kUDSQLAnonymousUserTable];
    BOOL isSucessful= [sqlite executeCommand:self.command]==0;
    self.command = @"VACUUM";
    return isSucessful &&[sqlite executeCommand:self.command]==0;
}


#pragma mark - Utility Methods
- (ApiUser *)convertArrayToUser:(NSArray *)results {
    int vcount = 5;
    if([results count]<vcount) {
        return nil;
    }
    
    
    ApiUser *user =[[ApiUser alloc] initWithUserId:results[0]
                                        userTypeId:results[1]
                                             email:results[2]
                               authenticationToken:results[3]
                                          signedIn:[NSNumber numberWithBool:[results[4] intValue]==1]];
    return user;
}

#pragma mark -  Core DataBase  Methods
- (BOOL)createDatabase {
    // create file: File Path
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *pathForDB = [documentsDirectory stringByAppendingPathComponent:kUDLocalUserInfoDatabaseFileName];
    // File Manager
    NSFileManager *FileManager =[NSFileManager defaultManager];
    BOOL didSucceed = [FileManager createFileAtPath:pathForDB contents:nil attributes:nil];
    
    // open database
    if(didSucceed==YES) {
        didSucceed = [sqlite openDataBase];
    }
    
    // create tables
    if(didSucceed==YES) {
        didSucceed = [self createUserTable];
    }
    // create tables
    if(didSucceed==YES) {
        didSucceed = [self createAnonymousUserTable];
    }
    
    return didSucceed;
}

- (BOOL)createUserTable{
    self.command = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ ("
                    " user_id INTEGER NOT NULL, "
                    " user_type_id INTEGER NOT NULL, "
                    " email TEXT NOT NULL, "
                    " authentication_token TEXT, "
                    " signed_in INTEGER NOT NULL )", kUDSQLUserTable];
    
    databaseError = [sqlite executeCommand:self.command];
    
    return (databaseError==0);
}

- (BOOL)createAnonymousUserTable{
    self.command = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ ("
                    " user_id INTEGER NOT NULL, "
                    " user_type_id INTEGER NOT NULL, "
                    " email TEXT NOT NULL, "
                    " authentication_token TEXT, "
                    " signed_in INTEGER NOT NULL )", kUDSQLAnonymousUserTable];
    
    databaseError = [sqlite executeCommand:self.command];
    
    return (databaseError==0);
}


#pragma mark -  Test Code
+ (void)test {
    /*
    DBLog(@"Test results---------------------------------Start");
    int count=1;
    ApiUserDatabase *uid =[[ApiUserDatabase alloc] init];
    NSLog(@"Test starting....%d",count);
    // test regular user
    ApiUser *user= [[ApiUser alloc] initWithUserId:nil
                                        userTypeId:@2
                                             email:@"user@example.com"
                               authenticationToken:@"dfsr543jdfs9uhffaf4R"
                                          signedIn:@YES];
    if(![uid saveUserInfo:user]){
        DBLog(@"Error:User should be saved");
        [ApiUser printApiUser:user];
    }
    else{
        DBLog(@"%d...",count++);
    }
    
    ApiUser *user1=[uid getUser];
    if(!((user.userTypeId.intValue ==user1.userTypeId.intValue)&&
         [user.email isEqualToString:user1.email]&&
         [user.authenticationToken isEqualToString:user1.authenticationToken]&&
         (user.signedIn.boolValue==user1.signedIn.boolValue)
         )){
        DBLog(@"Error:Users must be same");
        [ApiUser printApiUser:user];
        [ApiUser printApiUser:user1];
        [ApiUser printApiUser:[uid getUser]];
    }
    else{
        DBLog(@"%d...",count++);
    }
    
    if(![uid deleteUserInfo]){
        DBLog(@"Error:User should be deleted");
        [ApiUser printApiUser:user];
    }
    else{
        DBLog(@"%d...",count++);
    }
    if([uid getUser]!=nil){
        DBLog(@"Error: User must be nil");
    }
    else{
        DBLog(@"%d...",count++);
    }
    
    
    // test anomymous regular user
    ApiUser *auser= [[ApiUser alloc] initWithUserId:nil
                                         userTypeId:@1
                                              email:@"anon@example.com"
                                authenticationToken:@"dfsr543jdfs9uhffaf4R"
                                           signedIn:@YES];
    if(![uid saveAnonymousUserInfo:auser]){
        DBLog(@"Error:User should be saved");
        [ApiUser printApiUser:auser];
    }
    else{
        DBLog(@"%d...",count++);
    }
    
    ApiUser *auser1=[uid getAnonymousUser];
    if(!((auser.userTypeId.intValue ==auser1.userTypeId.intValue)&&
         [auser.email isEqualToString:auser1.email]&&
         [auser.authenticationToken isEqualToString:auser1.authenticationToken]&&
         (auser.signedIn.boolValue==auser1.signedIn.boolValue)
         )){
        DBLog(@"Error:Users must be same");
        [ApiUser printApiUser:auser];
        [ApiUser printApiUser:auser1];
    }
    else{
        DBLog(@"%d...",count++);
    }
    
    DBLog(@"Test results---------------------------------End");
 */
}
@end
