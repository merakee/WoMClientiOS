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
+ (void)setView:(UIView *)view{
    // set app defaults
    [AppUIManager setUIView:view ofType:kAUCPriorityTypePrimary];
    
    // set custom textview properties
    
}
+ (UIImageView *)getContentBackGroundView{
    UIImageView *contentBackGround = [[UIImageView alloc] init];
    contentBackGround.backgroundColor =[AppUIManager getContentColorForCategory:1];
    contentBackGround.contentMode = UIViewContentModeScaleAspectFit;
    [contentBackGround setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    return contentBackGround;
}
+ (UIImage *)getImageForContentBackGroudView{
    NSString *fileName =[[@"bg" stringByAppendingFormat:@"%d",[CommonUtility pickRandom:4]+1] stringByAppendingString:@".jpg"];
    return [UIImage imageNamed:fileName];
}
+ (void)updateContentBackGroundView:(UIView *)view forCategory:(kAPIContentCategory)category{
    //view.backgroundColor = [AppUIManager getContentColorForCategory:category];
}

#pragma mark - View Helper Methods: Image Views
+ (UIImageView *)getUserImageView{
    UIImageView *iv =[[UIImageView alloc] init];
    // set app defaults
    [AppUIManager setImageView:iv];
    
    return iv;
}

#pragma mark -  View Helper Methods: TextViews
+ (UITextView *)getContentTextViewWithDelegate:(id)delegate{
    UITextView *textView =[[UITextView alloc] init];
    // set app defaults
    [AppUIManager setTextView:textView ofType:kAUCPriorityTypePrimary];
    
    // set custom textview properties
    //textView.frame = [CommonUtility shrinkRect:kSIVNameFrame byXPoints:10 yPoints:40];  //kSIVNameFrame;
    //textView.backgroundColor = [UIColor clearColor];
    textView.backgroundColor = [UIColor  colorWithWhite:1.0 alpha:.8];
    
    //textView.backgroundColor = [UIColor lightGrayColor];
    // textView.text=@"";
    //textView.attributedText =
    //textView.font = [UIFont fontWithName:kSIVTextFontName size:kSIVNameTextFontSize];
    //textView.textColor =[UIColor whiteColor];//[UIColor colorWithHue:kCRDPrimaryHue saturation:0.0 brightness:1.0 alpha:1.0];
    textView.editable = NO;
    textView.selectable = YES;
    textView.allowsEditingTextAttributes = NO;
    textView.scrollEnabled = NO;
    //textView.dataDetectorTypes = UIDataDetectorTypeAll ;
    //textView.textAlignment = NSTextAlignmentCenter;
    //textView.typingAttributes =
    // textView.linkTextAttributes =
    //textView.textContainerInset =
    
    // text shadow: use layer property (UIView)
    //textView.layer.shadowColor = [HEXCOLOR (kCRDShadowWhiteColor) CGColor];
    //textView.layer.shadowColor = [HEXCOLOR (kCRDTextDropShadowColor) CGColor];
    // textView.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    // textView.layer.shadowOpacity = 0.6f;
    // textView.layer.shadowRadius = 0.0f;
    
    // set up key board
    //textView.returnKeyType = UIReturnKeyDone;
    
    textView.delegate=delegate;
    
    return textView;
}

#pragma mark -  View Helper Methods: Buttons
+ (UIButton *)getSpreadButton{
    return [AppUIManager setButtonWithTitle:@"spread" ofType:kAUCPriorityTypeTertiary];
}
+ (UIButton *)getKillButton{
    //UIButton *button  = [AppUIManager setButtonWithTitle:@"kill" ofType:kAUCPriorityTypeTertiary];
    UIButton *button  = [AppUIManager setButtonWithTitle:@"kill" andColor:[UIColor redColor]];
    
    // cutom settings
    //button.backgroundColor = [UIColor redColor];
    
    return button;
}

#pragma mark - Text label mathods
+ (UILabel *)getTextLabelForSpreadCount{
    UILabel *textLabel= [[UILabel alloc] init];
    // set app defaults
    [AppUIManager setUILabel:textLabel ofType:kAUCPriorityTypePrimary];
    
    return textLabel;
}
+ (UILabel *)getTextLabelForTimeCount{
    UILabel *textLabel= [[UILabel alloc] init];
    // set app defaults
    [AppUIManager setUILabel:textLabel ofType:kAUCPriorityTypeSecondary];
    
    return textLabel;
}

#pragma mark -  View Helper Methods: ProgressViewb
+ (CVCircleCounterView *)getCounterViewWithDelegate:(id)delegate{
    CVCircleCounterView *circleView = [[CVCircleCounterView alloc] init];
    circleView.delegate = delegate;
    
    // custom look
    circleView.numberColor = [AppUIManager getColorOfType:kAUCColorTypePrimary]; //< Black, By Default
    circleView.numberFont = [UIFont fontWithName:kAUCFontFamilyPrimary size:kAUCFontSizePrimary]; //< Courier-Bold 20, By Default
    
    circleView.circleColor = [AppUIManager getColorOfType:kAUCColorTypePrimary]; //< Black, By Default
    circleView.circleDoneColor = [UIColor redColor]; //< Black, By Default
    circleView.circleBorderWidth = 1.0; //< 6 pixels, By Default
    circleView.circleTimeInterval = kAUCAppContentTimerMax;
    circleView.backgroundColor =[UIColor clearColor];
    
    //circleView.circleIncre=YES;
    
    // Auto layout
    [circleView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    return circleView;
}
@end
