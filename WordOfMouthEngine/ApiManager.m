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

@implementation ApiManager

@synthesize delegate;
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
    //    [self.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
    //        switch (status) {
    //            case AFNetworkReachabilityStatusReachableViaWWAN:
    //                NSLog(@"Network Reachable: WWAN");
    //                break;
    //            case AFNetworkReachabilityStatusReachableViaWiFi:
    //                NSLog(@"Network Reachable: WiFi");
    //                //[operationQueue setSuspended:NO];
    //                //networkReachable = YES;
    //                break;
    //            case AFNetworkReachabilityStatusNotReachable:
    //                NSLog(@"Network Not Reachable ");
    //                break;
    //            default:
    //                // NSLog(@"Network Reachable: default");
    //                //[operationQueue setSuspended:YES];
    //                // networkReachable = NO;
    //                break;
    //        }
    //    }];
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
- (BOOL)checkNetworkReachabilityAndDisplayAlert{
    BOOL isReachable =[self isNetworkReachable];
    
    if(!isReachable &&self.delegate&&[self.delegate isKindOfClass:[UIViewController class]]){
        [CommonUtility displayAlertWithTitle:@"No Network Connection" message:@"Please check connection and try again." delegate:self.delegate];
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
- (BOOL)signUpUserWithUserTypeId:(int)userTypeId email:(NSString *)email password:(NSString *)password andPasswordConfirmation:(NSString *)passwordConfirmation{
    if(![self checkNetworkReachabilityAndDisplayAlert]){
        return false;
    }
    // Sign up
    [self POST:kAMAPI_SIGNUP_PATH parameters:[self userSignUpParamsWithUserTypeId:userTypeId email:email password:password  andPasswordConfirmation:passwordConfirmation]
       success:^(NSURLSessionDataTask *task, id responseObject) {
           [self actionsForSuccessfulSignUpWithResponse:responseObject];
       }
       failure:^(NSURLSessionDataTask *task, NSError *error) {
           [self actionsForFailedSignUpWithError:error];
       }];
    
    return true;
}

- (BOOL)signUpAnonynousUser{
    if ([self.delegate respondsToSelector:@selector(apiManagerSigningUpAnonymousUser)]) {
        [self.delegate apiManagerSigningUpAnonymousUser];
    }
    [self signUpUserWithUserTypeId:kAPIUserTypeAnonymous  email:nil password:nil  andPasswordConfirmation:nil];
    
    return false;
}

- (void)actionsForSuccessfulSignUpWithResponse:(id)responseObject{
    NSLog(@"Response : %@",responseObject);
    
    // save the user info
    if([self.apiUserManager saveUserInfo:[self getUserFromDictionary:responseObject]]){
        if ([self.delegate respondsToSelector:@selector(apiManagerDidSignUpUser:)]) {
            [self.delegate apiManagerDidSignUpUser:responseObject];
        }
    }
    else{
        if ([self.delegate respondsToSelector:@selector(apiManagerUserSignUpFailedWithError:)]) {
            NSError *error =[CommonUtility getErrorWithDomain:kAppErrorDomainSession
                                                         code:kAPIManagerErrorInvalidSignUp
                                                  description:@"Could not sign up"
                                                       reason:@"Invalid response from API"
                                                   suggestion:@"Please try again"];
            
            [self.delegate apiManagerUserSignUpFailedWithError:error];
        }
    }
}
- (void)actionsForFailedSignUpWithError:(NSError *)error{
    NSLog(@"Localized Error: %@",[error  localizedDescription]);
    NSLog(@"User Info: %@",[error  userInfo][JSONResponseSerializerWithDataKey]);
    
    if ([self.delegate respondsToSelector:@selector(apiManagerUserSignUpFailedWithError:)]) {
        [self.delegate apiManagerUserSignUpFailedWithError:error];
    }
}
#pragma mark -  API Calls: User Session - Sign In
- (BOOL)signInUserWithUserTypeId:(int)userTypeId email:(NSString *)email andPassword:(NSString *)password{
    if (userTypeId==kAPIUserTypeAnonymous){
        return [self signInAnonymousUser];
    }
    
    if(![self checkNetworkReachabilityAndDisplayAlert]){
        return false;
    }
    [self POST:kAMAPI_SIGNIN_PATH parameters:[self userSignInParamsWithEmail:email andPassword:password]
       success:^(NSURLSessionDataTask *task, id responseObject) {
           [self actionsForSuccessfulSignInWithResponse:responseObject];
       }
       failure:^(NSURLSessionDataTask *task, NSError *error) {
           [self actionsForFailedSignInWithError:error];
       }];
    
    return true;
}
- (BOOL)signInAnonymousUser{
    BOOL isSignedIn= [self.apiUserManager signInAnonymousUser];
    if(isSignedIn){
        return isSignedIn;
    }
    // sign up anonymous user
    return [self signUpAnonynousUser];
}
- (void)actionsForSuccessfulSignInWithResponse:(id)responseObject{
    NSLog(@"%@",responseObject);
    if ([self.delegate respondsToSelector:@selector(apiManagerDidSignInUser:)]) {
        [self.delegate apiManagerDidSignInUser:responseObject];
        
    }
}
- (void)actionsForFailedSignInWithError:(NSError *)error{
    NSLog(@"%@",error);
    if ([self.delegate respondsToSelector:@selector(apiManagerUserSignInFailedWithError:)]) {
        
        [self.delegate apiManagerUserSignInFailedWithError:error];
    }
}
#pragma mark -  API Calls: User Session - Sign Out
- (BOOL)signOutUser{
    if(![self checkNetworkReachabilityAndDisplayAlert]){
        return false;
    }
    
    [self DELETE:kAMAPI_SIGNOUT_PATH parameters:[self userAuthenticationParams]
         success:^(NSURLSessionDataTask *task, id responseObject) {
             [self actionsForSuccessfulSignOutWithResponse:responseObject];
         }
         failure:^(NSURLSessionDataTask *task, NSError *error) {
             [self actionsForFailedSignOutWithError:error];
         }];
    return true;
}
- (void)actionsForSuccessfulSignOutWithResponse:(id)responseObject{
    if ([self.delegate respondsToSelector:@selector(apiManagerDidSignOutUser:)]) {
        [self.delegate apiManagerDidSignOutUser:responseObject];
    }
}
- (void)actionsForFailedSignOutWithError:(NSError *)error{
    if ([self.delegate respondsToSelector:@selector(apiManagerUserSignOutFailedWithError:)]) {
        [self.delegate apiManagerUserSignOutFailedWithError:error];
    }
}
#pragma mark -  API Calls: User Profile
- (BOOL)getUserProfile{
    if(![self checkNetworkReachabilityAndDisplayAlert]){
        return false;
    }
    
    [self GET:kAMAPI_PROFILE_PATH parameters:[self userAuthenticationParams]
      success:^(NSURLSessionDataTask *task, id responseObject) {
          [self actionsForSuccessfulGetUserProfileWithResponse:responseObject];
      }
      failure:^(NSURLSessionDataTask *task, NSError *error) {
          [self actionsForFailedGetUserProfileWithError:error];
      }];
    return true;
}

- (void)actionsForSuccessfulGetUserProfileWithResponse:(id)responseObject{
    if ([self.delegate respondsToSelector:@selector(apiManagerDidGetUserProfile:)]) {
        [self.delegate apiManagerDidGetUserProfile:responseObject];
    }
}
- (void)actionsForFailedGetUserProfileWithError:(NSError *)error{
    if ([self.delegate respondsToSelector:@selector(apiManagerGetUserProfileFailedWithError:)]) {
        [self.delegate apiManagerGetUserProfileFailedWithError:error];
    }
}

- (BOOL)updateUserProfile{
    if(![self checkNetworkReachabilityAndDisplayAlert]){
        return false;
    }
    [self PUT:kAMAPI_PROFILE_PATH parameters:[self userAuthenticationParams]
      success:^(NSURLSessionDataTask *task, id responseObject) {
          [self actionsForSuccessfulUpdateUserProfileWithResponse:responseObject];
      }
      failure:^(NSURLSessionDataTask *task, NSError *error) {
          [self actionsForFailedUpdateUserProfileWithError:error];
      }];
    
    return true;
}

- (void)actionsForSuccessfulUpdateUserProfileWithResponse:(id)responseObject{
    if ([self.delegate respondsToSelector:@selector(apiManagerDidUpdateUserProfile:)]) {
        [self.delegate apiManagerDidUpdateUserProfile:responseObject];
    }
}
- (void)actionsForFailedUpdateUserProfileWithError:(NSError *)error{
    if ([self.delegate respondsToSelector:@selector(apiManagerUpdateUserProfileFailedWithError:)]) {
        [self.delegate apiManagerUpdateUserProfileFailedWithError:error];
    }
}


#pragma mark -  API Calls: Content
- (BOOL)getContent{
    if(![self checkNetworkReachabilityAndDisplayAlert]){
        return false;
    }
    [self GET:kAMAPI_CONTENT_PATH parameters:[self userAuthenticationParams]
      success:^(NSURLSessionDataTask *task, id responseObject) {
          [self actionsForSuccessfulGetContentWithResponse:responseObject];
      }
      failure:^(NSURLSessionDataTask *task, NSError *error) {
          [self actionsForFailedGetContentWithError:error];
      }];
    
    return true;
}

- (void)actionsForSuccessfulGetContentWithResponse:(id)responseObject{
    if ([self.delegate respondsToSelector:@selector(apiManagerDidGetContent:)]) {
        [self.delegate apiManagerDidGetContent:responseObject];
    }
}
- (void)actionsForFailedGetContentWithError:(NSError *)error{
    if ([self.delegate respondsToSelector:@selector(apiManagerGetContentFailedWithError:)]) {
        [self.delegate apiManagerGetContentFailedWithError:error];
    }
}

- (BOOL)postContentWithCategoryId:(int)categoryId andtext:(NSString *)text{
    if(![self checkNetworkReachabilityAndDisplayAlert]){
        return false;
    }
    
    [self POST:kAMAPI_SIGNUP_PATH parameters:[self contentParamsWithCategoryId:categoryId andtext:text]
       success:^(NSURLSessionDataTask *task, id responseObject) {
           [self actionsForSuccessfulPostContentWithResponse:responseObject];
       }
       failure:^(NSURLSessionDataTask *task, NSError *error) {
           [self actionsForFailedPostContentWithError:error];
       }];
    
    return true;
}
- (void)actionsForSuccessfulPostContentWithResponse:(id)responseObject{
    if ([self.delegate respondsToSelector:@selector(apiManagerDidPostContent:)]) {
        [self.delegate apiManagerDidPostContent:responseObject];
    }
}
- (void)actionsForFailedPostContentWithError:(NSError *)error{
    if ([self.delegate respondsToSelector:@selector(apiManagerPostContentFailedWithError:)]) {
        [self.delegate apiManagerPostContentFailedWithError:error];
    }
}

#pragma mark -  API Calls: Response
- (BOOL)postResponseWithContentId:(int)contentId andResponse:(NSNumber *)response{
    if(![self checkNetworkReachabilityAndDisplayAlert]){
        return false;
    }
    
    [self POST:kAMAPI_SIGNUP_PATH parameters:[self responseParamsWithContentId:contentId andResponse:response]
       success:^(NSURLSessionDataTask *task, id responseObject) {
           [self actionsForSuccessfulPostResponseWithResponse:responseObject];
       }
       failure:^(NSURLSessionDataTask *task, NSError *error) {
           [self actionsForFailedPostResonseWithError:error];
       }];
    
    return true;
}
- (void)actionsForSuccessfulPostResponseWithResponse:(id)responseObject{
    if ([self.delegate respondsToSelector:@selector(apiManagerDidPostResponse:)]) {
        [self.delegate apiManagerDidPostResponse:responseObject];
    }
}
- (void)actionsForFailedPostResonseWithError:(NSError *)error{
    if ([self.delegate respondsToSelector:@selector(apiManagerPostResponseFailedWithError:)]) {
        [self.delegate apiManagerPostResponseFailedWithError:error];
    }
}
#pragma mark -  Utility Methods: JSON Request
-(NSDictionary *)userSignUpParamsWithUserTypeId:(int)userTypeId email:(NSString *)email password:(NSString *)password andPasswordConfirmation:(NSString *)passwordConfirmation{
    if (email==nil){email=@"";}
    if(password==nil){password=@"";}
    if(passwordConfirmation==nil){passwordConfirmation=@"";}
    return @{@"user":@{
                     @"user_type_id": [NSNumber numberWithInt:userTypeId],
                     @"email":email,
                     @"password":password,
                     @"password_confirmation":passwordConfirmation}};
}
-(NSDictionary *)userSignInParamsWithEmail:(NSString *)email andPassword:(NSString *)password{
    if (email==nil){email=@"";}
    if(password==nil){password=@"";}
    return @{@"user":@{
                     @"email":email,
                     @"password":password}};
}
-(NSDictionary *)userAuthenticationParams{
    return @{@"user":@{
                     @"user_type_id": self.apiUserManager.currentUser.userTypeId,
                     @"email":self.apiUserManager.currentUser.email,
                     @"authentication_token":self.apiUserManager.currentUser.authenticationToken}};
}
-(NSDictionary *)contentParamsWithCategoryId:(int)categoryId andtext:(NSString *)text{
    return [self addUserAuthToDictionary:@{@"content":@{
                                                   @"content_category_id": [NSNumber numberWithInt:categoryId],
                                                   @"text":text}}];
}
-(NSDictionary *)responseParamsWithContentId:(int)contentId andResponse:(NSNumber *)response{
    return [self addUserAuthToDictionary:@{@"content":@{
                                                   @"content_id": [NSNumber numberWithInt:contentId],
                                                   @"response":response}}];
}
-(NSDictionary *)addUserAuthToDictionary:(NSDictionary *)infoDictionary{
    NSMutableDictionary *dictionaryWithUserAuth = [[NSMutableDictionary alloc] initWithDictionary:infoDictionary];
    [dictionaryWithUserAuth addEntriesFromDictionary:[self userAuthenticationParams]];
    return (NSDictionary *)dictionaryWithUserAuth;
}
- (ApiUser *)getUserFromDictionary:(NSDictionary *)userInfo{
    return [[ApiUser alloc] initWithTypeId:userInfo[@"user"][@"user_type_id"]
                                     email:userInfo[@"user"][@"email"]
                       authenticationToken:userInfo[@"user"][@"authentication_key"]
                                  signedIn:@YES];
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
