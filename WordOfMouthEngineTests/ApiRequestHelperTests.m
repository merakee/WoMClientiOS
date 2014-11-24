//
//  ApiRequestHelperTests.m
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 7/16/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ApiRequestHelper.h"
#import "PlaceHolderFactory.h"
#import "CommonUtility.h"

@interface ApiRequestHelperTests : XCTestCase

@end

@implementation ApiRequestHelperTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


#pragma mark - api content
- (void)testApiRequestHelperGetContantArray{
    NSDictionary *cDic = nil;
    NSArray *array =[ApiRequestHelper getContentArrayFromDictionary:cDic];
    XCTAssertNotNil(array,@"Array should not be nil");
    XCTAssert([array count]==0,@"Array Must be empty");
    
    cDic = @{@"contents": @[]};
    array =[ApiRequestHelper getContentArrayFromDictionary:cDic];
    XCTAssertNotNil(array,@"Array should not be nil");
    XCTAssert([array count]==0,@"Array Must be empty");
    
    int cCount=0;
    cDic =[self createContentDictionaryWithCount:cCount withError:false];
    array =[ApiRequestHelper getContentArrayFromDictionary:cDic];
    XCTAssertNotNil(array,@"Array should not be nil");
    XCTAssert([array count]==cCount,@"Array Must be of length %d",cCount);
    [self checkMatchBetweenArray:array  andDictionary:cDic];
    
    cCount=1;
    cDic =[self createContentDictionaryWithCount:cCount withError:false];
    array =[ApiRequestHelper getContentArrayFromDictionary:cDic];
    XCTAssertNotNil(array,@"Array should not be nil");
    XCTAssert([array count]==cCount,@"Array Must be of length %d",cCount);
    [self checkMatchBetweenArray:array  andDictionary:cDic];
    
    cCount=20;
    cDic =[self createContentDictionaryWithCount:cCount withError:false];
    array =[ApiRequestHelper getContentArrayFromDictionary:cDic];
    NSLog(@"Array length: %lu",(unsigned long)[array count]);
    XCTAssert([array count]==cCount,@"Array Must be of length %d",cCount);
    [self checkMatchBetweenArray:array  andDictionary:cDic];
    
    // introduce error
    cCount=10;
    cDic =[self createContentDictionaryWithCount:cCount withError:true];
    array =[ApiRequestHelper getContentArrayFromDictionary:cDic];
    XCTAssertNil(array,@"Array should be nil");
    
    
}

- (NSDictionary *)createContentDictionaryWithCount:(int)count withError:(bool)error{
    NSMutableArray  *array =[[NSMutableArray alloc] init];
    for(int ind =0; ind< count;ind++){
        [array addObject: [self createOneContentDictionaryWithError:error]];
    }
    return (NSDictionary *)@{@"contents":(NSArray *)array};
}
- (NSDictionary *)createOneContentDictionaryWithError:(bool)error{
    NSDictionary *content =@{@"id":error?@-1:[NSNumber numberWithInt:[CommonUtility  pickRandom:40000]+1],
                             @"content_category_id":[NSNumber numberWithInt:[CommonUtility  pickRandom:4]+1],
                             @"user_id": [NSNumber numberWithInt:[CommonUtility  pickRandom:1000]+1],
                             @"text": [PlaceHolderFactory sentencesWithNumber:3],
                             @"photo_token": [PlaceHolderFactory word],
                             @"created_at":[PlaceHolderFactory word],
                             @"total_spread":[NSNumber numberWithInt:[CommonUtility  pickRandom:1000]+1],
                             @"spread_count":[NSNumber numberWithInt:[CommonUtility  pickRandom:1000]+1],
                             @"kill_count":[NSNumber numberWithInt:[CommonUtility  pickRandom:1000]+1],
                             @"comment_count":[NSNumber numberWithInt:[CommonUtility  pickRandom:100]+1]};
    return content;
}

- (void)checkMatchBetweenArray:(NSArray *)array andDictionary:(NSDictionary *)cDic{
    for(int ind =0; ind<[array count];ind++){
        ApiContent *content =array[ind];
        NSDictionary *contentDic = cDic[@"contents"][ind];
        
        XCTAssert(content.contentId==contentDic[@"id"], @"Must be the same");
        XCTAssert(content.categoryId==contentDic[@"content_category_id"], @"Must be the same");
        XCTAssert(content.userId==contentDic[@"user_id"], @"Must be the same");
        XCTAssert(content.contentText==contentDic[@"text"], @"Must be the same");
        XCTAssert(content.photoToken==contentDic[@"photo_token"], @"Must be the same");
        XCTAssert(content.createdAt==contentDic[@"created_at"], @"Must be the same");
        XCTAssert(content.totalSpread==contentDic[@"total_spread"], @"Must be the same");
        XCTAssert(content.spreadCount==contentDic[@"spread_count"], @"Must be the same");
        XCTAssert(content.killCount==contentDic[@"kill_count"], @"Must be the same");
        XCTAssert(content.commentCount==contentDic[@"comment_count"], @"Must be the same");
    }
}


#pragma mark - user response
- (void)testApiRequestHelperGetUserResponseFromDictionary{
    for(int ind=0;ind<200;ind++){
        NSDictionary *rDic = [self createReponseDictionary];
        ApiUserResponse *response = [ApiRequestHelper getUserResponseFromDictionary:rDic];
        [self checkMatchBetweenRepsonseObject:response andDictionary:rDic[@"user_response"]];
     }
}

- (NSDictionary *)createReponseDictionary{
    return @{@"user_response": @{@"user_id":[NSNumber numberWithInt:[CommonUtility  pickRandom:1000]+1],
                                 @"content_id":[NSNumber numberWithInt:[CommonUtility  pickRandom:2000]+1],
                                 @"response":[NSNumber numberWithBool:([CommonUtility pickRandom:2]>0)]}};
}

- (void)checkMatchBetweenRepsonseObject:(ApiUserResponse *)response andDictionary:(NSDictionary *)rDic{
    XCTAssert(response.userId==rDic[@"user_id"], @"Must be the same");
    XCTAssert(response.contentId==rDic[@"content_id"], @"Must be the same");
    XCTAssert(response.userResponse==rDic[@"response"], @"Must be the same");
}
@end
