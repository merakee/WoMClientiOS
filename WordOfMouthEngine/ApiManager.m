//
//  ApiManager.m
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 11/9/13.
//  Copyright (c) 2013 Bijit Halder. All rights reserved.
//

#import "ApiManager.h"
#import "CommonUtility.h"
#import "JSONResponseSerializerWithData.h"
#import "ApiErrorManager.h"
#import "ApiRequestHelper.h"

@implementation ApiManager

@synthesize apiUserManager;

#pragma mark -  Init Methods
- (id)init {
    //NSURL *baseURL = [NSURL URLWithString:kAMAPI_BASE_PATH relativeToURL:[NSURL URLWithString:kAMAPI_HOST_PATH ]];
    NSURL *baseURL =[NSURL URLWithString:kAMAPI_HOST_PATH ];
    
    if (self = [super initWithBaseURL:baseURL]) {
        // set up ApiManager
        [self setAllDefaults];
    }
    return self;
}

- (void)setAllDefaults {
    // set up ApiManager
    
    // set request and response serialier
    // defaults  AFHTTPSerializer (Req) and AFJSONResponseSerializer (Res)
    self.requestSerializer = [AFJSONRequestSerializer serializer];
    //self.responseSerializer = [AFJSONResponseSerializer serializer];
    self.responseSerializer = [JSONResponseSerializerWithData serializer];
    
    // set up reachability
    [self setUpReachabilityStausMonitoring];
    
    // set api user manager
    self.apiUserManager =[[ApiUserManager alloc] init];
}
- (void)setUpReachabilityStausMonitoring{
    // rechability monitoring
    [self.reachabilityManager startMonitoring];
    
    //networkReachable = self.reachabilityManager.isReachable;
    //__weak typeof(self) weakSelf = self;
    
    [self.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"Network Reachable: WWAN");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"Network Reachable ---: WiFi");
                //[operationQueue setSuspended:NO];
                //networkReachable = YES;
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"Network Not Reachable ");
                break;
            default:
                NSLog(@"Network Reachable: default");
                //[operationQueue setSuspended:YES];
                //networkReachable = NO;
                break;
        }
    }];
}

#pragma mark -  Singleton method
+ (ApiManager *)sharedApiManager{
    
    static ApiManager *apiManager=nil;
    // User Grand Central Dispatch to ensure thread safety
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        apiManager = [[self alloc] init];
    });
    
    return apiManager;
}

#pragma mark -  Utility Methods
+ (NSString *)getStringForPath:(NSString *)pathString{
    //return [[kAMAPI_HOST_PATH stringByAppendingPathComponent:kAMAPI_BASE_PATH] stringByAppendingPathComponent:pathString];
    return [kAMAPI_HOST_PATH  stringByAppendingPathComponent:pathString];
}

#pragma mark - Utility Methods: Network Reachability
- (BOOL)isNetworkReachable{
    return self.reachabilityManager.isReachable;
}
- (BOOL)checkNetworkReachabilityAndDisplayAlertForDelegate:(id)delegate{
    BOOL isReachable =[self isNetworkReachable];
    
    if(!isReachable &&delegate&&[delegate isKindOfClass:[UIViewController class]]){
        [CommonUtility displayAlertWithTitle:@"No Network Connection" message:@"Please check connection and try again." delegate:delegate];
    }
    return isReachable;
}
#pragma mark - Utility Methods: Life Cycle
-(void)performEnteredBackgroundActions{
    // reset anonymous user
    [self.apiUserManager  resetAnonymousUser];
}
#pragma mark -  Utility Methods - Users
- (BOOL)isUserSignedIn{
    return [self.apiUserManager isUserSignedIn];
}
- (ApiUser *)currentUser{
    return self.apiUserManager.currentUser;
}

#pragma mark -  API Calls: User Session - Sign up
- (void)signUpUserWithUserTypeId:(int)userTypeId
                           email:(NSString *)email
                        password:(NSString *)password
            passwordConfirmation:(NSString *)passwordConfirmation
                         success:(void (^)())success
                         failure:(void (^)(NSError *error))failure{
    // Sign up
    [self POST:kAMAPI_SIGNUP_PATH parameters:[ApiRequestHelper userSignUpParamsWithUserTypeId:userTypeId email:email password:password  andPasswordConfirmation:passwordConfirmation]
       success:^(NSURLSessionDataTask *task, id responseObject) {
           NSError *error = [self actionsForSuccessfulSignUpWithResponse:responseObject];
           if(error){
               failure(error);
           }
           else{
               success();
           }
       }
       failure:^(NSURLSessionDataTask *task, NSError *error) {
           failure([self actionsForFailedSignUpWithError:error]);
       }];
}

- (NSError *)actionsForSuccessfulSignUpWithResponse:(id)responseObject{
    NSLog(@"Response : %@",responseObject);
    // sign in user and save user info
    return [self actionsForSuccessfulSignUpWithResponse:responseObject];
}
- (NSError *)actionsForFailedSignUpWithError:(NSError *)error{
    return [ApiErrorManager processSignUpError:error];
}

#pragma mark -  API Calls: User Session - Sign In
- (void)signInUserWithUserTypeId:(int)userTypeId
                           email:(NSString *)email
                        password:(NSString *)password
                         success:(void (^)())success
                         failure:(void (^)(NSError *error))failure{
    // check to see if there is exiciting anonymou user. If yes, singin with that user
    if ((userTypeId==kAPIUserTypeAnonymous)&& ([self.apiUserManager signInAnonymousUser])){
        success();
    }
    
    [self POST:kAMAPI_SIGNIN_PATH parameters:[ApiRequestHelper userSignInParamsWithEmail:email andPassword:password]
       success:^(NSURLSessionDataTask *task, id responseObject) {
           NSError *error =  [self actionsForSuccessfulSignInWithResponse:responseObject];
           if(error){
               failure(error);
           }
           else{
               success();
           }
       }
       failure:^(NSURLSessionDataTask *task, NSError *error) {
           failure([self actionsForFailedSignInWithError:error]);
       }];
}
- (NSError *)actionsForSuccessfulSignInWithResponse:(id)responseObject{
    NSLog(@"Response : %@",responseObject);
    NSError *error=nil;
    
    // save the user info
    // get user info
    ApiUser *user = [ApiRequestHelper getUserFromDictionary:responseObject];
    if(!user){
        error =  [ApiErrorManager getErrorForInvalidApiResponse];
        return error;
    }
    // sign in and save
    if(![self.apiUserManager signInAndSaveUserInfo:user]){
        error =  [ApiErrorManager getErrorForSignInSaveUser];
    }
    return error;
    
}
- (NSError *)actionsForFailedSignInWithError:(NSError *)error{
    return [ApiErrorManager processSignInError:error];
}
#pragma mark -  API Calls: User Session - Sign Out
- (void)signOutUserSuccess:(void (^)())success
                   failure:(void (^)(NSError *error))failure{
    [self DELETE:kAMAPI_SIGNOUT_PATH parameters:[ApiRequestHelper userAuthenticationParams:self.apiUserManager.currentUser]
         success:^(NSURLSessionDataTask *task, id responseObject) {
             [self actionsForSuccessfulSignOutWithResponse:responseObject];
             success();
         }
         failure:^(NSURLSessionDataTask *task, NSError *error) {
             failure([self actionsForFailedSignOutWithError:error]);
         }];
}
- (void)actionsForSuccessfulSignOutWithResponse:(id)responseObject{
    
}
- (NSError *)actionsForFailedSignOutWithError:(NSError *)error{
    return [ApiErrorManager processSignOutError:error];
}
#pragma mark -  API Calls: User Profile
- (void)getUserProfileSuccess:(void (^)())success
                      failure:(void (^)(NSError *error))failure;{
    
    
    [self GET:kAMAPI_PROFILE_PATH parameters:[ApiRequestHelper userAuthenticationParams:self.apiUserManager.currentUser]
      success:^(NSURLSessionDataTask *task, id responseObject) {
          [self actionsForSuccessfulGetUserProfileWithResponse:responseObject];
          success();
      }
      failure:^(NSURLSessionDataTask *task, NSError *error) {
          failure([self actionsForFailedGetUserProfileWithError:error]);
      }];
    
}

- (void)actionsForSuccessfulGetUserProfileWithResponse:(id)responseObject{
    
}
- (NSError *)actionsForFailedGetUserProfileWithError:(NSError *)error{
    return [ApiErrorManager processGetProfileError:error];
}

- (void)updateUserProfileSuccess:(void (^)())success
                         failure:(void (^)(NSError *error))failure{
    
    [self PUT:kAMAPI_PROFILE_PATH parameters:[ApiRequestHelper userAuthenticationParams:self.apiUserManager.currentUser]
      success:^(NSURLSessionDataTask *task, id responseObject) {
          [self actionsForSuccessfulUpdateUserProfileWithResponse:responseObject];
          success();
      }
      failure:^(NSURLSessionDataTask *task, NSError *error) {
          failure([self actionsForFailedUpdateUserProfileWithError:error]);
      }];
}

- (void)actionsForSuccessfulUpdateUserProfileWithResponse:(id)responseObject{
    
}
- (NSError *)actionsForFailedUpdateUserProfileWithError:(NSError *)error{
    return [ApiErrorManager processUpdateProfileError:error];
}


#pragma mark -  API Calls: Content
- (void)getContentSuccess:(void (^)())success
                  failure:(void (^)(NSError *error))failure{
    
    [self GET:kAMAPI_CONTENT_PATH parameters:[ApiRequestHelper userAuthenticationParams:self.apiUserManager.currentUser]
      success:^(NSURLSessionDataTask *task, id responseObject) {
          [self actionsForSuccessfulGetContentWithResponse:responseObject];
          success();
      }
      failure:^(NSURLSessionDataTask *task, NSError *error) {
          failure([self actionsForFailedGetContentWithError:error]);
      }];
}

- (void)actionsForSuccessfulGetContentWithResponse:(id)responseObject{
    
}
- (NSError *)actionsForFailedGetContentWithError:(NSError *)error{
    return [ApiErrorManager processGetContentError:error];
}

- (void)postContentWithCategoryId:(int)categoryId
                             text:(NSString *)text
                          success:(void (^)())success
                          failure:(void (^)(NSError *error))failure{
    
    
    [self POST:kAMAPI_SIGNUP_PATH parameters:[ApiRequestHelper contentParamsWithUser:self.apiUserManager.currentUser categoryId:categoryId andtext:text]
       success:^(NSURLSessionDataTask *task, id responseObject) {
           [self actionsForSuccessfulPostContentWithResponse:responseObject];
           success();
       }
       failure:^(NSURLSessionDataTask *task, NSError *error) {
           failure([self actionsForFailedPostContentWithError:error]);
       }];
}
- (void)actionsForSuccessfulPostContentWithResponse:(id)responseObject{
    
}
- (NSError *)actionsForFailedPostContentWithError:(NSError *)error{
    return [ApiErrorManager processPostContentError:error];
}

#pragma mark -  API Calls: Response
- (void)postResponseWithContentId:(int)contentId
                         response:(NSNumber *)response
                          success:(void (^)())success
                          failure:(void (^)(NSError *error))failure{
    
    
    [self POST:kAMAPI_SIGNUP_PATH parameters:[ApiRequestHelper responseParamsWith:self.apiUserManager.currentUser contentId:contentId andResponse:response]
       success:^(NSURLSessionDataTask *task, id responseObject) {
           [self actionsForSuccessfulPostResponseWithResponse:responseObject];
           success();
       }
       failure:^(NSURLSessionDataTask *task, NSError *error) {
           failure([self actionsForFailedPostResonseWithError:error]);
       }];
}
- (void)actionsForSuccessfulPostResponseWithResponse:(id)responseObject{
    
}
- (NSError *)actionsForFailedPostResonseWithError:(NSError *)error{
    return [ApiErrorManager processPostResponseError:error];
}

#pragma mark -  Test Code
+ (void)test {
    /*BOOL isSuccessful =[[ApiManager sharedApiManager] signUpUserWithUserTypeId:kAPIUserTypeWom
     email:nil
     password:nil
     andPasswordConfirmation:nil];
     */
    //NSLog(@"Is sucessful: %d",isSuccessful);
    
}

@end
