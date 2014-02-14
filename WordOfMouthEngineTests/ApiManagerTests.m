//
//  ApiManagerTests.m
//  WordOfMotuhEngine
//
//  Created by Bijit Halder on 11/18/13.
//  Copyright (c) 2013 Bijit Halder. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ApiManager.h"

@interface ApiManagerTests : XCTestCase{
    ApiManager *apiManager;
}

@end

@implementation ApiManagerTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    apiManager=[ApiManager sharedApiManager];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testApiManagerNotNil
{
    // Init APi manager
    XCTAssertNotNil(apiManager, @"shared mager must not be nil \"%s\"", __PRETTY_FUNCTION__);
}

- (void)testApiCurrentUserNotNil
{
    XCTAssertNotNil([ApiManager currentUser], @"Current User must not be nil \"%s\"", __PRETTY_FUNCTION__);
     XCTAssertTrue([ApiManager currentUser].userId>=0, @"Current User ID must not be nil \"%s\"", __PRETTY_FUNCTION__);
     XCTAssertNotNil([ApiManager currentUser].name, @"Current User name must not be nil \"%s\"", __PRETTY_FUNCTION__);
     XCTAssertNotNil([ApiManager currentUser].email, @"Current User email must not be nil \"%s\"", __PRETTY_FUNCTION__);
}

@end
