//
//  ApiValidationManagerTests.m
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 7/15/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import "SpectaSetUp.h"
#import "ApiValidationManager.h"


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

SpecBegin(ApiValidationManager)

describe(@"ApiValidationManager", ^{
    
    // set up all variables
    __block NSError *error;
    
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
    
    describe(@"Sign up Validations", ^{
        
        it(@"should pass sign up validation",^{
            error = [ApiValidationManager validateSignUpWithUserTypeId:kAPIUserTypeAnonymous
                                                                 email:nil
                                                              password:nil
                                                  passwordConfirmation:nil];
            expect(error).to.beFalsy();
        });
        
        it(@"should fail sign up validation with wrong user type",^{
            error = [ApiValidationManager validateSignUpWithUserTypeId:kAPIUserTypeOthers
                                                                 email:@"me@me.com"
                                                              password:@"password"
                                                  passwordConfirmation:@"password"];
            expect(error.localizedFailureReason).to.equal(@"Unknown User Type");
            expect(error.localizedDescription).to.equal(@"Invalid Input");
            expect(error.localizedRecoverySuggestion).to.equal(@"Please check and try again");
            
        });
        
        
        
        it(@"should pass sign up validation",^{
            error = [ApiValidationManager validateSignUpWithUserTypeId:kAPIUserTypeWom
                                                                 email:@"me@me.com"
                                                              password:@"password"
                                                  passwordConfirmation:@"password"];
            
            expect(error).to.beFalsy();
        });
        
        it(@"should pass sign up validation",^{
            error = [ApiValidationManager validateSignUpWithUserTypeId:kAPIUserTypeWom
                                                                 email:@"me.me@me.com"
                                                              password:@"password"
                                                  passwordConfirmation:@"password"];
            
            expect(error).to.beFalsy();
        });
        
        it(@"should pass sign up validation",^{
            error = [ApiValidationManager validateSignUpWithUserTypeId:kAPIUserTypeWom
                                                                 email:@"me_me@me.com"
                                                              password:@"password"
                                                  passwordConfirmation:@"password"];
            
            expect(error).to.beFalsy();
        });
        
        it(@"should pass sign up validation",^{
            error = [ApiValidationManager validateSignUpWithUserTypeId:kAPIUserTypeWom
                                                                 email:@"1me123@me.com"
                                                              password:@"password"
                                                  passwordConfirmation:@"password"];
            
            expect(error).to.beFalsy();
        });
        it(@"should pass sign up validation",^{
            
            error = [ApiValidationManager validateSignUpWithUserTypeId:kAPIUserTypeWom
                                                                 email:@"me_123.dfdg@me.com"
                                                              password:@"password"
                                                  passwordConfirmation:@"password"];
            
            expect(error).to.beFalsy();
        });
        it(@"should pass sign up validation",^{
            
            error = [ApiValidationManager validateSignUpWithUserTypeId:kAPIUserTypeWom
                                                                 email:@"me.fsd_1234@23me.com"
                                                              password:@"password"
                                                  passwordConfirmation:@"password"];
            
            expect(error).to.beFalsy();
        });
        it(@"should pass sign up validation",^{
            
            error = [ApiValidationManager validateSignUpWithUserTypeId:kAPIUserTypeWom
                                                                 email:@"me_dfjd.453.345.345@me.comy"
                                                              password:@"password"
                                                  passwordConfirmation:@"password"];
            
            expect(error).to.beFalsy();
        });
        
        
        it(@"should fail sign up validation with mismatched password confirmation",^{
            error = [ApiValidationManager validateSignUpWithUserTypeId:kAPIUserTypeWom
                                                                 email:@"me@me.com"
                                                              password:@"password"
                                                  passwordConfirmation:@"password1"];
            
            expect(error.localizedFailureReason).to.equal(@"Password confirmation must match password");
            expect(error.localizedDescription).to.equal(@"Invalid Input");
            expect(error.localizedRecoverySuggestion).to.equal(@"Please check and try again");
        });
        
        it(@"should fail sign up validation with empty password confirmation",^{
            error = [ApiValidationManager validateSignUpWithUserTypeId:kAPIUserTypeWom
                                                                 email:@"me@me.com"
                                                              password:@"password"
                                                  passwordConfirmation:@""];
            
            expect(error.localizedFailureReason).to.equal(@"Password confirmation must match password");
            expect(error.localizedDescription).to.equal(@"Invalid Input");
            expect(error.localizedRecoverySuggestion).to.equal(@"Please check and try again");
        });
        
        it(@"should fail sign up validation with empty password",^{
            error = [ApiValidationManager validateSignUpWithUserTypeId:kAPIUserTypeWom
                                                                 email:@"me@me.com"
                                                              password:@""
                                                  passwordConfirmation:@"password"];
            
            expect(error.localizedFailureReason).to.equal(@"Password must be at least 8 charecter long\nPassword confirmation must match password");
            expect(error.localizedDescription).to.equal(@"Invalid Input");
            expect(error.localizedRecoverySuggestion).to.equal(@"Please check and try again");
        });
        
        it(@"should fail sign up validation with empty password and password confirmation",^{
            error = [ApiValidationManager validateSignUpWithUserTypeId:kAPIUserTypeWom
                                                                 email:@"me@me.com"
                                                              password:@""
                                                  passwordConfirmation:@""];
            
            expect(error.localizedFailureReason).to.equal(@"Password must be at least 8 charecter long");
            expect(error.localizedDescription).to.equal(@"Invalid Input");
            expect(error.localizedRecoverySuggestion).to.equal(@"Please check and try again");
        });
        
        
        it(@"should fail sign up validation with wrong email format and empty password",^{
            error = [ApiValidationManager validateSignUpWithUserTypeId:kAPIUserTypeWom
                                                                 email:@"me.fd@me..fsdfcom"
                                                              password:@""
                                                  passwordConfirmation:@"password"];
            
            expect(error.localizedFailureReason).to.equal(@"Email is not valid\nPassword must be at least 8 charecter long\nPassword confirmation must match password");
            expect(error.localizedDescription).to.equal(@"Invalid Input");
            expect(error.localizedRecoverySuggestion).to.equal(@"Please check and try again");
        });
        
        it(@"should fail sign up validation with short password and mistmatched password confirmation",^{
            error = [ApiValidationManager validateSignUpWithUserTypeId:kAPIUserTypeWom
                                                                 email:@""
                                                              password:@"dfsdsf"
                                                  passwordConfirmation:@"password"];
            
            expect(error.localizedFailureReason).to.equal(@"Email is empty\nPassword must be at least 8 charecter long\nPassword confirmation must match password");
            expect(error.localizedDescription).to.equal(@"Invalid Input");
            expect(error.localizedRecoverySuggestion).to.equal(@"Please check and try again");
        });
        
    });
    
    
    describe(@"Sign in Validations", ^{
        
        it(@"should pass sign in validation",^{
            error = [ApiValidationManager validateSignInWithUserTypeId:kAPIUserTypeAnonymous
                                                                 email:nil
                                                              password:nil];
            expect(error).to.beFalsy();
        });
        
        it(@"should fail sign in validation with wrong user type",^{
            error = [ApiValidationManager validateSignInWithUserTypeId:kAPIUserTypeOthers
                                                                 email:@"me@me.com"
                                                              password:@"password"];
            
            expect(error.localizedFailureReason).to.equal(@"Unknown User Type");
            expect(error.localizedDescription).to.equal(@"Invalid Input");
            expect(error.localizedRecoverySuggestion).to.equal(@"Please check and try again");
        });
        
        it(@"should pass sign in validation",^{
            error = [ApiValidationManager validateSignInWithUserTypeId:kAPIUserTypeWom
                                                                 email:@"me@me.com"
                                                              password:@"password"];
            
            expect(error).to.beFalsy();
        });
        
        it(@"should pass sign in validation",^{
            error = [ApiValidationManager validateSignInWithUserTypeId:kAPIUserTypeWom
                                                                 email:@"me.me@me.com"
                                                              password:@"password"];
            
            expect(error).to.beFalsy();
        });
        
        it(@"should pass sign in validation",^{
            error = [ApiValidationManager validateSignInWithUserTypeId:kAPIUserTypeWom
                                                                 email:@"me_me@me.com"
                                                              password:@"password"];
            
            expect(error).to.beFalsy();
        });
        it(@"should pass sign in validation",^{
            
            error = [ApiValidationManager validateSignInWithUserTypeId:kAPIUserTypeWom
                                                                 email:@"1me123@me.com"
                                                              password:@"password"];
            
            expect(error).to.beFalsy();
        });
        it(@"should pass sign in validation",^{
            
            error = [ApiValidationManager validateSignInWithUserTypeId:kAPIUserTypeWom
                                                                 email:@"me_123.dfdg@me.com"
                                                              password:@"password"];
            
            expect(error).to.beFalsy();
        });
        
        it(@"should pass sign in validation",^{
            error = [ApiValidationManager validateSignInWithUserTypeId:kAPIUserTypeWom
                                                                 email:@"me.fsd_1234@23me.com"
                                                              password:@"password"];
            
            expect(error).to.beFalsy();
        });
        
        it(@"should pass sign in validation",^{
            error = [ApiValidationManager validateSignInWithUserTypeId:kAPIUserTypeWom
                                                                 email:@"me_dfjd.453.345.345@me.comy"
                                                              password:@"password"];
            
            expect(error).to.beFalsy();
        });
        
        it(@"should fail sign in validation with short password",^{
            error = [ApiValidationManager validateSignInWithUserTypeId:kAPIUserTypeWom
                                                                 email:@"me@me.com"
                                                              password:@"passw"];
            
            expect(error.localizedFailureReason).to.equal(@"Password must be at least 8 charecter long");
            expect(error.localizedDescription).to.equal(@"Invalid Input");
            expect(error.localizedRecoverySuggestion).to.equal(@"Please check and try again");
        });
        
        it(@"should fail sign in validation with empty password",^{
            error = [ApiValidationManager validateSignInWithUserTypeId:kAPIUserTypeWom
                                                                 email:@"me@me.com"
                                                              password:@""];
            
            expect(error.localizedFailureReason).to.equal(@"Password must be at least 8 charecter long");
            expect(error.localizedDescription).to.equal(@"Invalid Input");
            expect(error.localizedRecoverySuggestion).to.equal(@"Please check and try again");
        });
        
        it(@"should fail sign in validation with short password and wrong email",^{
            error = [ApiValidationManager validateSignInWithUserTypeId:kAPIUserTypeWom
                                                                 email:@"me.fd@me..fsdfcom"
                                                              password:@"fsad"];
            
            
            
            expect(error.localizedFailureReason).to.equal(@"Email is not valid\nPassword must be at least 8 charecter long");
            expect(error.localizedDescription).to.equal(@"Invalid Input");
            expect(error.localizedRecoverySuggestion).to.equal(@"Please check and try again");
        });
        
        it(@"should fail sign in validation with wrong password and empty email",^{
            error = [ApiValidationManager validateSignInWithUserTypeId:kAPIUserTypeWom
                                                                 email:@""
                                                              password:@"dfsdsf"];
            
            expect(error.localizedFailureReason).to.equal(@"Email is empty\nPassword must be at least 8 charecter long");
            expect(error.localizedDescription).to.equal(@"Invalid Input");
            expect(error.localizedRecoverySuggestion).to.equal(@"Please check and try again");
        });
        
    });
    
    describe(@"Content Validations", ^{
        
        it(@"should pass content validation with image and empty text",^{
            error = [ApiValidationManager validatePostContentWithCategoryId:kAPIContentCategoryLocalInfo
                                                                       text:@""
                                                                   andPhoto:[UIImage imageNamed:@"logo-nav.png"]];
            expect(error).to.beFalsy();
        });
        
        it(@"should pass content validation with image and nil text",^{
            error = [ApiValidationManager validatePostContentWithCategoryId:kAPIContentCategoryLocalInfo
                                                                       text:nil
                                                                   andPhoto:[UIImage imageNamed:@"logo-nav.png"]];
            expect(error).to.beFalsy();
        });
        
        
        it(@"should pass content validation",^{
            error = [ApiValidationManager validatePostContentWithCategoryId:kAPIContentCategoryLocalInfo
                                                                      text:@"Local news"
                     andPhoto:nil];
            expect(error).to.beFalsy();
        });
        
        it(@"should pass content validation",^{
            error = [ApiValidationManager validatePostContentWithCategoryId:kAPIContentCategoryRumor
                                                                      text:@"Local news"
                     andPhoto:nil];
            expect(error).to.beFalsy();
        });
        it(@"should pass content validation",^{
            error = [ApiValidationManager validatePostContentWithCategoryId:kAPIContentCategorySecret
                                                                      text:@"Local news"
                     andPhoto:nil];
            expect(error).to.beFalsy();
        });
        it(@"should pass content validation",^{
            error = [ApiValidationManager validatePostContentWithCategoryId:kAPIContentCategoryNews
                                                                      text:@"Local news"
                                                                   andPhoto:nil];
            expect(error).to.beFalsy();
        });
        it(@"should pass content validation",^{
            error = [ApiValidationManager validatePostContentWithCategoryId:kAPIContentCategoryLocalInfo
                                                                      text:@"L"
                     andPhoto:nil];
            expect(error).to.beFalsy();
        });
        it(@"should pass content validation",^{
            error = [ApiValidationManager validatePostContentWithCategoryId:kAPIContentCategoryLocalInfo
                                                                      text:@"AWS Elastic Beanstalk makes it even easier for developers to quickly deploy and manage applications in the AWS cloud. Developers simply upload their application, and Elastic"
                     andPhoto:nil];
            expect(error).to.beFalsy();
        });
        
        it(@"should fail content validation with wrong category",^{
            error = [ApiValidationManager validatePostContentWithCategoryId:kAPIContentCategoryOther
                                                                      text:@"Local news"
                     andPhoto:nil];
            
            
            expect(error.localizedFailureReason).to.equal(@"Please select a content type.");
            expect(error.localizedDescription).to.equal(@"Invalid Input");
            expect(error.localizedRecoverySuggestion).to.equal(@"Please check and try again");
        });
        
        it(@"should fail content validation with short text",^{
            error = [ApiValidationManager validatePostContentWithCategoryId:kAPIContentCategoryLocalInfo
                                                                      text:@""
                     andPhoto:nil];
            
            NSString *str =[NSString stringWithFormat:@"Text must be at least %d charecter long",kAPIValidationContentMinLength];
            expect(error.localizedFailureReason).to.equal(str);
            expect(error.localizedDescription).to.equal(@"Invalid Input");
            expect(error.localizedRecoverySuggestion).to.equal(@"Please check and try again");
        });
        
        it(@"should fail content validation with too long text",^{
            error = [ApiValidationManager validatePostContentWithCategoryId:kAPIContentCategoryNews
                                                                      text:@"AWS Elastic Beanstalk makes it even easier for developers to quickly deploy and manage applications in the AWS cloud. Developers simply upload their application, and ElasticAWS Elastic Beanstalk makes it even easier for developers to quickly deploy and manage applications in the AWS cloud. Developers simply upload their application, and ElasticAWS Elastic Beanstalk makes it even easier for developers to quickly deploy and manage applications in the AWS cloud. Developers simply upload their application, and Elasticc Beanstalk makes it even easier for developers to quickly deploy and manage applications in the AWS cloud. Developers simply upload their application, and ElasticAWS Elastic Beanstalk makes it even easier for developers to quickly deploy and manage applications in the AWS cloud. Developers simply upload their application, and Elastic"
                     andPhoto:nil];
            
            NSString *str =[NSString stringWithFormat:@"Text must be shoter than %d charecter long",kAPIValidationContentMaxLength];
            expect(error.localizedFailureReason).to.equal(str);
            expect(error.localizedDescription).to.equal(@"Invalid Input");
            expect(error.localizedRecoverySuggestion).to.equal(@"Please check and try again");
        });
    });
    
    
    describe(@"Comment Validations", ^{
        it(@"should pass comment validation",^{
            error = [ApiValidationManager validatePostCommentWithText:@"L"];
            expect(error).to.beFalsy();
        });
        it(@"should pass comment validation",^{
            error = [ApiValidationManager validatePostCommentWithText:@"AWS Elastic Beanstalk makes it even easier for developers to quickly deploy and manage applications in the AWS cloud. Developers simply upload their application, and Elastic"];
            expect(error).to.beFalsy();
        });
        
        it(@"should fail comment validation with short text",^{
            error = [ApiValidationManager validatePostCommentWithText:@""];
            
            NSString *str =[NSString stringWithFormat:@"Text must be at least %d charecter long",kAPIValidationCommentMinLength];
            expect(error.localizedFailureReason).to.equal(str);
            expect(error.localizedDescription).to.equal(@"Invalid Input");
            expect(error.localizedRecoverySuggestion).to.equal(@"Please check and try again");
        });
        
        it(@"should fail comment validation with too long text",^{
            error = [ApiValidationManager validatePostCommentWithText:@"AWS Elastic Beanstalk makes it even easier for developers to quickly deploy and manage applications in the AWS cloud. Developers simply upload their application, and ElasticAWS Elastic Beanstalk makes it even easier for developers to quickly deploy and manage applications in the AWS cloud. Developers simply upload their application, and ElasticAWS Elastic Beanstalk makes it even easier for developers to quickly deploy and manage applications in the AWS cloud. Developers simply upload their application, and Elasticc Beanstalk makes it even easier for developers to quickly deploy and manage applications in the AWS cloud. Developers simply upload their application, and ElasticAWS Elastic Beanstalk makes it even easier for developers to quickly deploy and manage applications in the AWS cloud. Developers simply upload their application, and Elastic"];
            
            NSString *str =[NSString stringWithFormat:@"Text must be shoter than %d charecter long",kAPIValidationCommentMaxLength];
            expect(error.localizedFailureReason).to.equal(str);
            expect(error.localizedDescription).to.equal(@"Invalid Input");
            expect(error.localizedRecoverySuggestion).to.equal(@"Please check and try again");
        });
    });

    
    
});

SpecEnd
