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
    //                NSLog(@"Network Reachable ---: WiFi");
    //                //[operationQueue setSuspended:NO];
    //                //networkReachable = YES;
    //                break;
    //            case AFNetworkReachabilityStatusNotReachable:
    //                NSLog(@"Network Not Reachable ");
    //                break;
    //            default:
    //                NSLog(@"Network Reachable: default");
    //                //[operationQueue setSuspended:YES];
    //                //networkReachable = NO;
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

- (BOOL)isAnonymousUser{
    return self.apiUserManager.currentUser.userTypeId.integerValue == kAPIUserTypeAnonymous;
}

#pragma mark -  API Calls: User Session - Sign up
- (void)signUpUserWithUserTypeId:(int)userTypeId
                           email:(NSString *)email_
                        password:(NSString *)password_
            passwordConfirmation:(NSString *)passwordConfirmation_
                         success:(void (^)())success
                         failure:(void (^)(NSError *error))failure{
    // process and validate
    NSString * email = [CommonUtility trimString:email_];
    NSString * password = [CommonUtility trimString:password_];
    NSString * passwordConfirmation = [CommonUtility trimString:passwordConfirmation_];
    NSError *verror =[ApiValidationManager validateSignUpWithUserTypeId:userTypeId
                                                                  email:email
                                                               password:password
                                                   passwordConfirmation:passwordConfirmation];
    if(verror){
        failure(verror);
        return;
    }
    
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
    // sign in user and save user info
    return [self actionsForSuccessfulSignInWithResponse:responseObject];
}
- (NSError *)actionsForFailedSignUpWithError:(NSError *)error{
    return [ApiErrorManager processSignUpError:error];
}

#pragma mark -  API Calls: User Session - Sign In
- (void)signInUserWithUserTypeId:(int)userTypeId
                           email:(NSString *)email_
                        password:(NSString *)password_
                         success:(void (^)())success
                         failure:(void (^)(NSError *error))failure{
    
    // check to see if there is exiciting anonymou user. If yes, singin with that user
    if (userTypeId==kAPIUserTypeAnonymous){
        if([self.apiUserManager signInAnonymousUser]){
            success();
        }
        else{
            [self signUpUserWithUserTypeId:userTypeId
                                     email:nil
                                  password:nil
                      passwordConfirmation:nil
                                   success:^(){
                                       success();
                                   }
                                   failure:^(NSError *error){
                                       failure(error);
                                   }];
        }
        return;
    }
    
    // process and validate
    NSString * email = [CommonUtility trimString:email_];
    NSString * password = [CommonUtility trimString:password_];
    NSError *verror =[ApiValidationManager validateSignInWithUserTypeId:userTypeId
                                                                  email:email
                                                               password:password];
    if(verror){
        failure(verror);
        return;
    }
    
    // post vlidation
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
    NSError *error=nil;
    
    // save the user info
    // get user info
    ApiUser *user = [ApiRequestHelper getUserFromDictionary:responseObject];
    
    if(![ApiUser isValidUser:user]){
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
- (void)anonymousUserSignInErrorAction:(NSError *)error{
    if(![self isAnonymousUser]){
        return;
    }
    // if anonymous user in local DB does not match Backend: delete it from local DB
    NSError *perror= [ApiErrorManager processGetContentError:error];
    if([perror.localizedFailureReason rangeOfString:@"(401)"].location!=NSNotFound){
        [[[ApiUserDatabase alloc] init] deleteAnonymousUserInfo];
    }
    
}
#pragma mark -  API Calls: User Session - Sign Out
- (void)signOutUserSuccess:(void (^)())success
                   failure:(void (^)(NSError *error))failure{
    [self DELETE:kAMAPI_SIGNOUT_PATH parameters:[ApiRequestHelper userAuthenticationParams:self.apiUserManager.currentUser]
         success:^(NSURLSessionDataTask *task, id responseObject) {
             NSError *error = [self actionsForSuccessfulSignOutWithResponse:responseObject];
             if(error){
                 failure(error);
             }
             else{
                 success();
             }
         }
         failure:^(NSURLSessionDataTask *task, NSError *error) {
             failure([self actionsForFailedSignOutWithError:error]);
         }];
}
- (NSError *)actionsForSuccessfulSignOutWithResponse:(id)responseObject{
    NSError *error=nil;
    if(![self.apiUserManager signOutUser]){
        error =  [ApiErrorManager getErrorForInternalError];
    }
    return error;
}
- (NSError *)actionsForFailedSignOutWithError:(NSError *)error{
    return [ApiErrorManager processSignOutError:error];
}
#pragma mark -  API Calls: User Profile
//- (void)getUserProfileSuccess:(void (^)())success
//                      failure:(void (^)(NSError *error))failure;{
//
//
//    [self GET:kAMAPI_PROFILE_PATH parameters:[ApiRequestHelper userAuthenticationParams:self.apiUserManager.currentUser]
//      success:^(NSURLSessionDataTask *task, id responseObject) {
//          [self actionsForSuccessfulGetUserProfileWithResponse:responseObject];
//          success();
//      }
//      failure:^(NSURLSessionDataTask *task, NSError *error) {
//          failure([self actionsForFailedGetUserProfileWithError:error]);
//      }];
//
//}

//- (void)actionsForSuccessfulGetUserProfileWithResponse:(id)responseObject{
//
//}
//- (NSError *)actionsForFailedGetUserProfileWithError:(NSError *)error{
//    return [ApiErrorManager processGetProfileError:error];
//}
//
//- (void)updateUserProfileSuccess:(void (^)())success
//                         failure:(void (^)(NSError *error))failure{
//
//    [self PUT:kAMAPI_PROFILE_PATH parameters:[ApiRequestHelper userAuthenticationParams:self.apiUserManager.currentUser]
//      success:^(NSURLSessionDataTask *task, id responseObject) {
//          [self actionsForSuccessfulUpdateUserProfileWithResponse:responseObject];
//          success();
//      }
//      failure:^(NSURLSessionDataTask *task, NSError *error) {
//          failure([self actionsForFailedUpdateUserProfileWithError:error]);
//      }];
//}
//
//- (void)actionsForSuccessfulUpdateUserProfileWithResponse:(id)responseObject{
//
//}
//- (NSError *)actionsForFailedUpdateUserProfileWithError:(NSError *)error{
//    return [ApiErrorManager processUpdateProfileError:error];
//}


#pragma mark -  API Calls: Content
- (void)getContentListSuccess:(void (^)(NSArray *contentArray))success
                      failure:(void (^)(NSError *error))failure{
    
    [self POST:kAMAPI_GET_CONTENT_LIST_PATH parameters:[ApiRequestHelper userAuthenticationParams:self.apiUserManager.currentUser]
       success:^(NSURLSessionDataTask *task, id responseObject) {
           NSError *error;
           NSArray *contentArray = [self actionsForSuccessfulGetContentListWithResponse:responseObject withError:&error];
           if(error){
               failure(error);
           }
           else{
               success(contentArray);
           }
       }
       failure:^(NSURLSessionDataTask *task, NSError *error) {
           failure([self actionsForFailedGetContentWithError:error]);
       }];
}

- (void)getContentWithId:(int)contentId
                 success:(void (^)(ApiContent *))success
                 failure:(void (^)(NSError *error))failure{
    
    [self POST:kAMAPI_GET_CONTENT_PATH parameters:[ApiRequestHelper getContentParamsWithUser:self.apiUserManager.currentUser contentId:contentId]
       success:^(NSURLSessionDataTask *task, id responseObject) {
           NSError *error;
           ApiContent *content = [self actionsForSuccessfulGetContentWithResponse:responseObject withError:&error];
           if(error){
               failure(error);
           }
           else{
               success(content);
           }
       }
       failure:^(NSURLSessionDataTask *task, NSError *error) {
           failure([self actionsForFailedGetContentWithError:error]);
       }];
}

- (NSArray *)actionsForSuccessfulGetContentListWithResponse:(id)responseObject withError:(NSError **)error{
    // get userResponse info
    NSArray *contentArray = [ApiRequestHelper getContentArrayFromDictionary:responseObject];
    // check validity of the userResponse
    if(!contentArray){
        if(error){
            *error = [ApiErrorManager getErrorForInvalidApiResponse];;
        }
    }
    return contentArray;
}

- (ApiContent *)actionsForSuccessfulGetContentWithResponse:(id)responseObject withError:(NSError **)error{
    // get content info
    ApiContent *content = [ApiRequestHelper getContentFromDictionary:responseObject];
    
    // check validity of the content
    if(![ApiContent isValidContent:content]){
        if(error){
            *error = [ApiErrorManager getErrorForInvalidApiResponse];;
        }
        return nil;
    }
    
    return content;
}


- (NSError *)actionsForFailedGetContentWithError:(NSError *)error{
    // check for anonymous user
    [self anonymousUserSignInErrorAction:error];
    return [ApiErrorManager processGetContentError:error];
}

- (void)postContentWithCategoryId:(int)categoryId
                             text:(NSString *)text_
                            photo:(UIImage *)photo
                          success:(void (^)(ApiContent * content))success
                          failure:(void (^)(NSError *error))failure{
    // process and validate
    NSString * text = [CommonUtility trimString:text_];
    NSError *verror =[ApiValidationManager validatePostContentWithCategoryId:categoryId text:text andPhoto:photo];
    if(verror){
        failure(verror);
        return;
    }
    
    [self POST:kAMAPI_POST_CONTENT_PATH parameters:[ApiRequestHelper contentParamsWithUser:self.apiUserManager.currentUser categoryId:categoryId text:text_ photo_token:photo]
       success:^(NSURLSessionDataTask *task, id responseObject) {
           NSError *error;
           ApiContent * content = [self actionsForSuccessfulPostContentWithResponse:responseObject andError:&error];
           if(error){
               failure(error);
           }
           else{
               success(content);
           }
       }
       failure:^(NSURLSessionDataTask *task, NSError *error) {
           failure([self actionsForFailedPostContentWithError:error]);
       }];
}
- (ApiContent *)actionsForSuccessfulPostContentWithResponse:(id)responseObject andError:(NSError **)error{
    // get content info
    ApiContent *content = [ApiRequestHelper getContentFromDictionary:responseObject];
    
    // check validity of the content
    if(![ApiContent isValidContent:content]){
        if(error){
            *error = [ApiErrorManager getErrorForInvalidApiResponse];;
        }
        return nil;
    }
    
    return content;
}
- (NSError *)actionsForFailedPostContentWithError:(NSError *)error{
    return [ApiErrorManager processPostContentError:error];
}

#pragma mark -  API Calls: Content Response
- (void)postResponseWithContentId:(int)contentId
                         response:(NSNumber *)response
                          success:(void (^)(ApiUserResponse *userResponse))success
                          failure:(void (^)(NSError *error))failure{
    
    // fail if response is empty
    if(!response){
        failure([ApiErrorManager getErrorForInvalidParameters]);
        return;
    }
    
    [self POST:kAMAPI_POST_CONTENT_RESPONSE_PATH parameters:[ApiRequestHelper responseParamsWithUser:self.apiUserManager.currentUser contentId:contentId andResponse:response]
       success:^(NSURLSessionDataTask *task, id responseObject) {
           NSError *error;
           ApiUserResponse *userResponse = [self actionsForSuccessfulPostResponseWithResponse:responseObject withError:&error];
           if(error){
               failure(error);
           }
           else{
               success(userResponse);
           }
       }
       failure:^(NSURLSessionDataTask *task, NSError *error) {
           failure([self actionsForFailedPostResonseWithError:error]);
       }];
}


- (ApiUserResponse *)actionsForSuccessfulPostResponseWithResponse:(id)responseObject withError:(NSError **)error{
    // get userResponse info
    ApiUserResponse *userResponse = [ApiRequestHelper getUserResponseFromDictionary:responseObject];
    
    // check validity of the userResponse
    if(![ApiUserResponse isValidUserResponse:userResponse]){
        if(error){
            *error = [ApiErrorManager getErrorForInvalidApiResponse];;
        }
        return nil;
    }
    
    return userResponse;
}
- (NSError *)actionsForFailedPostResonseWithError:(NSError *)error{
    //DBLog(@"Post Response Error: %@",error);
    return [ApiErrorManager processPostResponseError:error];
}

#pragma mark -  API Calls: Content Flag
- (void)flagContentWithId:(int)contentId
                  success:(void (^)(ApiContentFlag * contentFlag))success
                  failure:(void (^)(NSError *error))failure{
    
    [self POST:kAMAPI_FLAG_CONTENT_PATH parameters:[ApiRequestHelper flagContentParamsWithUser:self.apiUserManager.currentUser contentId:contentId]
       success:^(NSURLSessionDataTask *task, id responseObject) {
           NSError *error;
           ApiContentFlag *contentFlag = [self actionsForSuccessfulFlagContentWithResponse:responseObject withError:&error];
           if(error){
               failure(error);
           }
           else{
               success(contentFlag);
           }
       }
       failure:^(NSURLSessionDataTask *task, NSError *error) {
           failure([self actionsForFailedPostResonseWithError:error]);
       }];
}


- (ApiContentFlag *)actionsForSuccessfulFlagContentWithResponse:(id)responseObject withError:(NSError **)error{
    // get ApiContentFlag
    ApiContentFlag *contentFlag = [ApiRequestHelper getContentFlagFromDictionary:responseObject];
    
    // check validity of the ContentFlag
    if(![ApiContentFlag isValidContentFlag:contentFlag]){
        if(error){
            *error = [ApiErrorManager getErrorForInvalidApiResponse];;
        }
        return nil;
    }
    
    return contentFlag;
}
- (NSError *)actionsForFailedFlagContentWithError:(NSError *)error{
    //DBLog(@"Post Response Error: %@",error);
    return [ApiErrorManager processFlagContentError:error];
}


#pragma mark -  API Calls: Comment
- (void)getCommentsForContentId:(int)contentId
                           mode:(kAPICommentOrderMode)mode
                          count:(int)count
                         offset:(int)offset
                        success:(void (^)(NSArray *commentArray))success
                        failure:(void (^)(NSError *error))failure{
    
    [self POST:kAMAPI_GET_COMMENT_LIST_PATH parameters:[ApiRequestHelper getCommentsParamsWithUser:self.apiUserManager.currentUser
                                                                                         contentId:contentId
                                                                                              mode:mode
                                                                                             count:count
                                                                                            offset:offset]
       success:^(NSURLSessionDataTask *task, id responseObject) {
           NSError *error;
           NSArray *commentArray = [self actionsForSuccessfulGetCommentWithResponse:responseObject withError:&error];
           if(error){
               failure(error);
           }
           else{
               success(commentArray);
           }
       }
       failure:^(NSURLSessionDataTask *task, NSError *error) {
           failure([self actionsForFailedGetCommentWithError:error]);
       }];
}

- (NSArray *)actionsForSuccessfulGetCommentWithResponse:(id)responseObject withError:(NSError **)error{
    // get Response info
    NSArray *commentArray = [ApiRequestHelper getCommentArrayFromDictionary:responseObject];
    // check validity of the Response
    if(!commentArray){
        if(error){
            *error = [ApiErrorManager getErrorForInvalidApiResponse];;
        }
    }
    return commentArray;
}


- (NSError *)actionsForFailedGetCommentWithError:(NSError *)error{
    // check for anonymous user
    [self anonymousUserSignInErrorAction:error];
    return [ApiErrorManager processGetCommentError:error];
}

- (void)postCommentWithContentId:(int)contentId
                            text:(NSString *)text_
                         success:(void (^)(ApiComment * comment))success
                         failure:(void (^)(NSError *error))failure{
    // process and validate
    NSString * text = [CommonUtility trimString:text_];
    NSError *verror =[ApiValidationManager validatePostCommentWithText:text];
    if(verror){
        failure(verror);
        return;
    }
    
    [self POST:kAMAPI_POST_COMMENT_PATH parameters:[ApiRequestHelper commentParamsWithUser:self.apiUserManager.currentUser contentId:contentId text:text_]
       success:^(NSURLSessionDataTask *task, id responseObject) {
           NSError *error;
           ApiComment * comment = [self actionsForSuccessfulPostCommentWithResponse:responseObject andError:&error];
           if(error){
               failure(error);
           }
           else{
               success(comment);
           }
       }
       failure:^(NSURLSessionDataTask *task, NSError *error) {
           failure([self actionsForFailedPostCommentWithError:error]);
       }];
}
- (ApiComment *)actionsForSuccessfulPostCommentWithResponse:(id)responseObject andError:(NSError **)error{
    // get comment info
    ApiComment *comment = [ApiRequestHelper getCommentFromDictionary:responseObject];
    
    // check validity of the comment
    if(![ApiComment isValidComment:comment]){
        if(error){
            *error = [ApiErrorManager getErrorForInvalidApiResponse];;
        }
        return nil;
    }
    
    return comment;
}
- (NSError *)actionsForFailedPostCommentWithError:(NSError *)error{
    return [ApiErrorManager processPostCommentError:error];
}

#pragma mark-  API Calls: Comment Response
- (void)postCommentResponseWithCommentId:(int)commentId
                                response:(NSNumber *)response
                                 success:(void (^)(ApiCommentResponse *commentResponse))success
                                 failure:(void (^)(NSError *error))failure{
    
    // fail if response is empty
    if(!response){
        failure([ApiErrorManager getErrorForInvalidParameters]);
        return;
    }
    
    [self POST:kAMAPI_POST_COMMENT_RESPONSE_PATH parameters:[ApiRequestHelper commentResponseParamsWith:self.apiUserManager.currentUser commentId:commentId andResponse:response]
       success:^(NSURLSessionDataTask *task, id responseObject) {
           NSError *error;
           ApiCommentResponse *commentResponse = [self actionsForSuccessfulPostCommentResponseWithResponse:responseObject withError:&error];
           if(error){
               failure(error);
           }
           else{
               success(commentResponse);
           }
       }
       failure:^(NSURLSessionDataTask *task, NSError *error) {
           failure([self actionsForFailedPostCommentResonseWithError:error]);
       }];
}

- (void)postCommentResponseWithCommentId:(int)commentId
                                 success:(void (^)(ApiCommentResponse *commentResponse))success
                                 failure:(void (^)(NSError *error))failure{
    
    [self POST:kAMAPI_POST_COMMENT_RESPONSE_PATH parameters:[ApiRequestHelper commentResponseParamsWith:self.apiUserManager.currentUser commentId:commentId]
       success:^(NSURLSessionDataTask *task, id responseObject) {
           NSError *error;
           ApiCommentResponse *commentResponse = [self actionsForSuccessfulPostCommentResponseWithResponse:responseObject withError:&error];
           if(error){
               failure(error);
           }
           else{
               success(commentResponse);
           }
       }
       failure:^(NSURLSessionDataTask *task, NSError *error) {
           failure([self actionsForFailedPostCommentResonseWithError:error]);
       }];
}

- (ApiCommentResponse *)actionsForSuccessfulPostCommentResponseWithResponse:(id)responseObject withError:(NSError **)error{
    // get commentResponse info
    ApiCommentResponse *commentResponse = [ApiRequestHelper getCommentResponseFromDictionary:responseObject];
    
    // check validity of the commentResponse
    if(![ApiCommentResponse isValidCommentResponse:commentResponse]){
        if(error){
            *error = [ApiErrorManager getErrorForInvalidApiResponse];;
        }
        return nil;
    }
    
    return commentResponse;
}
- (NSError *)actionsForFailedPostCommentResonseWithError:(NSError *)error{
    //DBLog(@"Post Response Error: %@",error);
    return [ApiErrorManager processPostResponseError:error];
}


#pragma mark -  API Calls: History
- (void)getHistoryOfContentsWithCount:(int)count
                               offset:(int)offset
                              success:(void (^)(NSArray * contentArray))success
                              failure:(void (^)(NSError *error))failure{
    // check for anonymous user
    if([self isAnonymousUser]){
        failure([ApiErrorManager getErrorForInvalidRequestForAnonymousUser]);
        return;
    }
    
    [self POST:kAMAPI_GET_HISTORY_CONTENTS_PATH parameters:[ApiRequestHelper getHistoryParamsWithUser:self.apiUserManager.currentUser
                                                                                                count:count
                                                                                               offset:offset]
       success:^(NSURLSessionDataTask *task, id responseObject) {
           NSError *error;
           NSArray *contentsArray = [self actionsForSuccessfulGetHistoryContentsWithResponse:responseObject withError:&error];
           if(error){
               failure(error);
           }
           else{
               success(contentsArray);
           }
       }
       failure:^(NSURLSessionDataTask *task, NSError *error) {
           failure([self actionsForFailedGetHistoryWithError:error]);
       }];
    
}

- (NSArray *)actionsForSuccessfulGetHistoryContentsWithResponse:(id)responseObject withError:(NSError **)error{
    // get Response info
    NSArray *contentArray = [ApiRequestHelper getContentArrayFromDictionary:responseObject];
    // check validity of the Response
    if(!contentArray){
        if(error){
            *error = [ApiErrorManager getErrorForInvalidApiResponse];;
        }
    }
    return contentArray;
}

- (void)getHistoryOfCommentsWithCount:(int)count
                               offset:(int)offset
                              success:(void (^)(NSArray * commentArray))success
                              failure:(void (^)(NSError *error))failure{
    // check for anonymous user
    if([self isAnonymousUser]){
        failure([ApiErrorManager getErrorForInvalidRequestForAnonymousUser]);
        return;
    }
    
    [self POST:kAMAPI_GET_HISTORY_COMMENTS_PATH parameters:[ApiRequestHelper getHistoryParamsWithUser:self.apiUserManager.currentUser
                                                                                                count:count
                                                                                               offset:offset]
       success:^(NSURLSessionDataTask *task, id responseObject) {
           NSError *error;
           NSArray *commentsArray = [self actionsForSuccessfulGetHistoryCommentsWithResponse:responseObject withError:&error];
           if(error){
               failure(error);
           }
           else{
               success(commentsArray);
           }
       }
       failure:^(NSURLSessionDataTask *task, NSError *error) {
           failure([self actionsForFailedGetHistoryWithError:error]);
       }];
    
}

- (NSArray *)actionsForSuccessfulGetHistoryCommentsWithResponse:(id)responseObject withError:(NSError **)error{
    // get Response info
    NSArray *commentArray = [ApiRequestHelper getCommentArrayFromDictionary:responseObject];
    // check validity of the Response
    if(!commentArray){
        if(error){
            *error = [ApiErrorManager getErrorForInvalidApiResponse];;
        }
    }
    return commentArray;
}

- (NSError *)actionsForFailedGetHistoryWithError:(NSError *)error{
    return [ApiErrorManager processGetHistoryError:error];
}

#pragma mark -  API Calls: Notifications
- (void)getNotificationCountSuccess:(void (^)(ApiNotificationCount *))success
                            failure:(void (^)(NSError *error))failure{
    // check for anonymous user
    if([self isAnonymousUser]){
        failure([ApiErrorManager getErrorForInvalidRequestForAnonymousUser]);
        return;
    }
    
    [self POST:kAMAPI_GET_NOTIFICATION_COUNT_PATH parameters:[ApiRequestHelper userAuthenticationParams:self.apiUserManager.currentUser]
       success:^(NSURLSessionDataTask *task, id responseObject) {
           NSError *error;
           ApiNotificationCount *notificationCount = [self actionsForSuccessfulGetNotificationCountWithResponse:responseObject withError:&error];
           if(error){
               failure(error);
           }
           else{
               success(notificationCount);
           }
       }
       failure:^(NSURLSessionDataTask *task, NSError *error) {
           failure([self actionsForFailedGetNotificationCountWithError:error]);
       }];
    
    
}

- (ApiNotificationCount *)actionsForSuccessfulGetNotificationCountWithResponse:(id)responseObject withError:(NSError **)error{
    // get Api Notification Count
    ApiNotificationCount *notificationCount = [ApiRequestHelper getNotificationCountFromDictionary:responseObject];
    
    // check validity of the content
    if(![ApiNotificationCount isValidNotificationCount:notificationCount]){
        if(error){
            *error = [ApiErrorManager getErrorForInvalidApiResponse];;
        }
        return nil;
    }
    
    return notificationCount;
}

- (NSError *)actionsForFailedGetNotificationCountWithError:(NSError *)error{
    return [ApiErrorManager processGetNotificationCountError:error];
}

- (void)getNotificationListSuccess:(void (^)(NSArray * notificationArray))success
                           failure:(void (^)(NSError *error))failure{
    // check for anonymous user
    if([self isAnonymousUser]){
        failure([ApiErrorManager getErrorForInvalidRequestForAnonymousUser]);
        return;
    }
    
    [self POST:kAMAPI_GET_NOTIFICATION_LIST_PATH parameters:[ApiRequestHelper userAuthenticationParams:self.apiUserManager.currentUser]
       success:^(NSURLSessionDataTask *task, id responseObject) {
           NSError *error;
           NSArray *notificationArray = [self actionsForSuccessfulGetNotificationListWithResponse:responseObject withError:&error];
           if(error){
               failure(error);
           }
           else{
               success(notificationArray);
           }
       }
       failure:^(NSURLSessionDataTask *task, NSError *error) {
           failure([self actionsForFailedGetNotificationListWithError:error]);
       }];
    
    
}

- (NSArray *)actionsForSuccessfulGetNotificationListWithResponse:(id)responseObject withError:(NSError **)error{
    // get userResponse info
    NSArray *notificationArray = [ApiRequestHelper getNotificationArrayFromDictionary:responseObject];
    // check validity of the userResponse
    if(!notificationArray){
        if(error){
            *error = [ApiErrorManager getErrorForInvalidApiResponse];;
        }
    }
    return notificationArray;
}

- (NSError *)actionsForFailedGetNotificationListWithError:(NSError *)error{
    return [ApiErrorManager processGetNotificationListError:error];
}

#pragma mark -  API Calls: Notifications Reset
- (void)resetNotificationCountForContent:(int)contentId
                               withCount:(int)count
                                 success:(void (^)(ApiContent * content))success
                                 failure:(void (^)(NSError *error))failure{
    
    // check for anonymous user
    if([self isAnonymousUser]){
        failure([ApiErrorManager getErrorForInvalidRequestForAnonymousUser]);
        return;
    }
    
    [self POST:kAMAPI_RESET_NOTIFICATION_CONTENT_PATH parameters:[ApiRequestHelper getResetNotificationContentParamsWithUser:self.apiUserManager.currentUser
                                                                                                                  contentId:contentId
                                                                                                                       count:count]
       success:^(NSURLSessionDataTask *task, id responseObject) {
           NSError *error;
           ApiContent *content = [self actionsForSuccessfulResetNotificationContentWithResponse:responseObject withError:&error];
           if(error){
               failure(error);
           }
           else{
               success(content);
           }
       }
       failure:^(NSURLSessionDataTask *task, NSError *error) {
           failure([self actionsForFailedResetNotificationContentWithError:error]);
       }];
    
}

- (ApiContent *)actionsForSuccessfulResetNotificationContentWithResponse:(id)responseObject withError:(NSError **)error{
    // get content info
    ApiContent *content = [ApiRequestHelper getContentFromDictionary:responseObject];
    
    // check validity of the content
    if(![ApiContent isValidContent:content]){
        if(error){
            *error = [ApiErrorManager getErrorForInvalidApiResponse];;
        }
        return nil;
    }
    return content;
}


- (NSError *)actionsForFailedResetNotificationContentWithError:(NSError *)error{
    return [ApiErrorManager processResetNotificationContentError:error];
}

- (void)resetNotificationCountForComment:(int)commentId
                               withCount:(int)count
                                 success:(void (^)(ApiComment * comment))success
                                 failure:(void (^)(NSError *error))failure{
    // check for anonymous user
    if([self isAnonymousUser]){
        failure([ApiErrorManager getErrorForInvalidRequestForAnonymousUser]);
        return;
    }
    
    
    [self POST:kAMAPI_RESET_NOTIFICATION_COMMENT_PATH parameters:[ApiRequestHelper getResetNotificationCommentParamsWithUser:self.apiUserManager.currentUser
                                                                                                                   commentId:commentId
                                                                                                                       count:count]
       success:^(NSURLSessionDataTask *task, id responseObject) {
           NSError *error;
           ApiComment *comment = [self actionsForSuccessfulResetNotificationCommentWithResponse:responseObject withError:&error];
           if(error){
               failure(error);
           }
           else{
               success(comment);
           }
       }
       failure:^(NSURLSessionDataTask *task, NSError *error) {
           failure([self actionsForFailedResetNotificationCommentWithError:error]);
       }];
    
}

- (ApiComment *)actionsForSuccessfulResetNotificationCommentWithResponse:(id)responseObject withError:(NSError **)error{
    // get comment info
    ApiComment *comment = [ApiRequestHelper getCommentFromDictionary:responseObject];
    
    // check validity of the comment
    if(![ApiComment isValidComment:comment]){
        if(error){
            *error = [ApiErrorManager getErrorForInvalidApiResponse];;
        }
        return nil;
    }
    return comment;
}


- (NSError *)actionsForFailedResetNotificationCommentWithError:(NSError *)error{
    return [ApiErrorManager processResetNotificationCommentError:error];
}

#pragma mark -  Test Code
+ (void)test {
    /*BOOL isSuccessful =[[ApiManager sharedApiManager] signUpUserWithUserTypeId:kAPIUserTypeWom
     email:nil
     password:nil
     andPasswordConfirmation:nil];
     */
    //NSLog(@"Is sucessful: %d",isSuccessful);
    //ApiComment *acom = [ApiRequestHelper getCommentFromDictionary:@{@"comment":@{@"id":@2354,@"content_id":@2,@"user_id":@5,@"text":@"this is test",@"did_like":@false}}];
    //[ApiComment printCommentInfo:acom];
    
}


@end
