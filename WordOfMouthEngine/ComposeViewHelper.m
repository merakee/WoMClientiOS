//
//  ComposeViewHelper.m
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 2/15/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import "ComposeViewHelper.h"

@implementation ComposeViewHelper



#pragma mark -  View Helper Methods: Views


#pragma mark -  View Helper Methods: TextViews
+ (void)setContentTextView:(UITextView *)textView withDelegate:(id)delegate{
    // set textviewproperties
    //textView.frame = [CommonUtility shrinkRect:kSIVNameFrame byXPoints:10 yPoints:40];  //kSIVNameFrame;
    //textView.backgroundColor = [UIColor colorWithHue:50.0/360 saturation:0.3 brightness:1.0 alpha:1.0];
    textView.backgroundColor = [UIColor lightGrayColor];
    // textView.text=@"";
    //textView.attributedText =
    //textView.font = [UIFont fontWithName:kSIVTextFontName size:kSIVNameTextFontSize];
    textView.textColor =[UIColor whiteColor];//[UIColor colorWithHue:kCRDPrimaryHue saturation:0.0 brightness:1.0 alpha:1.0];
    textView.editable = YES;
    textView.selectable = YES;
    textView.allowsEditingTextAttributes = NO;
    textView.dataDetectorTypes = UIDataDetectorTypeAll ;
    textView.textAlignment = NSTextAlignmentCenter;
    //textView.typingAttributes =
    // textView.linkTextAttributes =
    //textView.textContainerInset =
    
    textView.delegate=delegate;
    
    // text shadow: use layer property (UIView)
    //textView.layer.shadowColor = [HEXCOLOR (kCRDShadowWhiteColor) CGColor];
    //textView.layer.shadowColor = [HEXCOLOR (kCRDTextDropShadowColor) CGColor];
    // textView.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    // textView.layer.shadowOpacity = 0.6f;
    // textView.layer.shadowRadius = 0.0f;
    
    // set up key board
    textView.keyboardType = UIKeyboardTypeAlphabet;
    textView.returnKeyType = UIReturnKeyDefault;
    
    // for auto layout
    [textView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
}

#pragma mark -  View Helper Methods: Buttons


@end
