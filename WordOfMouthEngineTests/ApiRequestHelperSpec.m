//
//  ApiRequestHelperTests.m
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 12/1/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import "SpectaSetUp.h"
#import "ApiRequestHelper.h"
#import "PlaceHolderFactory.h"
#import "CommonUtility.h"

//SharedExamplesBegin(MySharedExamples)
//// Global shared examples are shared across all spec files.
//
////sharedExamplesFor(@"a shared behavior", ^(NSDictionary *data) {
////    it(@"should do some stuff", ^{
////        id obj = data[@"key"];
////        // ...
////    });
////});
//
//SharedExamplesEnd

SpecBegin(ApiRequestHelper)

describe(@"ApiRequestHelper", ^{
    
    // helper methods
    NSDictionary * (^createOneContentDictionaryWithError) (bool) = ^(bool error){
        NSDictionary *content =@{@"id":error?@-1:[NSNumber numberWithInt:[CommonUtility  pickRandom:40000]+1],
                                 @"text": [PlaceHolderFactory sentencesWithNumber:3],
                                 @"user_id": [NSNumber numberWithInt:[CommonUtility  pickRandom:1000]+1],
                                 @"content_category_id":[NSNumber numberWithInt:[CommonUtility  pickRandom:4]+1],
                                 @"photo_token": [PlaceHolderFactory word],
                                 @"total_spread":[NSNumber numberWithInt:[CommonUtility  pickRandom:1000]+1],
                                 @"spread_count":[NSNumber numberWithInt:[CommonUtility  pickRandom:1000]+1],
                                 @"kill_count":[NSNumber numberWithInt:[CommonUtility  pickRandom:1000]+1],
                                 @"comment_count":[NSNumber numberWithInt:[CommonUtility  pickRandom:100]+1],
                                 @"new_comment_count":[NSNumber numberWithInt:[CommonUtility  pickRandom:100]+1],
                                 @"created_at":[PlaceHolderFactory word],
                                 @"updated_at":[PlaceHolderFactory word]};
        return content;
    };
    
    NSDictionary * (^createContentDictionaryWithCount)(int, bool) = ^(int count, bool error){
        NSMutableArray  *array =[[NSMutableArray alloc] init];
        for(int ind =0; ind< count;ind++){
            [array addObject: createOneContentDictionaryWithError(error)];
        }
        return (NSDictionary *)@{@"contents":(NSArray *)array};
    };
    
    void (^checkMatchBetweenContentAndDictionary) (ApiContent *, NSDictionary *) = ^(ApiContent * content,NSDictionary * contentDic){
        expect(content.contentId).to.equal(contentDic[@"id"]);
        expect(content.contentText).to.equal(contentDic[@"text"]);
        expect(content.userId).to.equal(contentDic[@"user_id"]);
        expect(content.categoryId).to.equal(contentDic[@"content_category_id"]);
        expect(content.photoToken).to.equal(contentDic[@"photo_token"]);
        expect(content.totalSpread).to.equal(contentDic[@"total_spread"]);
        expect(content.spreadCount).to.equal(contentDic[@"spread_count"]);
        expect(content.killCount).to.equal(contentDic[@"kill_count"]);
        expect(content.commentCount).to.equal(contentDic[@"comment_count"]);
        expect(content.commentCountNew).to.equal(contentDic[@"new_comment_count"]);
        expect(content.createdAt).to.equal(contentDic[@"created_at"]);
        expect(content.updatedAt).to.equal(contentDic[@"updated_at"]);
    };
    
    void (^checkMatchBetweenContentArrayAndDictionary) (NSArray *, NSDictionary *) = ^(NSArray * array,NSDictionary * cDic){
        for(int ind =0; ind<[array count];ind++){
            ApiContent *content =array[ind];
            NSDictionary *contentDic = cDic[@"contents"][ind];
            checkMatchBetweenContentAndDictionary(content,contentDic);
        }
    };
    
    
    
    // set up all variables
    __block NSDictionary *cDic;
    __block NSArray *array;
    __block int cCount;
    
    //    sharedExamplesFor(@"another shared behavior", ^(NSDictionary *data) {
    //        // Locally defined shared examples can override global shared examples within its scope.
    //    });
    
    beforeAll(^{
        // This is run once and only once before all of the examples
        // in this group and before any beforeEach blocks.
    });
    
    beforeEach(^{
        // This is run before each example.
    });
    afterEach(^{
        // This is run after each example.
    });
    afterAll(^{
        // This is run once and only once after all of the examples
        // in this group and after any afterEach blocks.
    });
    
    describe(@"Api Content Array to Dictionary Conversion", ^{
        
        it(@"should pass nil dictionary",^{
            cDic = nil;
            array =[ApiRequestHelper getContentArrayFromDictionary:cDic];
            expect(array).notTo.beNil();
            expect([array count]).to.equal(0);
        });
        
        it(@"should pass empyt dictionary",^{
            cDic = @{@"contents": @[]};
            array =[ApiRequestHelper getContentArrayFromDictionary:cDic];
            expect(array).notTo.beNil();
            expect([array count]).to.equal(0);
        });
        
        it(@"should pass zero content",^{
            cCount=0;
            cDic =createContentDictionaryWithCount(cCount,false);
            array =[ApiRequestHelper getContentArrayFromDictionary:cDic];
            expect(array).notTo.beNil();
            expect([array count]).to.equal(cCount);
            checkMatchBetweenContentArrayAndDictionary(array,cDic);
        });
        
        it(@"should pass one content",^{
            cCount=1;
            cDic =createContentDictionaryWithCount(cCount,false);
            array =[ApiRequestHelper getContentArrayFromDictionary:cDic];
            expect(array).notTo.beNil();
            expect([array count]).to.equal(cCount);
            checkMatchBetweenContentArrayAndDictionary(array,cDic);
        });
        
        it(@"should pass 20 contents",^{
            cCount=20;
            cDic =createContentDictionaryWithCount(cCount,false);
            array =[ApiRequestHelper getContentArrayFromDictionary:cDic];
            expect(array).notTo.beNil();
            expect([array count]).to.equal(cCount);
            checkMatchBetweenContentArrayAndDictionary(array,cDic);
        });
        
        it(@"should pass contents with errors",^{
            // introduce error
            cCount=10;
            cDic =createContentDictionaryWithCount(cCount,true);
            array =[ApiRequestHelper getContentArrayFromDictionary:cDic];
            expect(array).to.beNil();
        });
        
    });
    
    
    NSDictionary * (^createContentResponseDictionary)() = ^{
        return @{@"content_response": @{@"user_id":[NSNumber numberWithInt:[CommonUtility  pickRandom:1000]+1],
                                     @"content_id":[NSNumber numberWithInt:[CommonUtility  pickRandom:2000]+1],
                                     @"response":[NSNumber numberWithBool:([CommonUtility pickRandom:2]>0)]}};
    };
    
    void (^ checkMatchBetweenResponseObjectAndDictionary) (ApiUserResponse *  , NSDictionary * ) = ^(ApiUserResponse * response , NSDictionary * rDic){
        expect(response.userId).to.equal(rDic[@"user_id"]);
        expect(response.contentId).to.equal(rDic[@"content_id"]);
        expect(response.userResponse).to.equal(rDic[@"response"]);
    };
    
    
    describe(@"Api Content Response to Dictionary Conversion", ^{
        
        it(@"should pass nil dictionary",^{
            for(int ind=0;ind<3;ind++){
                NSDictionary *rDic = createContentResponseDictionary();
                ApiUserResponse *response = [ApiRequestHelper getUserResponseFromDictionary:rDic];
                checkMatchBetweenResponseObjectAndDictionary(response,rDic[@"content_response"]);
            }
        });
    });
    
    
    NSDictionary * (^createContentFlagDictionary)() = ^{
        return @{@"content_flag": @{@"id":[NSNumber numberWithInt:[CommonUtility  pickRandom:1000]+1],
                                    @"content_id":[NSNumber numberWithInt:[CommonUtility  pickRandom:2000]+1],
                                    @"user_id":[NSNumber numberWithInt:[CommonUtility  pickRandom:1000]+1]}};
    };
    
    void (^ checkMatchBetweenContentFlagObjectAndDictionary) (ApiContentFlag *  , NSDictionary * ) = ^(ApiContentFlag *  cflag , NSDictionary * rDic){
        expect(cflag.userId).to.equal(rDic[@"user_id"]);
        expect(cflag.contentId).to.equal(rDic[@"content_id"]);
        expect(cflag.contentFlagId).to.equal(rDic[@"id"]);
    };
    
    describe(@"Api Content Flag to Dictionary Conversion", ^{
        
        it(@"should pass dictionary conversion",^{
            for(int ind=0;ind<3;ind++){
                NSDictionary *rDic = createContentFlagDictionary();
                ApiContentFlag *response = [ApiRequestHelper getContentFlagFromDictionary:rDic];
                checkMatchBetweenContentFlagObjectAndDictionary(response,rDic[@"content_flag"]);
            }
        });
    });
    
    
    
    NSDictionary * (^createOneCommentDictionaryWithError) (bool) = ^(bool error){
        NSDictionary *comment =@{@"id":error?@-1:[NSNumber numberWithInt:[CommonUtility  pickRandom:40000]+1],
                                 @"text": [PlaceHolderFactory sentencesWithNumber:3],
                                 @"user_id": [NSNumber numberWithInt:[CommonUtility  pickRandom:1000]+1],
                                 @"content_id": [NSNumber numberWithInt:[CommonUtility  pickRandom:1000]+1],
                                 @"like_count":[NSNumber numberWithInt:[CommonUtility  pickRandom:100]+1],
                                 @"new_like_count":[NSNumber numberWithInt:[CommonUtility  pickRandom:100]+1],
                                 @"did_like":[NSNumber numberWithBool:([CommonUtility pickRandom:2]>0)],
                                 @"created_at":[PlaceHolderFactory word],
                                 @"updated_at":[PlaceHolderFactory word]};
        return comment;
    };
    
    
    NSDictionary * (^createCommentDictionaryWithCount)(int, bool) = ^(int count, bool error){
        NSMutableArray  *array =[[NSMutableArray alloc] init];
        for(int ind =0; ind< count;ind++){
            [array addObject: createOneCommentDictionaryWithError(error)];
        }
        return (NSDictionary *)@{@"comments":(NSArray *)array};
    };
    
    void (^checkMatchBetweenCommentAndDictionary) (ApiComment *, NSDictionary *) = ^(ApiComment *comment,NSDictionary * commentDic){
        expect(comment.commentId).to.equal(commentDic[@"id"]);
        expect(comment.commentText).to.equal(commentDic[@"text"]);
        expect(comment.userId).to.equal(commentDic[@"user_id"]);
        expect(comment.userId).to.equal(commentDic[@"user_id"]);
        expect(comment.likeCount).to.equal(commentDic[@"like_count"]);
        expect(comment.likeCountNew).to.equal(commentDic[@"new_like_count"]);
        expect(comment.didLike).to.equal(commentDic[@"did_like"]);
        expect(comment.createdAt).to.equal(commentDic[@"created_at"]);
        expect(comment.updatedAt).to.equal(commentDic[@"updated_at"]);
    };
    
    void (^checkMatchBetweenCommentArrayAndDictionary) (NSArray *, NSDictionary *) = ^(NSArray * array,NSDictionary * cDic){
        for(int ind =0; ind<[array count];ind++){
            ApiComment *comment =array[ind];
            NSDictionary *commentDic = cDic[@"comments"][ind];
            checkMatchBetweenCommentAndDictionary(comment,commentDic);
        }
    };
    
    describe(@"Api Comment Array to Dictionary Conversion", ^{
        
        it(@"should pass nil dictionary",^{
            cDic = nil;
            array =[ApiRequestHelper getCommentArrayFromDictionary:cDic];
            expect(array).notTo.beNil();
            expect([array count]).to.equal(0);
        });
        
        it(@"should pass empyt dictionary",^{
            cDic = @{@"comments": @[]};
            array =[ApiRequestHelper getCommentArrayFromDictionary:cDic];
            expect(array).notTo.beNil();
            expect([array count]).to.equal(0);
        });
        
        it(@"should pass zero comment",^{
            cCount=0;
            cDic =createCommentDictionaryWithCount(cCount,false);
            array =[ApiRequestHelper getCommentArrayFromDictionary:cDic];
            expect(array).notTo.beNil();
            expect([array count]).to.equal(cCount);
            checkMatchBetweenCommentArrayAndDictionary(array,cDic);
        });
        
        it(@"should pass one comment",^{
            cCount=1;
            cDic =createCommentDictionaryWithCount(cCount,false);
            array =[ApiRequestHelper getCommentArrayFromDictionary:cDic];
            expect(array).notTo.beNil();
            expect([array count]).to.equal(cCount);
            checkMatchBetweenCommentArrayAndDictionary(array,cDic);
        });
        
        it(@"should pass 20 comments",^{
            cCount=20;
            cDic =createCommentDictionaryWithCount(cCount,false);
            array =[ApiRequestHelper getCommentArrayFromDictionary:cDic];
            expect(array).notTo.beNil();
            expect([array count]).to.equal(cCount);
            checkMatchBetweenCommentArrayAndDictionary(array,cDic);
        });
        
        it(@"should pass comments with errors",^{
            // introduce error
            cCount=10;
            cDic =createCommentDictionaryWithCount(cCount,true);
            array =[ApiRequestHelper getCommentArrayFromDictionary:cDic];
            expect(array).to.beNil();
        });
        
    });
    
    NSDictionary * (^createCommentResponseDictionary)() = ^{
        return @{@"comment_response": @{@"id":[NSNumber numberWithInt:[CommonUtility  pickRandom:1000]+1],
                                        @"user_id":[NSNumber numberWithInt:[CommonUtility  pickRandom:1000]+1],
                                        @"comment_id":[NSNumber numberWithInt:[CommonUtility  pickRandom:2000]+1],
                                        @"response":[NSNumber numberWithBool:([CommonUtility pickRandom:2]>0)]}};
    };
    
    void (^ checkMatchBetweenCommentResponseObjectAndDictionary) (ApiCommentResponse *  , NSDictionary * ) = ^(ApiCommentResponse * response , NSDictionary * rDic){
        expect(response.commentResponseId).to.equal(rDic[@"id"]);
        expect(response.userId).to.equal(rDic[@"user_id"]);
        expect(response.commentId).to.equal(rDic[@"comment_id"]);
        expect(response.commentResponse).to.equal(rDic[@"response"]);
    };
    
    
    describe(@"Api Comment Response to Dictionary Conversion", ^{
        
        it(@"should pass dictionary conversion",^{
            for(int ind=0;ind<3;ind++){
                NSDictionary *rDic = createCommentResponseDictionary();
                ApiCommentResponse *response = [ApiRequestHelper getCommentResponseFromDictionary:rDic];
                checkMatchBetweenCommentResponseObjectAndDictionary(response,rDic[@"comment_response"]);
            }
        });
    });
    
    NSDictionary * (^createNotificationDictionaryWithCount)(int, bool) = ^(int count, bool error){
        NSMutableArray  *array =[[NSMutableArray alloc] init];
        for(int ind =0; ind< count;ind++){
            if ([CommonUtility pickRandom:2]>0){
                [array addObject: createOneContentDictionaryWithError(error)];
            }
            else{
                [array addObject: createOneCommentDictionaryWithError(error)];
            }
        }
        return (NSDictionary *)@{@"notifications":(NSArray *)array};
    };
    
    void (^checkMatchBetweenNotificationArrayAndDictionary) (NSArray *, NSDictionary *) = ^(NSArray * array,NSDictionary * cDic){
        for(int ind =0; ind<[array count];ind++){
            NSDictionary *notificationDic = cDic[@"notifications"][ind];
            if(notificationDic[@"content_category_id"]){
                ApiContent *content =array[ind];
                checkMatchBetweenContentAndDictionary(content,notificationDic);
            }
            else{
                ApiComment *comment =array[ind];
                checkMatchBetweenCommentAndDictionary(comment,notificationDic);
            }
            
        }
        
    };
    
    describe(@"Api Notification Array to Dictionary Conversion", ^{
        
        it(@"should pass nil dictionary",^{
            cDic = nil;
            array =[ApiRequestHelper getNotificationArrayFromDictionary:cDic];
            expect(array).notTo.beNil();
            expect([array count]).to.equal(0);
        });
        
        it(@"should pass empyt dictionary",^{
            cDic = @{@"comments": @[]};
            array =[ApiRequestHelper getNotificationArrayFromDictionary:cDic];
            expect(array).notTo.beNil();
            expect([array count]).to.equal(0);
        });
        
        it(@"should pass zero comment",^{
            cCount=0;
            cDic =createNotificationDictionaryWithCount(cCount,false);
            array =[ApiRequestHelper getNotificationArrayFromDictionary:cDic];
            expect(array).notTo.beNil();
            expect([array count]).to.equal(cCount);
            checkMatchBetweenNotificationArrayAndDictionary(array,cDic);
        });
        
        it(@"should pass one comment",^{
            cCount=1;
            cDic =createNotificationDictionaryWithCount(cCount,false);
            array =[ApiRequestHelper getNotificationArrayFromDictionary:cDic];
            expect(array).notTo.beNil();
            expect([array count]).to.equal(cCount);
            checkMatchBetweenNotificationArrayAndDictionary(array,cDic);
        });
        
        it(@"should pass 20 comments",^{
            cCount=20;
            cDic =createNotificationDictionaryWithCount(cCount,false);
            array =[ApiRequestHelper getNotificationArrayFromDictionary:cDic];
            expect(array).notTo.beNil();
            expect([array count]).to.equal(cCount);
            checkMatchBetweenNotificationArrayAndDictionary(array,cDic);
        });
        
        it(@"should pass comments with errors",^{
            // introduce error
            cCount=10;
            cDic =createNotificationDictionaryWithCount(cCount,true);
            array =[ApiRequestHelper getNotificationArrayFromDictionary:cDic];
            expect(array).to.beNil();
        });
        
    });
    
    
    NSDictionary * (^createNotificationCountDictionary)() = ^{
        return @{@"comment_response": @{@"user_id":[NSNumber numberWithInt:[CommonUtility  pickRandom:1000]+1],
                                        @"total_new_count":[NSNumber numberWithInt:[CommonUtility  pickRandom:100]+1],
                                        @"new_comment_count":[NSNumber numberWithInt:[CommonUtility  pickRandom:100]+1],
                                        @"new_like_count":[NSNumber numberWithInt:[CommonUtility  pickRandom:100]+1]}};
    };
    
    void (^ checkMatchBetweenNotificationCountObjectAndDictionary) (ApiNotificationCount *  , NSDictionary * ) = ^(ApiNotificationCount * nCount, NSDictionary * rDic){
        expect(nCount.userId).to.equal(rDic[@"user_id"]);
        expect(nCount.totalNewCount).to.equal(rDic[@"total_new_count"]);
        expect(nCount.commentCountNew).to.equal(rDic[@"new_comment_count"]);
        expect(nCount.likeCountNew).to.equal(rDic[@"new_like_count"]);
    };
    
    
    describe(@"Api Comment Response to Dictionary Conversion", ^{
        it(@"should pass dictionary conversion",^{
            for(int ind=0;ind<3;ind++){
                NSDictionary *rDic = createNotificationCountDictionary();
                ApiNotificationCount *response = [ApiRequestHelper getNotificationCountFromDictionary:rDic];
                checkMatchBetweenNotificationCountObjectAndDictionary(response,rDic[@"notifications"]);
            }
        });
    });
});

SpecEnd
