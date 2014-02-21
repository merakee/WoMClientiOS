//
//  SignInViewHelper.m
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 2/15/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import "SignInViewHelper.h"

@implementation SignInViewHelper



#pragma mark -  View Helper Methods: Views



#pragma mark -  View Helper Methods: Buttons
+ (UIButton *)getGoogleButton{
    UIButton *button  = [UIButton buttonWithType:UIButtonTypeCustom];
    // set image
    [button setImage:[UIImage imageNamed:kLIVCGoogleButtonImage] forState:UIControlStateNormal];
    //[button setTitle:@"Google+" forState:UIControlStateNormal];
    //button.backgroundColor = [UIColor greenColor];
    // set button properties
    //button.frame = CGRectMake(20,200,160,90);
    // for auto layout
    [button setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    return button;
}
+ (UIButton *)getFacebookButton{    UIButton *button  = [UIButton buttonWithType:UIButtonTypeCustom];
    // set image
    [button setImage:[UIImage imageNamed:kLIVCFacebookButtonImage] forState:UIControlStateNormal];
    //[button setTitle:@"Google+" forState:UIControlStateNormal];
    //button.backgroundColor = [UIColor greenColor];
    // set button properties
    //button.frame = CGRectMake(20,200,160,90);
    // for auto layout
    [button setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    return button;
}

+ (UIButton *)getTwitterButton{
    UIButton *button  = [UIButton buttonWithType:UIButtonTypeCustom];
    // set image
    [button setImage:[UIImage imageNamed:kLIVCTwitterButtonImage] forState:UIControlStateNormal];
    //[button setTitle:@"Google+" forState:UIControlStateNormal];
    //button.backgroundColor = [UIColor greenColor];
    // set button properties
    //button.frame = CGRectMake(20,200,160,90);
    // for auto layout
    [button setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    return button;
}
+ (UIButton *)getEmailButton{
    UIButton *button  = [UIButton buttonWithType:UIButtonTypeCustom];
    // set image
    [button setImage:[UIImage imageNamed:kLIVCEmailButtonImage] forState:UIControlStateNormal];
    //[button setTitle:@"Google+" forState:UIControlStateNormal];
    //button.backgroundColor = [UIColor greenColor];
    // set button properties
    //button.frame = CGRectMake(20,200,160,90);
    // for auto layout
    [button setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    return button;
}
@end
