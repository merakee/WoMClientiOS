//
//  RepliesViewHelper.m
//  WordOfMouthEngine
//
//  Created by Kevin Moy on 11/10/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import "RepliesViewHelper.h"
#import "ContentManager.h"


@implementation RepliesViewHelper
+ (void)setView:(UIView *)view{
    // set app defaults
    [AppUIManager setUIView:view ofType:kAUCPriorityTypePrimary];
    //view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:[CommonUtility adjustImageFileName:kAUCComposeBackgroundImage]]];
    view.backgroundColor = [AppUIManager getColorOfType:kAUCColorTypeTextQuaternary];//[UIColor whiteColor];
}
#pragma mark -  View Helper Methods: TextViews
+ (UITextView *)getRepliesTextViewWithDelegate:(id)delegate{
    UITextView *textView =[[UITextView alloc] init];
    // set app defaults
    //[AppUIManager setTextView:textView ofType:kAUCPriorityTypePrimary];
    
    // set custom textview properties
    textView.backgroundColor = [UIColor blueColor];
    //textView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.6];
    // textView.text=@"";
    //textView.attributedText =
    //textView.font = [UIFont fontWithName:kAUCFontFamilySecondary size:kAUCFontSizeComposeText];
    //textView.textColor =[AppUIManager getColorOfType:kAUCColorTypeTextQuinary];
    //textView.textColor = [UIColor   whiteColor];
    //[UIColor colorWithHue:kCRDPrimaryHue saturation:0.0 brightness:1.0 alpha:1.0];
    //textView.editable = YES;
    //textView.selectable = YES;
    textView.allowsEditingTextAttributes = NO;
    textView.dataDetectorTypes = UIDataDetectorTypeAll ;
    //textView.textAlignment = NSTextAlignmentLeft;
    //textView.typingAttributes =
    // textView.linkTextAttributes =
    //textView.textContainerInset =
    
    // text shadow: use layer property (UIView)
    //    textView.layer.shadowColor = [UIColor blackColor].CGColor;
    //    textView.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
    //    textView.layer.shadowOpacity = 1.0f;
    //    textView.layer.shadowRadius = 4.0f;
    
    // set up key board
    
    textView.returnKeyType = UIReturnKeyDefault;
    
    // inset for text
    //textView.textContainerInset = UIEdgeInsetsMake(0, 0, 5.0, 0.0);
    
    // attirubtes - ios 7
    NSMutableParagraphStyle *paraStyle = [NSMutableParagraphStyle new];
    paraStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    //    paraStyle.alignment = NSTextAlignmentCenter;
    //paraStyle.lineSpacing = 10;// -kAUCFontSizeContentText/2.0 + 9.0;
    
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowOffset = CGSizeMake(0.0,1.0);
    shadow.shadowBlurRadius = (CGFloat) 2.0;
    shadow.shadowColor = [UIColor colorWithWhite:0.1 alpha:1.0];
    
    textView.typingAttributes = @{
                                  NSFontAttributeName: [UIFont fontWithName:kAUCFontFamilySecondary size:kAUCFontSizeRepliesText],
                                  NSForegroundColorAttributeName:[UIColor whiteColor],
                                  NSParagraphStyleAttributeName:paraStyle,
                                  NSStrokeColorAttributeName:[UIColor blackColor],
                                  //NSStrokeWidthAttributeName:@-3.0,
                                  NSShadowAttributeName:shadow
                                  // NSKernAttributeName:@1.0 // inter letter spacing
                                  };
    
    
    textView.delegate=delegate;
    
    [textView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    // accessibilty
    [textView setAccessibilityIdentifier:@"Add Text"];
    return textView;
}
+ (UIScrollView *)getScrollView{
    float screenW = [CommonUtility getScreenWidth];
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 80, screenW, 420)];
//    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.showsVerticalScrollIndicator=YES;
    scrollView.scrollEnabled=YES;
    scrollView.userInteractionEnabled=YES;
    scrollView.contentSize=CGSizeMake(320, 400);
    scrollView.backgroundColor = [UIColor purpleColor];
    return scrollView;
}
#pragma mark - Input Accessory view buttons
+ (UIButton *)getBackButton{
    UIButton *button =  [AppUIManager getTransparentUIButton];
    [button setImage:[UIImage imageNamed:kAUCXButtonImage] forState:UIControlStateNormal];
    [button setAccessibilityIdentifier:@"Back"];
    return button;
}

+ (UIButton *)getSendButton{
    UIButton *button =  [AppUIManager getTransparentUIButton];
    [button setImage:[UIImage imageNamed:kAUCSendButtonImage] forState:UIControlStateNormal];
    [button setAccessibilityIdentifier:@"Send"];
    return button;
}

#pragma mark -  View Helper Methods: Labels
+ (UILabel *)getPlaceHolderLabel{
    UILabel *phLabel =[[UILabel alloc] init];
    phLabel.backgroundColor = [UIColor clearColor];
    phLabel.text=@"Add reply";
    phLabel.font = [UIFont fontWithName:kAUCFontFamilySecondary size:kAUCFontSizeRepliesText];
    phLabel.textColor =[UIColor colorWithWhite:1.0 alpha:0.42];//[AppUIManager getColorOfType:kAUCColorTypeTextQuinary];
    phLabel.textAlignment = NSTextAlignmentLeft;
    
    phLabel.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.45];//[UIColor whiteColor];
    phLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
    //phLabel.shadowRadius = 4.0f;
    
    
    [phLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    // accessibilty
    [phLabel setAccessibilityIdentifier:@"Place Holder Label"];
    
    return phLabel;
}

@end
