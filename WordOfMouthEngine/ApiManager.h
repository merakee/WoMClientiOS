//
//  ApiManager.h
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 11/9/13.
//  Copyright (c) 2013 Bijit Halder. All rights reserved.
//

#import "AFHTTPSessionManager.h"
#import "ApiUserManager.h"

static NSString *kAMAPI_HOST_PATH   =   @"http://localhost:3000/api/v0";
//static NSString *kAMAPI_BASE_PATH   =   @"api/v0";
static NSString *kAMAPI_SIGNUP_PATH   =   @"sign_up";
static NSString *kAMAPI_SIGNIN_PATH   =   @"sign_in";
static NSString *kAMAPI_SIGNOUT_PATH  =  @"sign_out";
static NSString *kAMAPI_PROFILE_PATH  =  @"profile";
static NSString *kAMAPI_CONTENT_PATH  =  @"contents";
static NSString *kAMAPI_RESPONSE_PATH =  @"user_responses";

// Error
static NSString *kAppErrorDomainSession =  @"APIErrorDomain";

/*!
 *  APIManager error codes
 */
typedef enum {
    kAPIManagerErrorNone=0,
    kAPIManagerErrorInvalidSignUp,
    kAPIManagerErrorInvalidSingIn,
    kSAPIManagerErrorInvalidPassword,
} kAPIManagerErrorCode;


@protocol ApiManagerDelegate;

@interface ApiManager : AFHTTPSessionManager{
}

# pragma mark - delegate
/*!
 *  ApiManagerDelegate
 */
@property (nonatomic, weak) id<ApiManagerDelegate>delegate;

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
 *  Check to see if the Network is reachable.
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
 *  Cheaks to see if there is a current user or current user is nil.
 *  @return BOOL value indicating if user is signed in.
 */
- (BOOL)isUserSignedIn;
/*!
 *  Returns current user. May be nil.
 *  @return an instance of current user.
 */
- (ApiUser *)currentUser;

#pragma mark -  API Calls: User Session
/*!
 *  API call to sign up user with user paramers.
 *  @param userTypeId           An integer
 *  @param email                NSString
 *  @param password             NSString
 *  @param passwordConfirmation NSString
 *  @return A boolean value of success or failure. 
 */
- (BOOL)signUpUserWithUserTypeId:(int)userTypeId email:(NSString *)email
                        password:(NSString *)password
         andPasswordConfirmation:(NSString *)passwordConfirmation;
- (BOOL)signInUserWithUserTypeId:(int)userTypeId email:(NSString *)email andPassword:(NSString *)password;
- (BOOL)signOutUser;

#pragma mark -  API Calls: User Profile
- (BOOL)getUserProfile;
- (BOOL)updateUserProfile;

#pragma mark -  API Calls: Content
- (BOOL)getContent;
- (BOOL)postContentWithCategoryId:(int)categoryId andtext:(NSString *)text;

#pragma mark -  API Calls: Response
- (BOOL)postResponseWithContentId:(int)contentId andResponse:(NSNumber *)response;

#pragma mark -  Test Code
+ (void)test;

@end

@protocol ApiManagerDelegate <NSObject>
@required
@optional
// user sign up
-(void)apiManagerDidSignUpUser:(id)responseObject;
-(void)apiManagerUserSignUpFailedWithError:(NSError *)error;
// user sign in
-(void)apiManagerDidSignInUser:(id)responseObject;
-(void)apiManagerUserSignInFailedWithError:(NSError *)error;
-(void)apiManagerSigningUpAnonymousUser;
// user sign out
-(void)apiManagerDidSignOutUser:(id)responseObject;
-(void)apiManagerUserSignOutFailedWithError:(NSError *)error;
// user profile
-(void)apiManagerDidGetUserProfile:(id)responseObject;
-(void)apiManagerGetUserProfileFailedWithError:(NSError *)error;
-(void)apiManagerDidUpdateUserProfile:(id)responseObject;
-(void)apiManagerUpdateUserProfileFailedWithError:(NSError *)error;
// content
-(void)apiManagerDidGetContent:(id)responseObject;
-(void)apiManagerGetContentFailedWithError:(NSError *)error;
-(void)apiManagerDidPostContent:(id)responseObject;
-(void)apiManagerPostContentFailedWithError:(NSError *)error;
// response
-(void)apiManagerDidPostResponse:(id)responseObject;
-(void)apiManagerPostResponseFailedWithError:(NSError *)error;
@end
