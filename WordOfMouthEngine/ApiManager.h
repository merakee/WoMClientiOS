//
//  ApiManager.h
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 11/9/13.
//  Copyright (c) 2013 Bijit Halder. All rights reserved.
//

#import "AFHTTPSessionManager.h"
#import "ApiUserManager.h"
#import "ApiContentManager.h"
#import "ApiValidationManager.h"
#import "ApiErrorManager.h"
#import "ApiRequestHelper.h"


//static NSString *kAMAPI_HOST_PATH   =   @"http://localhost:3000/api/v0";
static NSString *kAMAPI_HOST_PATH   =   @"http://wom.freelogue.net/api/v0";
//static NSString *kAMAPI_HOST_PATH   =   @"http://wom-backend-master-env-hv2gxttyvi.elasticbeanstalk.com/api/v0";
//static NSString *kAMAPI_BASE_PATH   =   @"api/v0";
static NSString *kAMAPI_SIGNUP_PATH   =   @"sign_up";
static NSString *kAMAPI_SIGNIN_PATH   =   @"sign_in";
static NSString *kAMAPI_SIGNOUT_PATH  =  @"sign_out";
static NSString *kAMAPI_PROFILE_PATH  =  @"profile";
static NSString *kAMAPI_CONTENT_PATH  =  @"contents";
static NSString *kAMAPI_RESPONSE_PATH =  @"user_responses";


@interface ApiManager : AFHTTPSessionManager{
}
#pragma mark - API User Manager
/*!
 *  ApiUserManager
 */
@property ApiUserManager    *apiUserManager;

#pragma mark -  Singleton method
/*!
 *  Generates singleton instance of ApiManager.
 *  @return An singleton instance of ApiManager.
 */

+ (ApiManager *) sharedApiManager;

#pragma mark -  HTTP CURD methods

#pragma mark -  Utility Methods
+ (NSString *)getStringForPath:(NSString *)pathString;

#pragma mark - Utility Methods: Network Reachability
/*!
 *  Checks to see if the Network is reachable.
 *  @return BOOL value indicating netword reachability.
 */
-(BOOL)isNetworkReachable;

#pragma mark - Utility Methods: Life Cycle
/*!
 *  Tasks after entering backgound.
 */
-(void)performEnteredBackgroundActions;


#pragma mark -  Utility Methods - Users
/*!
 *  Checks to see if there is a current user or current user is nil.
 *  @return BOOL value indicating if user is signed in.
 */
- (BOOL)isUserSignedIn;
/*!
 *  Returns current user. May be nil.
 *  @return an instance of current user.
 */
- (ApiUser *)currentUser;
/*!
 *  Checks to see if current user is anonymous
 *  @return BOOL value: yes if current user is anonymous user and no other wise
 */
- (BOOL)isAnonymousUser;

#pragma mark -  API Calls: User Session
/*!
 *  API call to sign up user with user paramers.
 *  @param userTypeId           An integer
 *  @param email                NSString containing user email
 *  @param password             NSString containing password
 *  @param passwordConfirmation NSString containing password confirmation
 *  @return A boolean value of success or failure.
 */
- (void)signUpUserWithUserTypeId:(int)userTypeId email:(NSString *)email
                        password:(NSString *)password
            passwordConfirmation:(NSString *)passwordConfirmation
                         success:(void (^)())success
                         failure:(void (^)(NSError *error))failure;
/*!
 *  API call to sign in user with user paramers.
 *  @param userTypeId           An integer
 *  @param email                NSString containing user email
 *  @param password             NSString containing the password
 *  @return A boolean value of success or failure.
 */
- (void)signInUserWithUserTypeId:(int)userTypeId
                           email:(NSString *)email
                        password:(NSString *)password
                         success:(void (^)())success
                         failure:(void (^)(NSError *error))failure;
/*!
 *  API call to sign out user with user paramers. The current signed user is signed out.
 *  @return A boolean value of success or failure.
 */
- (void)signOutUserSuccess:(void (^)())success
                   failure:(void (^)(NSError *error))failure;

#pragma mark -  API Calls: User Profile
/*!
 *  Gets User Profile information.
 *  @param success <#success description#>
 *  @param failure <#failure description#>
 */
- (void)getUserProfileSuccess:(void (^)())success
                      failure:(void (^)(NSError *error))failure;
/*!
 *  <#Description#>
 *  @param success <#success description#>
 *  @param failure <#failure description#>
 */
- (void)updateUserProfileSuccess:(void (^)())success
                         failure:(void (^)(NSError *error))failure;

#pragma mark -  API Calls: Content
/*!
 *  Gets contents for signed in user.
 *  @param success Returns an array of contents contentArray
 *  @param failure Returns error
 */
- (void)getContentSuccess:(void (^)(NSArray * contentArray))success
                  failure:(void (^)(NSError *error))failure;
/*!
 *  Posts content
 *  @param categoryId An Int for content category id (must be between 1 and 4 for valid category)
 *  @param text       NSString containing the text
 *  @param success    Returns apiContent object with all relevant parameter
 *  @param failure    Returns error
 */
- (void)postContentWithCategoryId:(int)categoryId
                             text:(NSString *)text
                            photo:(UIImage *)photo
                          success:(void (^)(ApiContent * content))success
                          failure:(void (^)(NSError *error))failure;

#pragma mark -  API Calls: Response
/*!
 *  Posts response for user of viewd content
 *  @param contentId An Int for content Id
 *  @param response  NSNumber containing the boolean value (spread => yes, kill => No, no response => nil)
 *  @param success   <#success description#>
 *  @param failure   <#failure description#>
 */
- (void)postResponseWithContentId:(int)contentId
                         response:(NSNumber *)response
                          success:(void (^)(ApiUserResponse *userResponse))success
                          failure:(void (^)(NSError *error))failure;


#pragma mark -  Test Code
+ (void)test;

@end