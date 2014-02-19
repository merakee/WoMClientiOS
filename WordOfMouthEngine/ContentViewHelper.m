//
//  ContentViewHelper.m
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 2/15/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import "ContentViewHelper.h"

@implementation ContentViewHelper



#pragma mark -  View Helper Methods: Views


#pragma mark -  View Helper Methods: TextViews
+ (void)setContentTextView:(UITextView *)tv withDelegate:(id)delegate{
    // set textviewproperties
    //tv.frame = [CommonUtility shrinkRect:kSIVNameFrame byXPoints:10 yPoints:40];  //kSIVNameFrame;
    //tv.backgroundColor = [UIColor colorWithHue:50.0/360 saturation:0.3 brightness:1.0 alpha:1.0];
    tv.backgroundColor = [UIColor lightGrayColor];
    // tv.text=@"";
    //tv.attributedText =
    //tv.font = [UIFont fontWithName:kSIVTextFontName size:kSIVNameTextFontSize];
    tv.textColor =[UIColor whiteColor];//[UIColor colorWithHue:kCRDPrimaryHue saturation:0.0 brightness:1.0 alpha:1.0];
    tv.editable = NO;
    tv.selectable = YES;
    tv.allowsEditingTextAttributes = NO;
    tv.dataDetectorTypes = UIDataDetectorTypeAll ;
    tv.textAlignment = NSTextAlignmentCenter;
    //tv.typingAttributes =
    // tv.linkTextAttributes =
    //tv.textContainerInset =
    
    tv.delegate=delegate;
    
    // text shadow: use layer property (UIView)
    //tv.layer.shadowColor = [HEXCOLOR (kCRDShadowWhiteColor) CGColor];
    //tv.layer.shadowColor = [HEXCOLOR (kCRDTextDropShadowColor) CGColor];
    // tv.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    // tv.layer.shadowOpacity = 0.6f;
    // tv.layer.shadowRadius = 0.0f;
    
    // set up key board
    //tv.returnKeyType = UIReturnKeyDone;
    
    // for auto layout
    [tv setTranslatesAutoresizingMaskIntoConstraints:NO];
    
}

#pragma mark -  View Helper Methods: Buttons
+ (UIButton *)getSpreadButton{
    UIButton *button  = [UIButton buttonWithType:UIButtonTypeSystem];
    button.backgroundColor = [UIColor greenColor];
    // set button properties
    //button.frame = CGRectMake(20,200,160,90);
    // for auto layout
    [button setTranslatesAutoresizingMaskIntoConstraints:NO];
    [button setTitle:@"spread" forState:UIControlStateNormal];
    
    return button;
}
+ (UIButton *)getKillButton{
    UIButton *button  = [UIButton buttonWithType:UIButtonTypeSystem];
    button.backgroundColor = [UIColor redColor];
    // set button properties
    //button.frame = CGRectMake(1000,200,80,30);
    // for auto layout
    [button setTranslatesAutoresizingMaskIntoConstraints:NO];
    [button setTitle:@"kill" forState:UIControlStateNormal];
    
    return button;
}

@end
