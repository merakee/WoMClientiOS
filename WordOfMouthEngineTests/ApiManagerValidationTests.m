//
//  ApiValidationManagerTests.m
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 7/15/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ApiManager.h"
#import "AsynTextHelper.h"

@interface ApiManagerValidationTests : XCTestCase{
    ApiManager *apiManager;
}
@end

@implementation ApiManagerValidationTests

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

- (void)testSignUpValidationWithWrongUserType{
    StartAsyncBlock();
    [apiManager signUpUserWithUserTypeId:kAPIUserTypeOthers
                                   email:@"me@me.com"
                                password:@"password"
                    passwordConfirmation:@"password"
                                 success:^(){
                                     XCTAssert(@"Must not be sucessful");
                                     StopAsyncBlock();
                                 }
                                 failure:^(NSError *error){
                                     XCTAssertEqualObjects(error.localizedFailureReason,@"Unknown User Type");
                                     XCTAssertEqualObjects(error.localizedDescription,@"Invalid Input");
                                     XCTAssertEqualObjects(error.localizedRecoverySuggestion,@"Please check and try again");
                                     StopAsyncBlock();
                                 }];
    
    // Run the Wait loop
    WaitUntilAsyncBlockCompletes();
    
}

- (void)testSignUpValidationWithMismatchPassword{
    StartAsyncBlock();
    [apiManager signUpUserWithUserTypeId:kAPIUserTypeWom
                                   email:@"me@me.com"
                                password:@"password"
                    passwordConfirmation:@"password1"
                                 success:^(){
                                     XCTAssert(@"Must not be sucessful");
                                     StopAsyncBlock();
                                 }
                                 failure:^(NSError *error){
                                     XCTAssertEqualObjects(error.localizedFailureReason,@"Password confirmation must match password");
                                     XCTAssertEqualObjects(error.localizedDescription,@"Invalid Input");
                                     XCTAssertEqualObjects(error.localizedRecoverySuggestion,@"Please check and try again");
                                     StopAsyncBlock();
                                 }];
    
    // Run the Wait loop
    WaitUntilAsyncBlockCompletes();
}


- (void)testSignUpValidationWithEmptyPasswordConfirmation{
    StartAsyncBlock();
    [apiManager signUpUserWithUserTypeId:kAPIUserTypeWom
                                   email:@"me@me.com"
                                password:@"password"
                    passwordConfirmation:@""
                                 success:^(){
                                     XCTAssert(@"Must not be sucessful");
                                     StopAsyncBlock();
                                 }
                                 failure:^(NSError *error){
                                     XCTAssertEqualObjects(error.localizedFailureReason,@"Password confirmation must match password");
                                     XCTAssertEqualObjects(error.localizedDescription,@"Invalid Input");
                                     XCTAssertEqualObjects(error.localizedRecoverySuggestion,@"Please check and try again");
                                     StopAsyncBlock();
                                 }];
    
    // Run the Wait loop
    WaitUntilAsyncBlockCompletes();
}


- (void)testSignUpValidationWithEmptyPassword{
    StartAsyncBlock();
    [apiManager signUpUserWithUserTypeId:kAPIUserTypeWom
                                   email:@"me@me.com"
                                password:@""
                    passwordConfirmation:@"password"
                                 success:^(){
                                     XCTAssert(@"Must not be sucessful");
                                     StopAsyncBlock();
                                 }
                                 failure:^(NSError *error){
                                     XCTAssertEqualObjects(error.localizedFailureReason,@"Password must be at least 8 charecter long\nPassword confirmation must match password");
                                     XCTAssertEqualObjects(error.localizedDescription,@"Invalid Input");
                                     XCTAssertEqualObjects(error.localizedRecoverySuggestion,@"Please check and try again");
                                     StopAsyncBlock();
                                 }];
    
    // Run the Wait loop
    WaitUntilAsyncBlockCompletes();
}

- (void)testSignUpValidationWithEmptyPasswordAndConfirmation{
    StartAsyncBlock();
    [apiManager signUpUserWithUserTypeId:kAPIUserTypeWom
                                   email:@"me@me.com"
                                password:@""
                    passwordConfirmation:@""
                                 success:^(){
                                     XCTAssert(@"Must not be sucessful");
                                     StopAsyncBlock();
                                 }
                                 failure:^(NSError *error){
                                     XCTAssertEqualObjects(error.localizedFailureReason,@"Password must be at least 8 charecter long");
                                     XCTAssertEqualObjects(error.localizedDescription,@"Invalid Input");
                                     XCTAssertEqualObjects(error.localizedRecoverySuggestion,@"Please check and try again");
                                     StopAsyncBlock();
                                 }];
    
    // Run the Wait loop
    WaitUntilAsyncBlockCompletes();
}
- (void)testSignUpValidationWithWrongEmailEmptyPasswordAndMismatchConfirmation{
    StartAsyncBlock();
    [apiManager signUpUserWithUserTypeId:kAPIUserTypeWom
                                   email:@"me.fd@me..fsdfcom"
                                password:@""
                    passwordConfirmation:@"password"
                                 success:^(){
                                     XCTAssert(@"Must not be sucessful");
                                     StopAsyncBlock();
                                 }
                                 failure:^(NSError *error){
                                     XCTAssertEqualObjects(error.localizedFailureReason,@"Email is not valid\nPassword must be at least 8 charecter long\nPassword confirmation must match password");
                                     XCTAssertEqualObjects(error.localizedDescription,@"Invalid Input");
                                     XCTAssertEqualObjects(error.localizedRecoverySuggestion,@"Please check and try again");
                                     StopAsyncBlock();
                                 }];
    
    // Run the Wait loop
    WaitUntilAsyncBlockCompletes();
}

- (void)testSignUpValidationWithEmptyEmailAndMismatchConfirmation{
    StartAsyncBlock();
    [apiManager signUpUserWithUserTypeId:kAPIUserTypeWom
                                   email:@""
                                password:@"dfsdsf"
                    passwordConfirmation:@"password"
                                 success:^(){
                                     XCTAssert(@"Must not be sucessful");
                                     StopAsyncBlock();
                                 }
                                 failure:^(NSError *error){
                                     XCTAssertEqualObjects(error.localizedFailureReason,@"Email is empty\nPassword must be at least 8 charecter long\nPassword confirmation must match password");
                                     XCTAssertEqualObjects(error.localizedDescription,@"Invalid Input");
                                     XCTAssertEqualObjects(error.localizedRecoverySuggestion,@"Please check and try again");
                                     StopAsyncBlock();
                                 }];
    
    // Run the Wait loop
    WaitUntilAsyncBlockCompletes();
}


- (void)testSignInValidationWithWrongUserType{
    StartAsyncBlock();
    [apiManager signInUserWithUserTypeId:kAPIUserTypeOthers
                                   email:@"me@me.com"
                                password:@"password"
                                 success:^(){
                                     XCTAssert(@"Must not be sucessful");
                                     StopAsyncBlock();
                                 }
                                 failure:^(NSError *error){
                                     XCTAssertEqualObjects(error.localizedFailureReason,@"Unknown User Type");
                                     XCTAssertEqualObjects(error.localizedDescription,@"Invalid Input");
                                     XCTAssertEqualObjects(error.localizedRecoverySuggestion,@"Please check and try again");
                                     StopAsyncBlock();
                                 }];
    
    // Run the Wait loop
    WaitUntilAsyncBlockCompletes();
    
}



- (void)testSignInValidationWithEmptyPassword{
    StartAsyncBlock();
    [apiManager signInUserWithUserTypeId:kAPIUserTypeWom
                                   email:@"me@me.com"
                                password:@""
                                 success:^(){
                                     XCTAssert(@"Must not be sucessful");
                                     StopAsyncBlock();
                                 }
                                 failure:^(NSError *error){
                                     XCTAssertEqualObjects(error.localizedFailureReason,@"Password must be at least 8 charecter long");
                                     XCTAssertEqualObjects(error.localizedDescription,@"Invalid Input");
                                     XCTAssertEqualObjects(error.localizedRecoverySuggestion,@"Please check and try again");
                                     StopAsyncBlock();
                                 }];
    
    // Run the Wait loop
    WaitUntilAsyncBlockCompletes();
}


- (void)testSignInValidationWithEmptyEmail{
    StartAsyncBlock();
    [apiManager signInUserWithUserTypeId:kAPIUserTypeWom
                                   email:@""
                                password:@"password"
                                 success:^(){
                                     XCTAssert(@"Must not be sucessful");
                                     StopAsyncBlock();
                                 }
                                 failure:^(NSError *error){
                                     XCTAssertEqualObjects(error.localizedFailureReason,@"Email is empty");
                                     XCTAssertEqualObjects(error.localizedDescription,@"Invalid Input");
                                     XCTAssertEqualObjects(error.localizedRecoverySuggestion,@"Please check and try again");
                                     StopAsyncBlock();
                                 }];
    
    // Run the Wait loop
    WaitUntilAsyncBlockCompletes();
}
- (void)testSignInValidationWithEmptyEmailAndPassword{
    StartAsyncBlock();
    [apiManager signInUserWithUserTypeId:kAPIUserTypeWom
                                   email:@""
                                password:@""
                                 success:^(){
                                     XCTAssert(@"Must not be sucessful");
                                     StopAsyncBlock();
                                 }
                                 failure:^(NSError *error){
                                     XCTAssertEqualObjects(error.localizedFailureReason,@"Email is empty\nPassword must be at least 8 charecter long");
                                     XCTAssertEqualObjects(error.localizedDescription,@"Invalid Input");
                                     XCTAssertEqualObjects(error.localizedRecoverySuggestion,@"Please check and try again");
                                     StopAsyncBlock();
                                 }];
    
    // Run the Wait loop
    WaitUntilAsyncBlockCompletes();
}

- (void)testSignInValidationWithWrongEmail{
    StartAsyncBlock();
    [apiManager signInUserWithUserTypeId:kAPIUserTypeWom
                                   email:@"me.fd@me..fsdfcom"
                                password:@"password"
                                 success:^(){
                                     XCTAssert(@"Must not be sucessful");
                                     StopAsyncBlock();
                                 }
                                 failure:^(NSError *error){
                                     XCTAssertEqualObjects(error.localizedFailureReason,@"Email is not valid");
                                     XCTAssertEqualObjects(error.localizedDescription,@"Invalid Input");
                                     XCTAssertEqualObjects(error.localizedRecoverySuggestion,@"Please check and try again");
                                     StopAsyncBlock();
                                 }];
    
    // Run the Wait loop
    WaitUntilAsyncBlockCompletes();
}

- (void)testSignInValidationWithWrongEmailAndShortPassword{
    StartAsyncBlock();
    [apiManager signInUserWithUserTypeId:kAPIUserTypeWom
                                   email:@"me.fd@me..fsdfcom"
                                password:@"passrd"
                                 success:^(){
                                     XCTAssert(@"Must not be sucessful");
                                     StopAsyncBlock();
                                 }
                                 failure:^(NSError *error){
                                     XCTAssertEqualObjects(error.localizedFailureReason,@"Email is not valid\nPassword must be at least 8 charecter long");
                                     XCTAssertEqualObjects(error.localizedDescription,@"Invalid Input");
                                     XCTAssertEqualObjects(error.localizedRecoverySuggestion,@"Please check and try again");
                                     StopAsyncBlock();
                                 }];
    
    // Run the Wait loop
    WaitUntilAsyncBlockCompletes();
}
- (void)testContentValidationWithWrongContentType{
    StartAsyncBlock();
    [apiManager postContentWithCategoryId:kAPIContentCategoryOther
                                     text:@"Local news"
                                    photo:nil
                                  success:^(ApiContent * content){
                                      XCTAssert(@"Must not be sucessful");
                                      StopAsyncBlock();
                                  }
                                  failure:^(NSError *error){
                                      XCTAssertEqualObjects(error.localizedFailureReason,@"Please select a content type.");
                                      XCTAssertEqualObjects(error.localizedDescription,@"Invalid Input");
                                      XCTAssertEqualObjects(error.localizedRecoverySuggestion,@"Please check and try again");
                                      StopAsyncBlock();
                                  }];
    
    // Run the Wait loop
    WaitUntilAsyncBlockCompletes();
    
}

- (void)testContentValidationWithShortContent{
    StartAsyncBlock();
    [apiManager postContentWithCategoryId:kAPIContentCategoryRumor
                                     text:@"L"
                                    photo:nil
                                  success:^(ApiContent * content){
                                      XCTAssert(@"Must not be sucessful");
                                      StopAsyncBlock();
                                  }
                                  failure:^(NSError *error){
                                      NSString *str =[NSString stringWithFormat:@"Text must be at least %d charecter long",kAPIValidationContentMinLength];
                                      XCTAssertEqualObjects(error.localizedFailureReason,str);
                                      XCTAssertEqualObjects(error.localizedDescription,@"Invalid Input");
                                      XCTAssertEqualObjects(error.localizedRecoverySuggestion,@"Please check and try again");
                                      StopAsyncBlock();
                                  }];
    
    // Run the Wait loop
    WaitUntilAsyncBlockCompletes();
}

- (void)testContentValidationWithLongContent{
    StartAsyncBlock();
    [apiManager postContentWithCategoryId:kAPIContentCategorySecret
                                     text:@"AWS Elastic Beanstalk makes it even easier for developers to quickly deploy and manage applications in the AWS cloud. Developers simply upload their application, and ElasticAWS Elastic Beanstalk makes it even easier for developers to quickly deploy and manage applications in the AWS cloud. Developers simply upload their application, and ElasticAWS Elastic Beanstalk makes it even easier for developers to quickly deploy and manage applications in the AWS cloud. Developers simply upload their application, and Elasticc Beanstalk makes it even easier for developers to quickly deploy and manage applications in the AWS cloud. Developers simply upload their application, and ElasticAWS Elastic Beanstalk makes it even easier for developers to quickly deploy and manage applications in the AWS cloud. Developers simply upload their application, and Elastic"
                                    photo:nil
                                  success:^(ApiContent * content){
                                      XCTAssert(@"Must not be sucessful");
                                      StopAsyncBlock();
                                  }
                                  failure:^(NSError *error){
                                      NSString *strm =[NSString stringWithFormat:@"Text must be shoter than %d charecter long",kAPIValidationContentMaxLength];
                                      XCTAssertEqualObjects(error.localizedFailureReason,strm);
                                      XCTAssertEqualObjects(error.localizedDescription,@"Invalid Input");
                                      XCTAssertEqualObjects(error.localizedRecoverySuggestion,@"Please check and try again");
                                      StopAsyncBlock();
                                  }];
    
    // Run the Wait loop
    WaitUntilAsyncBlockCompletes();
}
@end
