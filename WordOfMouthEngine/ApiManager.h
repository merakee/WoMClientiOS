//
//  ApiManager.h
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 11/9/13.
//  Copyright (c) 2013 Bijit Halder. All rights reserved.
//


/*!
 * @header ApiManager
 * Manager Class for communicating with BackEnd Api
 * @abstract ApiManager Interface
 * @author Bijit Halder
 * @version 2.0
 */

#import "AFHTTPSessionManager.h"
#import "ApiUserManager.h"
#import "ApiContentManager.h"
#import "ApiValidationManager.h"
#import "ApiErrorManager.h"
#import "ApiRequestHelper.h"

/*!
 *  @brief URL for the back end server
 */
// Local
//static NSString *kAMAPI_HOST_PATH   =   @"http://localhost:3000/api/v0";
// Development
//static NSString *kAMAPI_HOST_PATH   =   @"http://wom-dev.freelogue.net/api/v0";
// Production
static NSString *kAMAPI_HOST_PATH   =   @"http://wom-v2.freelogue.net/api/v0";



//static NSString *kAMAPI_BASE_PATH   =   @"api/v0";
/*!
 *  @brief Relative path for SIGNUP_PATH
 */
static NSString *kAMAPI_SIGNUP_PATH   =   @"signup";
/*!
 *  @brief Relative path for SIGNIN_PATH
 */
static NSString *kAMAPI_SIGNIN_PATH   =   @"signin";
/*!
 *  @brief Relative path for SIGNOUT_PATH
 */
static NSString *kAMAPI_SIGNOUT_PATH  =  @"signout";
/*!
 *  @brief Relative path for PROFILE_PATH
 */
//static NSString *kAMAPI_PROFILE_PATH  =  @"profile";
/*!
 *  @brief Relative path for GET_CONTENT_LIST
 */
static NSString *kAMAPI_GET_CONTENT_LIST_PATH  =  @"contents/getlist";
/*!
 *  @brief Relative path for GET_CONTENT
 */
static NSString *kAMAPI_GET_CONTENT_PATH  =  @"contents/getcontent";
/*!
 *  @brief Relative path for POST_CONTENT
 */
static NSString *kAMAPI_POST_CONTENT_PATH  =  @"contents/create";
/*!
 *  @brief Relative path for FLAG_CONTENT
 */
static NSString *kAMAPI_FLAG_CONTENT_PATH  =  @"contents/flag";
/*!
 *  @brief Relative path for USER RESPONSE
 */
static NSString *kAMAPI_POST_CONTENT_RESPONSE_PATH =  @"contents/response";
/*!
 *  @brief Relative path for GET_COMMENT
 */
static NSString *kAMAPI_GET_COMMENT_LIST_PATH  =  @"comments/getlist";
/*!
 *  @brief Relative path for POST_COMMENT
 */
static NSString *kAMAPI_POST_COMMENT_PATH  =  @"comments/create";
/*!
 *  @brief Relative path for COMMENT_RESPONSE
 */
static NSString *kAMAPI_POST_COMMENT_RESPONSE_PATH =  @"comments/response";
/*!
 *  @brief Relative path for GET_HISTORY_CONTENTS
 */
static NSString *kAMAPI_GET_HISTORY_CONTENTS_PATH =  @"history/contents";
/*!
 *  @brief Relative path for GET_HISTORY_COMMENTS
 */
static NSString *kAMAPI_GET_HISTORY_COMMENTS_PATH =  @"history/comments";
/*!
 *  @brief Relative path for GET_NOTIFICATIONS
 */
static NSString *kAMAPI_GET_NOTIFICATION_LIST_PATH =  @"notifications/getlist";
/*!
 *  @brief Relative path for GET_NOTIFICATIONS_COUNT
 */
static NSString *kAMAPI_GET_NOTIFICATION_COUNT_PATH =  @"notifications/count";
/*!
 *  @brief Relative path for RESET_NOTIFICATIONS_COTENT_PATH
 */
static NSString *kAMAPI_RESET_NOTIFICATION_CONTENT_PATH =  @"notifications/reset/content";
/*!
 *  @brief Relative path for RESET_NOTIFICATIONS_COMMENT_PATH
 */
static NSString *kAMAPI_RESET_NOTIFICATION_COMMENT_PATH =  @"notifications/reset/comment";

@interface ApiManager : AFHTTPSessionManager{
}
#pragma mark - API User Manager
/*!
 *  @brief ApiUserManager
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
/*!
 *  Converts relative path to full URL by attaching Host specified in kAMAPI_HOST_PATH
 *  @param pathString relative path
 *  @return the full URL with host path
 */
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
///*!
// *  Gets User Profile information.
// *  @param success Returns void
// *  @param failure Returns error
// *  @deprecated Do not use this method
// */
//- (void)getUserProfileSuccess:(void (^)())success
//                      failure:(void (^)(NSError *error))failure;
///*!
// *  Method to update User Profile
// *  @param success Returns void
// *  @param failure Returns error
// *  @deprecated Do not use this method
// */
//- (void)updateUserProfileSuccess:(void (^)())success
//                         failure:(void (^)(NSError *error))failure;

#pragma mark -  API Calls: Content
/*!
 *  Gets List contents for signed in user.
 *  @param success Returns an array of contents: contentArray
 *  @param failure Returns error
 */
- (void)getContentListSuccess:(void (^)(NSArray * contentArray))success
                      failure:(void (^)(NSError *error))failure;
/*!
 *  Gets content for given content id
 *  @param success Returns an array of contents: contentArray
 *  @param failure Returns error
 */
- (void)getContentWithId:(int)contentId
                 success:(void (^)(ApiContent *))success
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

#pragma mark -  API Calls: Content Response
/*!
 *  Posts response for user of viewd content
 *  @param contentId An Int for content Id
 *  @param response  NSNumber containing the boolean value (spread => yes, kill => No, no response => nil)
 *  @param success   Returns apiUserResponse object with all relevant parameter
 *  @param failure   Returns error
 */
- (void)postResponseWithContentId:(int)contentId
                         response:(NSNumber *)response
                          success:(void (^)(ApiUserResponse *userResponse))success
                          failure:(void (^)(NSError *error))failure;

#pragma mark -  API Calls: Content Flag
/*!
 *  Flags Content
 *  @param contentId The id for comment that is flagged
 *  @param success Returns an ApiContentFlag object
 *  @param failure Returns error
 */
- (void)flagContentWithId:(int)contentId
                                 success:(void (^)(ApiContentFlag * contentFlag))success
                                 failure:(void (^)(NSError *error))failure;

#pragma mark -  API Calls: Comment
/*!
 *  Gets comment for given content id
 *  @param mode comment order mode popular or recent. Default recent
 *  @param count number of comments
 *  @param offset the start count
 *  @param success Returns an array of comments: commentArray
 *  @param failure Returns error
 */

- (void)getCommentsForContentId:(int)contentId
                           mode:(kAPICommentOrderMode)mode
                          count:(int)count
                         offset:(int)offset
                        success:(void (^)(NSArray * commentArray))success
                        failure:(void (^)(NSError *error))failure;
/*!
 *  Posts comment for associated content
 *  @param contentId An Int for content id
 *  @param text       NSString containing the text
 *  @param success    Returns apiComment object with all relevant parameter
 *  @param failure    Returns error
 */
- (void)postCommentWithContentId:(int)contentId
                            text:(NSString *)text
                         success:(void (^)(ApiComment * comment))success
                         failure:(void (^)(NSError *error))failure;

#pragma mark -  API Calls: Comment Response
/*!
 *  Posts response for user of viewed comment
 *  @param commentId An Int for comment Id
 *  @param success   Returns apiCommentResponse object with all relevant parameter
 *  @param failure   Returns error
 */
- (void)postCommentResponseWithCommentId:(int)commentId
                                 success:(void (^)(ApiCommentResponse *commentResponse))success
                                 failure:(void (^)(NSError *error))failure;




#pragma mark -  API Calls: History
/*!
 *  Gets content history for given user id
 *  @param count number of contents
 *  @param offset the start count
 *  @param success Returns an array of contents: contentArray
 *  @param failure Returns error
 */
- (void)getHistoryOfContentsWithCount:(int)count
                               offset:(int)offset
                              success:(void (^)(NSArray * contentArray))success
                              failure:(void (^)(NSError *error))failure;
/*!
 *  Gets comment history for given user id
 *  @param count number of comments
 *  @param offset the start count
 *  @param success Returns an array of comments: commentArray
 *  @param failure Returns error
 */
- (void)getHistoryOfCommentsWithCount:(int)count
                               offset:(int)offset
                              success:(void (^)(NSArray * commentArray))success
                              failure:(void (^)(NSError *error))failure;

#pragma mark -  API Calls: Notifications
/*!
 *  Gets List Notification Counts for signed in user.
 *  @param success Returns an ApiNotificationCount Object
 *  @param failure Returns error
 */
- (void)getNotificationCountSuccess:(void (^)(ApiNotificationCount *))success
                            failure:(void (^)(NSError *error))failure;
/*!
 *  Gets List Notifications for signed in user.
 *  @param success Returns an array of Notifications: each item is either an ApiContent or ApiComment object
 *  @param failure Returns error
 */
- (void)getNotificationListSuccess:(void (^)(NSArray * notificationArray))success
                           failure:(void (^)(NSError *error))failure;
/*!
 *  Resets Content new like count by the amount specified by count param
 *  @param contentId The id for content whose like count are to be reset
 *  @param count the value the new like count would be decremented by. Must be >0 and less the current new like count
 *  @param success Returns an ApiContent object with modified values
 *  @param failure Returns error
 */
- (void)resetNotificationCountForContent:(int)contentId
                               withCount:(int)count
                                 success:(void (^)(ApiContent * content))success
                                 failure:(void (^)(NSError *error))failure;

/*!
 *  Resets Comment new like count by the amount specified by count param
 *  @param commentId The id for comment whose like count are to be reset
 *  @param count the value the new like count would be decremented by. Must be >0 and less the current new like count
 *  @param success Returns an ApiComment object with modified values
 *  @param failure Returns error
 */
- (void)resetNotificationCountForComment:(int)commentId
                               withCount:(int)count
                                 success:(void (^)(ApiComment * comment))success
                                 failure:(void (^)(NSError *error))failure;



#pragma mark -  Test Code
+ (void)test;

@end