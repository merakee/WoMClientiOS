//
//  ComposeViewHelper.m
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 2/15/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import "ComposeViewHelper.h"
#import "ContentManager.h"

@implementation ComposeViewHelper



#pragma mark -  View Helper Methods: Views
+ (void)setView:(UIView *)view{
    // set app defaults
    [AppUIManager setUIView:view ofType:kAUCPriorityTypePrimary];
    
    // set custom textview properties
    
}

#pragma mark -  View Helper Methods: Segmented control
+ (UISegmentedControl *)getCategoryControl{
    UISegmentedControl *sControl = [[UISegmentedControl alloc] initWithItems:[ContentManager getActiveCategoryList]];
    // set app defaults
    [AppUIManager setUISegmentedControl:sControl];
    
    // set custom  properties
    [ComposeViewHelper  updateCategoryControl:sControl forCategory:kContentCategoryOther];
    return sControl;
}
+ (void)updateCategoryControl:(UISegmentedControl *)sControl forCategory:(ACMContentCategory)category{
    
    if(category==kContentCategoryOther){
        sControl.selectedSegmentIndex=-1;
    }
    
    sControl.tintColor = [AppUIManager getContentColorForCategory:category];
    // selected
    [sControl setTitleTextAttributes:@{NSForegroundColorAttributeName:
                                                  [AppUIManager getContentTextColorForCategory:category andState:UIControlStateSelected]}
                                   forState:UIControlStateSelected];
    // normal
    [sControl setTitleTextAttributes:@{NSForegroundColorAttributeName:
                                                  [AppUIManager getContentTextColorForCategory:category andState:UIControlStateNormal]}
                                   forState:UIControlStateNormal];
    
}
#pragma mark -  View Helper Methods: TextViews
+ (UITextView *)getComposeTextViewWithDelegate:(id)delegate{
    UITextView *textView =[[UITextView alloc] init];
    // set app defaults
    [AppUIManager setTextView:textView ofType:kAUCPriorityTypePrimary];
    
    // set custom textview properties
    //textView.frame = [CommonUtility shrinkRect:kSIVNameFrame byXPoints:10 yPoints:40];  //kSIVNameFrame;
    //textView.backgroundColor = [UIColor colorWithHue:50.0/360 saturation:0.3 brightness:1.0 alpha:1.0];
    //textView.backgroundColor = [UIColor lightGrayColor];
    // textView.text=@"";
    //textView.attributedText =
    //textView.font = [UIFont fontWithName:kSIVTextFontName size:kSIVNameTextFontSize];
    //textView.textColor =[UIColor whiteColor];//[UIColor colorWithHue:kCRDPrimaryHue saturation:0.0 brightness:1.0 alpha:1.0];
    //textView.editable = YES;
    //textView.selectable = YES;
    textView.allowsEditingTextAttributes = NO;
    textView.dataDetectorTypes = UIDataDetectorTypeAll ;
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


@end
