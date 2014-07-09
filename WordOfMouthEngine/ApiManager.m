//
//  ApiManager.m
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 11/9/13.
//  Copyright (c) 2013 Bijit Halder. All rights reserved.
//

#import "ApiManager.h"
#import "CommonUtility.h"

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
                NSLog(@"Network Reachable: WiFi");
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
    
    // set api user manager
    self.apiUserManager =[[ApiUserManager alloc] init];
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
-(BOOL)isNetworkReachable{
    return self.reachabilityManager.isReachable;
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

#pragma mark -  API Calls: User Session
- (BOOL)signUpUserWithUserTypeId:(int)userTypeId email:(NSString *)email password:(NSString *)password andPasswordConfirmation:(NSString *)passwordConfirmation{
    BOOL isReachable = [self isNetworkReachable];
    if(isReachable){
        [self POST:kAMAPI_SIGNUP_PATH parameters:[self userSignUpParamsWithUserTypeId:userTypeId email:email password:password  andPasswordConfirmation:passwordConfirmation]
           success:^(NSURLSessionDataTask *task, id responseObject) {
               if ([self.delegate respondsToSelector:@selector(apiManagerDidSignUpUser:)]) {
                   // save the user info
                   if([self.apiUserManager saveUserInfo:[self getUserFromDictionary:responseObject]]){
                       [self.delegate apiManagerDidSignUpUser:responseObject];
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
                   
               }}
           failure:^(NSURLSessionDataTask *task, NSError *error) {
               if ([self.delegate respondsToSelector:@selector(apiManagerUserSignUpFailedWithError:)]) {
                   [self.delegate apiManagerUserSignUpFailedWithError:error];
               }}];
    }
    return isReachable;
}
- (BOOL)signUpAnonynousUser{
    if ([self.delegate respondsToSelector:@selector(apiManagerSigningUpAnonymousUser)]) {
        [self.delegate apiManagerSigningUpAnonymousUser];
    }
    [self signUpUserWithUserTypeId:1 email:nil password:nil  andPasswordConfirmation:nil];
    
    return false;
}

- (BOOL)signInUserWithUserTypeId:(int)userTypeId email:(NSString *)email andPassword:(NSString *)password{
    if (userTypeId==1){
        return [self signInAnonymousUser];
    }
    
    BOOL isReachable = [self isNetworkReachable];
    if(isReachable){
        [self POST:kAMAPI_SIGNIN_PATH parameters:[self userSignInParamsWithEmail:email andPassword:password]
           success:^(NSURLSessionDataTask *task, id responseObject) {
               NSLog(@"%@",responseObject);
               if ([self.delegate respondsToSelector:@selector(apiManagerDidSignInUser:)]) {
                   [self.delegate apiManagerDidSignInUser:responseObject];
                   
               }}
           failure:^(NSURLSessionDataTask *task, NSError *error) {
               NSLog(@"%@",error);
               if ([self.delegate respondsToSelector:@selector(apiManagerUserSignInFailedWithError:)]) {
                   
                   [self.delegate apiManagerUserSignInFailedWithError:error];
               }}];
    }
    return isReachable;
}
- (BOOL)signInAnonymousUser{
    BOOL isSignedIn= [self.apiUserManager signInAnonymousUser];
    if(isSignedIn){
        return isSignedIn;
    }
    // sign up anonymous user
    return [self signUpAnonynousUser];
}

- (BOOL)signOutUser{
    BOOL isReachable = [self isNetworkReachable];
    if(isReachable){
        [self DELETE:kAMAPI_SIGNOUT_PATH parameters:[self userAuthenticationParams]
             success:^(NSURLSessionDataTask *task, id responseObject) {
                 if ([self.delegate respondsToSelector:@selector(apiManagerDidSignOutUser:)]) {
                     [self.delegate apiManagerDidSignOutUser:responseObject];
                 }}
             failure:^(NSURLSessionDataTask *task, NSError *error) {
                 if ([self.delegate respondsToSelector:@selector(apiManagerUserSignOutFailedWithError:)]) {
                     [self.delegate apiManagerUserSignOutFailedWithError:error];
                 }}];
    }
    return isReachable;
}

#pragma mark -  API Calls: User Profile
- (BOOL)getUserProfile{
    BOOL isReachable = [self isNetworkReachable];
    if(isReachable){
        [self GET:kAMAPI_PROFILE_PATH parameters:[self userAuthenticationParams]
          success:^(NSURLSessionDataTask *task, id responseObject) {
              if ([self.delegate respondsToSelector:@selector(apiManagerDidGetUserProfile:)]) {
                  [self.delegate apiManagerDidGetUserProfile:responseObject];
              }}
          failure:^(NSURLSessionDataTask *task, NSError *error) {
              if ([self.delegate respondsToSelector:@selector(apiManagerGetUserProfileFailedWithError:)]) {
                  [self.delegate apiManagerGetUserProfileFailedWithError:error];
              }}];
    }
    return isReachable;
}

- (BOOL)updateUserProfile{
    BOOL isReachable = [self isNetworkReachable];
    if(isReachable){
        [self PUT:kAMAPI_PROFILE_PATH parameters:[self userAuthenticationParams]
          success:^(NSURLSessionDataTask *task, id responseObject) {
              if ([self.delegate respondsToSelector:@selector(apiManagerDidUpdateUserProfile:)]) {
                  [self.delegate apiManagerDidUpdateUserProfile:responseObject];
              }}
          failure:^(NSURLSessionDataTask *task, NSError *error) {
              if ([self.delegate respondsToSelector:@selector(apiManagerUpdateUserProfileFailedWithError:)]) {
                  [self.delegate apiManagerUpdateUserProfileFailedWithError:error];
              }}];
    }
    return isReachable;
}

#pragma mark -  API Calls: Content
- (BOOL)getContent{
    BOOL isReachable = [self isNetworkReachable];
    if(isReachable){
        [self GET:kAMAPI_CONTENT_PATH parameters:[self userAuthenticationParams]
          success:^(NSURLSessionDataTask *task, id responseObject) {
              if ([self.delegate respondsToSelector:@selector(apiManagerDidGetContent:)]) {
                  [self.delegate apiManagerDidGetContent:responseObject];
              }}
          failure:^(NSURLSessionDataTask *task, NSError *error) {
              if ([self.delegate respondsToSelector:@selector(apiManagerGetContentFailedWithError:)]) {
                  [self.delegate apiManagerGetContentFailedWithError:error];
              }}];
    }
    return isReachable;
}
- (BOOL)postContentWithCategoryId:(int)categoryId andtext:(NSString *)text{
    BOOL isReachable = [self isNetworkReachable];
    if(isReachable){
        [self POST:kAMAPI_SIGNUP_PATH parameters:[self contentParamsWithCategoryId:categoryId andtext:text]
           success:^(NSURLSessionDataTask *task, id responseObject) {
               if ([self.delegate respondsToSelector:@selector(apiManagerDidPostContent:)]) {
                   [self.delegate apiManagerDidPostContent:responseObject];
               }}
           failure:^(NSURLSessionDataTask *task, NSError *error) {
               if ([self.delegate respondsToSelector:@selector(apiManagerPostContentFailedWithError:)]) {
                   [self.delegate apiManagerPostContentFailedWithError:error];
               }}];
    }
    return isReachable;
}

#pragma mark -  API Calls: Response
- (BOOL)postContentWithContentId:(int)contentId andResponse:(NSNumber *)response{
    BOOL isReachable = [self isNetworkReachable];
    if(isReachable){
        [self POST:kAMAPI_SIGNUP_PATH parameters:[self responseParamsWithContentId:contentId andResponse:response]
           success:^(NSURLSessionDataTask *task, id responseObject) {
               if ([self.delegate respondsToSelector:@selector(apiManagerDidPostResponse:)]) {
                   [self.delegate apiManagerDidPostResponse:responseObject];
               }}
           failure:^(NSURLSessionDataTask *task, NSError *error) {
               if ([self.delegate respondsToSelector:@selector(apiManagerPostResponseFailedWithError:)]) {
                   [self.delegate apiManagerPostResponseFailedWithError:error];
               }}];
    }
    return isReachable;
}

#pragma mark -  Utility Methods: JSON Request
-(NSDictionary *)userAuthenticationParams{
    return @{@"user":@{
                     @"user_type_id": self.apiUserManager.currentUser.userTypeId,
                     @"email":self.apiUserManager.currentUser.email,
                     @"authentication_token":self.apiUserManager.currentUser.authenticationToken}};
}
-(NSDictionary *)userSignInParamsWithEmail:(NSString *)email andPassword:(NSString *)password{
    if (email==nil){
        email=@"";
    }
    if(password==nil){
        password=@"";
    }
    return @{@"user":@{
                     @"email":email,
                     @"password":password}};
}
-(NSDictionary *)userSignUpParamsWithUserTypeId:(int)userTypeId email:(NSString *)email password:(NSString *)password andPasswordConfirmation:(NSString *)passwordConfirmation{
    if (email==nil){
        email=@"";
    }
    if(password==nil){
        password=@"";
    }
    if(passwordConfirmation==nil){
        passwordConfirmation=@"";
    }
    return @{@"user":@{
                     @"user_type_id": [NSNumber numberWithInt:userTypeId],
                     @"email":email,
                     @"password":password,
                     @"password_confirmation":passwordConfirmation}};
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
@end
