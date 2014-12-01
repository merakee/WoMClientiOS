//
//  TestHelper.h
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 7/17/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

/*!
 *  Gobal Test Helper: start and stop context and helper methods
 *
 */
#import <Foundation/Foundation.h>
#import "ApiManager.h"
#import "AsynTestHelper.h"

@interface TestHelper : NSObject

#pragma mark - Context helpers
/*!
 *  Starts a given context
 *  @param context NSString for the context
 *  @return BOOL Yes for success and NO for unknown context
 */
+ (BOOL)startContext:(NSString *)context;
/*!
 *  Stops a given context
 *  @param context NSString for the context
 *  @return BOOL Yes for success and NO for unknown context
 */
+ (BOOL)stopContext:(NSString *)context;


#pragma mark - Misc Helpers: Session
/*!
 *  Helper method to sign in anonymous user
 *  @return BOOL for success or failure
 */
+ (BOOL)signInAnonymousUser;
/*!
 *  Helper method to sign in anonymous user
 *  @param user ApiUser to be singed in: user_type_id and email needed, password is default 
 *  @return BOOL for success or failure
 */
+ (BOOL)signInUser:(ApiUser *)user;
/*!
 *  Helper method to sign out anonymous user
 *  @return BOOL for success or failure
 */
+ (BOOL)signOutAnonymousUser;
/*!
 *  Helper method to sign out user
 *  @return BOOL for success or failure
 */
+ (BOOL)signOutUser;
/*!
 *  Helper method to sign out and delete anonymous user
 *  @return BOOL for success or failure
 */
+ (BOOL)signOutAndDeleteAnonymousUser;
/*!
 *  Helper method to sign out all users
 *  @return BOOL for success or failure
 */
+ (BOOL)signOutAllUsers;
/*!
 *  Helper method to sign out and delete all users
 *  @return BOOL for success or failure
 */
+ (BOOL)signOutAndDeleteAllUsers;


#pragma mark - Misc Helpers: Content and User
+ (BOOL)createContentsWithCount:(int)count;
+ (BOOL)createUSersWithCount:(int)count;


@end
