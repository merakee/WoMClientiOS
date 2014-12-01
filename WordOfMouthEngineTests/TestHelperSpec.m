//
//  TestHelperSpec.m
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 12/1/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import "TestHelperSpec.h"
#import "SpectaSetUp.h"
#import "ApiManager.h"
#import "PlaceHolderFactory.h"

@implementation TestHelperSpec
#pragma mark - Helper functions: Session
+(bool)signInUserWithEmail:(NSString *)email andPassword:(NSString *)password{
    __block bool isSuccess=false;
    __block kAPIUserType utype =    (email&&password)?kAPIUserTypeWom:kAPIUserTypeAnonymous;
    
    waitUntil(^(DoneCallback done) {
        [[ApiManager sharedApiManager] signInUserWithUserTypeId:utype
                                                          email:email
                                                       password:password
                                                        success:^(){
                                                            isSuccess=true;
                                                            done();
                                                        }
                                                        failure:^(NSError *error){
                                                            isSuccess=false;
                                                            done();
                                                        }];
    });
    return isSuccess;
}


+(bool)signUpUserWithEmail:(NSString *)email andPassword:(NSString *)password{
    __block bool isSuccess=false;
    waitUntil(^(DoneCallback done) {
        [[ApiManager sharedApiManager] signUpUserWithUserTypeId:kAPIUserTypeWom
                                                          email:email
                                                       password:password
                                           passwordConfirmation:password
                                                        success:^(){
                                                            isSuccess=true;
                                                            done();
                                                        }
                                                        failure:^(NSError *error){
                                                            isSuccess=false;
                                                            done();
                                                        }];
    });
    return isSuccess;
};

+(bool)signOutUser{
    __block bool isSuccess=false;
    ApiUser *user = [ApiManager sharedApiManager].apiUserManager.currentUser;
    
    if([user.userTypeId integerValue]==kAPIUserTypeAnonymous){
        [ApiManager sharedApiManager].apiUserManager.currentUser =nil;
        isSuccess = ![[ApiManager sharedApiManager] isUserSignedIn];
    }
    else{
        waitUntil(^(DoneCallback done) {
            [[ApiManager sharedApiManager] signOutUserSuccess:^{
                isSuccess=true;
                done();
            }
                                                      failure:^(NSError *error) {
                                                          isSuccess=false;
                                                          done();
                                                      }];
        });
    }
    
    
    return isSuccess;
};

#pragma mark - Helper functions: Content
+(int)postContent{
    __block int contentId;
    
    NSString *text =[PlaceHolderFactory  sentence];
    waitUntil(^(DoneCallback done) {
        [[ApiManager sharedApiManager] postContentWithCategoryId:kAPIContentCategoryNews
                                                            text:text
                                                           photo:nil
                                                         success:^(ApiContent *content) {
                                                             contentId = (int)[content.contentId integerValue];
                                                             done();
                                                         }
                                                         failure:^(NSError *error) {
                                                             contentId=0;
                                                             done();
                                                         }];
    });
    
    return contentId;
};


#pragma mark - Helper functions: Comment
+(int)postCommtentForContent:(int) contentId{
    __block int commentId;
    
    NSString *text =[PlaceHolderFactory  sentence];
    waitUntil(^(DoneCallback done) {
        [[ApiManager sharedApiManager] postCommentWithContentId:contentId
                                                           text:text
                                                        success:^(ApiComment *comment) {
                                                            commentId = (int)[comment.commentId integerValue];
                                                            done();
                                                        }
                                                        failure:^(NSError *error) {
                                                            commentId=0;
                                                            done();
                                                        }];
    });
    
    return commentId;
};

#pragma mark - Helper functions: Comment Like
+(int)likeCommtentWithId:(int)commentId{
    __block int commentResponseId;
    
    waitUntil(^(DoneCallback done) {
        [[ApiManager sharedApiManager] postCommentResponseWithCommentId:commentId
                                                                success:^(ApiCommentResponse *commentResponse) {
                                                                    commentResponseId = (int)[commentResponse.commentResponseId integerValue];
                                                                    done();
                                                                }
                                                                failure:^(NSError *error) {
                                                                    commentResponseId=0;
                                                                    done();
                                                                }];
    });
    
    return commentResponseId;
}

@end

