//
//  ApiValidationManagerTests.m
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 7/15/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ApiValidationManager.h"

@interface ApiValidationManagerTests : XCTestCase
@end

@implementation ApiValidationManagerTests

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

- (void)testSignUpValidation{
    NSError *error = [ApiValidationManager validateSignUpWithUserTypeId:kAPIUserTypeAnonymous
                                                                  email:nil
                                                               password:nil
                                                   passwordConfirmation:nil];
    XCTAssertNil(error,@"Anomymous user sign up must be valid.");
    
    error = [ApiValidationManager validateSignUpWithUserTypeId:kAPIUserTypeOthers
                                                         email:@"me@me.com"
                                                      password:@"password"
                                          passwordConfirmation:@"password"];
    
    XCTAssertEqualObjects(error.localizedFailureReason,@"Unknown User Type");
    XCTAssertEqualObjects(error.localizedDescription,@"Invalid Input");
    XCTAssertEqualObjects(error.localizedRecoverySuggestion,@"Please check and try again");
    
    error = [ApiValidationManager validateSignUpWithUserTypeId:kAPIUserTypeWom
                                                         email:@"me@me.com"
                                                      password:@"password"
                                          passwordConfirmation:@"password"];
    
    XCTAssertNil(error,@"User sign up must be valid.");

    error = [ApiValidationManager validateSignUpWithUserTypeId:kAPIUserTypeWom
                                                         email:@"me.me@me.com"
                                                      password:@"password"
                                          passwordConfirmation:@"password"];
    
    XCTAssertNil(error,@"User sign up must be valid.");
    
    
    error = [ApiValidationManager validateSignUpWithUserTypeId:kAPIUserTypeWom
                                                         email:@"me_me@me.com"
                                                      password:@"password"
                                          passwordConfirmation:@"password"];
    
    XCTAssertNil(error,@"User sign up must be valid.");
    
    
    error = [ApiValidationManager validateSignUpWithUserTypeId:kAPIUserTypeWom
                                                         email:@"1me123@me.com"
                                                      password:@"password"
                                          passwordConfirmation:@"password"];
    
    XCTAssertNil(error,@"User sign up must be valid.");
    
    
    error = [ApiValidationManager validateSignUpWithUserTypeId:kAPIUserTypeWom
                                                         email:@"me_123.dfdg@me.com"
                                                      password:@"password"
                                          passwordConfirmation:@"password"];
    
    XCTAssertNil(error,@"User sign up must be valid.");
    
    
    error = [ApiValidationManager validateSignUpWithUserTypeId:kAPIUserTypeWom
                                                         email:@"me.fsd_1234@23me.com"
                                                      password:@"password"
                                          passwordConfirmation:@"password"];
    
    XCTAssertNil(error,@"User sign up must be valid.");
    
    
    error = [ApiValidationManager validateSignUpWithUserTypeId:kAPIUserTypeWom
                                                         email:@"me_dfjd.453.345.345@me.comy"
                                                      password:@"password"
                                          passwordConfirmation:@"password"];
    
    XCTAssertNil(error,@"User sign up must be valid.");
    
    
    
    error = [ApiValidationManager validateSignUpWithUserTypeId:kAPIUserTypeWom
                                                         email:@"me@me.com"
                                                      password:@"password"
                                          passwordConfirmation:@"password1"];
    
    XCTAssertEqualObjects(error.localizedFailureReason,@"Password confirmation must match password");
    XCTAssertEqualObjects(error.localizedDescription,@"Invalid Input");
    XCTAssertEqualObjects(error.localizedRecoverySuggestion,@"Please check and try again");
    
    error = [ApiValidationManager validateSignUpWithUserTypeId:kAPIUserTypeWom
                                                         email:@"me@me.com"
                                                      password:@"password"
                                          passwordConfirmation:@""];
    
    XCTAssertEqualObjects(error.localizedFailureReason,@"Password confirmation must match password");
    XCTAssertEqualObjects(error.localizedDescription,@"Invalid Input");
    XCTAssertEqualObjects(error.localizedRecoverySuggestion,@"Please check and try again");
    
    error = [ApiValidationManager validateSignUpWithUserTypeId:kAPIUserTypeWom
                                                         email:@"me@me.com"
                                                      password:@""
                                          passwordConfirmation:@"password"];
    
    XCTAssertEqualObjects(error.localizedFailureReason,@"Password must be at least 8 charecter long\nPassword confirmation must match password");
    XCTAssertEqualObjects(error.localizedDescription,@"Invalid Input");
    XCTAssertEqualObjects(error.localizedRecoverySuggestion,@"Please check and try again");
    
    error = [ApiValidationManager validateSignUpWithUserTypeId:kAPIUserTypeWom
                                                         email:@"me@me.com"
                                                      password:@""
                                          passwordConfirmation:@""];
    
    XCTAssertEqualObjects(error.localizedFailureReason,@"Password must be at least 8 charecter long");
    XCTAssertEqualObjects(error.localizedDescription,@"Invalid Input");
    XCTAssertEqualObjects(error.localizedRecoverySuggestion,@"Please check and try again");
    
    
    error = [ApiValidationManager validateSignUpWithUserTypeId:kAPIUserTypeWom
                                                         email:@"me.fd@me..fsdfcom"
                                                      password:@""
                                          passwordConfirmation:@"password"];
    
    XCTAssertEqualObjects(error.localizedFailureReason,@"Email is not valid\nPassword must be at least 8 charecter long\nPassword confirmation must match password");
    XCTAssertEqualObjects(error.localizedDescription,@"Invalid Input");
    XCTAssertEqualObjects(error.localizedRecoverySuggestion,@"Please check and try again");
    
    error = [ApiValidationManager validateSignUpWithUserTypeId:kAPIUserTypeWom
                                                         email:@""
                                                      password:@"dfsdsf"
                                          passwordConfirmation:@"password"];
    
    XCTAssertEqualObjects(error.localizedFailureReason,@"Email is empty\nPassword must be at least 8 charecter long\nPassword confirmation must match password");
    XCTAssertEqualObjects(error.localizedDescription,@"Invalid Input");
    XCTAssertEqualObjects(error.localizedRecoverySuggestion,@"Please check and try again");
}

- (void)testSignInValidation{
    NSError *error = [ApiValidationManager validateSignInWithUserTypeId:kAPIUserTypeAnonymous
                                                                  email:nil
                                                               password:nil];
    XCTAssertNil(error,@"Anomymous user sign up must be valid.");
    
    error = [ApiValidationManager validateSignInWithUserTypeId:kAPIUserTypeOthers
                                                         email:@"me@me.com"
                                                      password:@"password"];
    
    XCTAssertEqualObjects(error.localizedFailureReason,@"Unknown User Type");
    XCTAssertEqualObjects(error.localizedDescription,@"Invalid Input");
    XCTAssertEqualObjects(error.localizedRecoverySuggestion,@"Please check and try again");
    
    error = [ApiValidationManager validateSignInWithUserTypeId:kAPIUserTypeWom
                                                         email:@"me@me.com"
                                                      password:@"password"];
    
    XCTAssertNil(error,@"User sign up must be valid.");
    
    error = [ApiValidationManager validateSignInWithUserTypeId:kAPIUserTypeWom
                                                         email:@"me.me@me.com"
                                                      password:@"password"];
    
    XCTAssertNil(error,@"User sign up must be valid.");
    
    
    error = [ApiValidationManager validateSignInWithUserTypeId:kAPIUserTypeWom
                                                         email:@"me_me@me.com"
                                                      password:@"password"];
    
    XCTAssertNil(error,@"User sign up must be valid.");
    
    
    error = [ApiValidationManager validateSignInWithUserTypeId:kAPIUserTypeWom
                                                         email:@"1me123@me.com"
                                                      password:@"password"];
    
    XCTAssertNil(error,@"User sign up must be valid.");
    
    
    error = [ApiValidationManager validateSignInWithUserTypeId:kAPIUserTypeWom
                                                         email:@"me_123.dfdg@me.com"
                                                      password:@"password"];
    
    XCTAssertNil(error,@"User sign up must be valid.");
    
    
    error = [ApiValidationManager validateSignInWithUserTypeId:kAPIUserTypeWom
                                                         email:@"me.fsd_1234@23me.com"
                                                      password:@"password"];
    
    XCTAssertNil(error,@"User sign up must be valid.");
    
    
    error = [ApiValidationManager validateSignInWithUserTypeId:kAPIUserTypeWom
                                                         email:@"me_dfjd.453.345.345@me.comy"
                                                      password:@"password"];
    
    XCTAssertNil(error,@"User sign up must be valid.");
    
    error = [ApiValidationManager validateSignInWithUserTypeId:kAPIUserTypeWom
                                                         email:@"me@me.com"
                                                      password:@"passw"];
    
    XCTAssertEqualObjects(error.localizedFailureReason,@"Password must be at least 8 charecter long");
    XCTAssertEqualObjects(error.localizedDescription,@"Invalid Input");
    XCTAssertEqualObjects(error.localizedRecoverySuggestion,@"Please check and try again");
    
    error = [ApiValidationManager validateSignInWithUserTypeId:kAPIUserTypeWom
                                                         email:@"me@me.com"
                                                      password:@""];
    
    XCTAssertEqualObjects(error.localizedFailureReason,@"Password must be at least 8 charecter long");
    XCTAssertEqualObjects(error.localizedDescription,@"Invalid Input");
    XCTAssertEqualObjects(error.localizedRecoverySuggestion,@"Please check and try again");
    
    
    error = [ApiValidationManager validateSignInWithUserTypeId:kAPIUserTypeWom
                                                         email:@"me.fd@me..fsdfcom"
                                                      password:@"fsad"];
    
    XCTAssertEqualObjects(error.localizedFailureReason,@"Email is not valid\nPassword must be at least 8 charecter long");
    XCTAssertEqualObjects(error.localizedDescription,@"Invalid Input");
    XCTAssertEqualObjects(error.localizedRecoverySuggestion,@"Please check and try again");
    
    error = [ApiValidationManager validateSignInWithUserTypeId:kAPIUserTypeWom
                                                         email:@""
                                                      password:@"dfsdsf"];
    
    XCTAssertEqualObjects(error.localizedFailureReason,@"Email is empty\nPassword must be at least 8 charecter long");
    XCTAssertEqualObjects(error.localizedDescription,@"Invalid Input");
    XCTAssertEqualObjects(error.localizedRecoverySuggestion,@"Please check and try again");
    
}
- (void)testContentValidation{
    NSError *error = [ApiValidationManager validatePostCotentWithCategoryId:kAPIContentCategoryLocalInfo
                                                                       text:@"Local news"];
    XCTAssertNil(error,@"Conent post must be valid.");
    error = [ApiValidationManager validatePostCotentWithCategoryId:kAPIContentCategoryRumor
                                                                       text:@"Local news"];
    XCTAssertNil(error,@"Conent post must be valid.");
    
    error = [ApiValidationManager validatePostCotentWithCategoryId:kAPIContentCategorySecret
                                                                       text:@"Local news"];
    XCTAssertNil(error,@"Conent post must be valid.");
    
    error = [ApiValidationManager validatePostCotentWithCategoryId:kAPIContentCategoryNews
                                                                       text:@"Local news"];
    XCTAssertNil(error,@"Conent post must be valid.");
    
    error = [ApiValidationManager validatePostCotentWithCategoryId:kAPIContentCategoryLocalInfo
                                                                       text:@"Lo"];
    XCTAssertNil(error,@"Conent post must be valid.");
    
    error = [ApiValidationManager validatePostCotentWithCategoryId:kAPIContentCategoryLocalInfo
                                                                       text:@"AWS Elastic Beanstalk makes it even easier for developers to quickly deploy and manage applications in the AWS cloud. Developers simply upload their application, and Elastic"];
    XCTAssertNil(error,@"Conent post must be valid.");
    
    error = [ApiValidationManager validatePostCotentWithCategoryId:kAPIContentCategoryOther
                                                                       text:@"Local news"];
    
    XCTAssertEqualObjects(error.localizedFailureReason,@"Please select a content type.");
    XCTAssertEqualObjects(error.localizedDescription,@"Invalid Input");
    XCTAssertEqualObjects(error.localizedRecoverySuggestion,@"Please check and try again");
    
    error = [ApiValidationManager validatePostCotentWithCategoryId:kAPIContentCategoryLocalInfo
                                                              text:@"L"];
    
    NSString *str =[NSString stringWithFormat:@"Text must be at least %d charecter long",kAPIValidationContentMinLentgh];
    XCTAssertEqualObjects(error.localizedFailureReason,str);
    XCTAssertEqualObjects(error.localizedDescription,@"Invalid Input");
    XCTAssertEqualObjects(error.localizedRecoverySuggestion,@"Please check and try again");
    
    error = [ApiValidationManager validatePostCotentWithCategoryId:kAPIContentCategoryNews
                                                              text:@"AWS Elastic Beanstalk makes it even easier for developers to quickly deploy and manage applications in the AWS cloud. Developers simply upload their application, and ElasticAWS Elastic Beanstalk makes it even easier for developers to quickly deploy and manage applications in the AWS cloud. Developers simply upload their application, and ElasticAWS Elastic Beanstalk makes it even easier for developers to quickly deploy and manage applications in the AWS cloud. Developers simply upload their application, and Elasticc Beanstalk makes it even easier for developers to quickly deploy and manage applications in the AWS cloud. Developers simply upload their application, and ElasticAWS Elastic Beanstalk makes it even easier for developers to quickly deploy and manage applications in the AWS cloud. Developers simply upload their application, and Elastic"];
    
    NSString *strm =[NSString stringWithFormat:@"Text must be shoter than %d charecter long",kAPIValidationContentMaxLentgh];
    XCTAssertEqualObjects(error.localizedFailureReason,strm);
    XCTAssertEqualObjects(error.localizedDescription,@"Invalid Input");
    XCTAssertEqualObjects(error.localizedRecoverySuggestion,@"Please check and try again");
}
@end
