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
    //view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:[CommonUtility adjustImageFileName:kAUCComposeBackgroundImage]]];
    view.backgroundColor = [AppUIManager getColorOfType:kAUCColorTypeTextQuaternary];//[UIColor whiteColor];
}

#pragma mark - ImageView
+ (UIImageView *)getContentImageView{
    UIImageView *contentImageView =[[UIImageView alloc] init];
    contentImageView.contentMode = UIViewContentModeScaleAspectFill;
    [contentImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    return contentImageView;
}

#pragma mark -  View Helper Methods: Segmented control
//+ (UISegmentedControl *)getCategoryControl{
//    UISegmentedControl *sControl = [[UISegmentedControl alloc] initWithItems:[ContentManager getActiveCategoryList]];
//    // set app defaults
//    [AppUIManager setUISegmentedControl:sControl];
//
//    // set custom  properties
//    [ComposeViewHelper  updateCategoryControl:sControl forCategory:kAPIContentCategoryOther];
//    return sControl;
//}
//+ (void)updateCategoryControl:(UISegmentedControl *)sControl forCategory:(kAPIContentCategory)category{
//
//    if(category==kAPIContentCategoryOther){
//        sControl.selectedSegmentIndex=-1;
//    }
//
//    sControl.tintColor = [AppUIManager getContentColorForCategory:category];
//    // selected
//    [sControl setTitleTextAttributes:@{NSForegroundColorAttributeName:
//                                           [AppUIManager getContentTextColorForCategory:category andState:UIControlStateSelected]}
//                            forState:UIControlStateSelected];
//    // normal
//    [sControl setTitleTextAttributes:@{NSForegroundColorAttributeName:
//                                           [AppUIManager getContentTextColorForCategory:category andState:UIControlStateNormal]}
//                            forState:UIControlStateNormal];
//
//}

#pragma mark -  View Helper Methods: TextViews
+ (UILabel *)getPlaceHolderLabel{
    UILabel *phLabel =[[UILabel alloc] init];
    phLabel.backgroundColor = [UIColor clearColor];
    phLabel.text=@"ADD YOUR POST";
    phLabel.font = [UIFont fontWithName:kAUCFontFamilySecondary size:kAUCFontSizeComposeText];
    phLabel.textColor =[UIColor colorWithWhite:1.0 alpha:0.42];//[AppUIManager getColorOfType:kAUCColorTypeTextQuinary];
    phLabel.textAlignment = NSTextAlignmentCenter;
    
    phLabel.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.45];//[UIColor whiteColor];
    phLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
    //phLabel.shadowRadius = 4.0f;
    
    
    [phLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    // accessibilty
    [phLabel setAccessibilityIdentifier:@"Place Holder Label"];
    
    return phLabel;
}
#pragma mark -  View Helper Methods: TextViews
+ (UITextView *)getComposeTextViewWithDelegate:(id)delegate{
    UITextView *textView =[[UITextView alloc] init];
    // set app defaults
    //[AppUIManager setTextView:textView ofType:kAUCPriorityTypePrimary];
    
    // set custom textview properties
    textView.backgroundColor = [UIColor clearColor];
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
    textView.returnKeyType = UIReturnKeyDone;
    
    // inset for text
    //textView.textContainerInset = UIEdgeInsetsMake(0, 0, 5.0, 0.0);
    
    // attirubtes - ios 7
    NSMutableParagraphStyle *paraStyle = [NSMutableParagraphStyle new];
    paraStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    //paraStyle.lineSpacing = 10;// -kAUCFontSizeContentText/2.0 + 9.0;
    
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowOffset = CGSizeMake(0.0,1.0);
    shadow.shadowBlurRadius = (CGFloat) 2.0;
    shadow.shadowColor = [UIColor colorWithWhite:0.1 alpha:1.0];
    
    textView.typingAttributes = @{
                                  NSFontAttributeName: [UIFont fontWithName:kAUCFontFamilySecondary size:kAUCFontSizeComposeText],
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

#pragma mark - photo options view
//+ (UIView *)getPhotoOptionView{
//    UIView *view =[[UIView alloc] init ];
//    //WithFrame:CGRectMake(kPhotoOptionsViewLayout[0],kPhotoOptionsViewLayout[1],kPhotoOptionsViewLayout[2],kPhotoOptionsViewLayout[3])];
//    //view.backgroundColor = [UIColor whiteColor];
//    [view addSubview:[[UIImageView alloc] initWithImage:[UIImage imageNamed:kAUCCameraOptionsImage]]];
//    [view setTranslatesAutoresizingMaskIntoConstraints:NO];
//    return view;
//}
+ (UIButton *)getCameraButton{
    // return [AppUIManager setButtonWithTitle:@"camera" ofType:kAUCPriorityTypePrimary];
    UIButton *button =  [AppUIManager getTransparentUIButton];
    
    [button setAccessibilityIdentifier:@"Camera"];
    return button;
}
+ (UIButton *)getAlbumButton{
    //    UIButton *button  = [AppUIManager setButtonWithTitle:@"album" ofType:kAUCPriorityTypePrimary];
    //    //UIButton *button  = [AppUIManager setButtonWithTitle:@"album" andColor:[UIColor redColor]];
    //
    //    // cutom settings
    //    //button.backgroundColor = [UIColor redColor];
    //
    //    return button;
    UIButton *button =  [AppUIManager getTransparentUIButton];
    
    [button setAccessibilityIdentifier:@"Album"];
    return button;
    
}
+ (UIButton *)getCancelButton{
    UIButton *button =  [AppUIManager getTransparentUIButton];
    [button setImage:[UIImage imageNamed:kAUCCancelButtonImage] forState:UIControlStateNormal];
    [button setAccessibilityIdentifier:@"Cancel"];
    return button;
}
+ (UIButton *)getPostButton{
    //    UIButton *button =[AppUIManager getTransparentUIButtonWithTitle:@"Post"
    //                                                              color:kAUCColorTypeTextSecondary
    //                                                               font:kAUCFontFamilyPrimary
    //                                                               size:kAUCFontSizeButtonNormal];
    //    [button setTitleColor:[AppUIManager getColorOfType:kAUCColorTypeTextQuaternary] forState:UIControlStateDisabled];
    
    UIButton *button =  [AppUIManager getTransparentUIButton];
    [button setImage:[UIImage imageNamed:kAUCPostButtonImage] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:kAUCPostInactiveButtonImage] forState:UIControlStateDisabled];
    
    [button setAccessibilityIdentifier:@"Post"];
    return button;
}
+ (UIButton *)getCameraOptionsButton{
    UIButton *button =  [AppUIManager getTransparentUIButton];
    [button setImage:[UIImage imageNamed:kAUCCameraOptionsButtonImage] forState:UIControlStateNormal];
    [button setAccessibilityIdentifier:@"Camera Options"];
    return button;
}

@end
