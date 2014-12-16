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
}

#pragma mark - ImageView
+ (UIImageView *)getContentImageView{
    UIImageView *contentImageView =[[UIImageView alloc] init];
    contentImageView.contentMode = UIViewContentModeScaleAspectFill;
    [contentImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    contentImageView.clipsToBounds = YES;
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
    phLabel.text=@"What's on your mind?";
    phLabel.font = [UIFont fontWithName:kAUCFontFamilySecondary size:kAUCFontSizePlaceholder1];
    phLabel.textColor =[UIColor colorWithWhite:1.0 alpha:0.42];//[AppUIManager getColorOfType:kAUCColorTypeTextQuinary];
    phLabel.textAlignment = NSTextAlignmentCenter;
    
    phLabel.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.45];//[UIColor whiteColor];
    phLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
    //phLabel.shadowRadius = 4.0f;
    phLabel.numberOfLines = 0;
    
    [phLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    // accessibilty
    [phLabel setAccessibilityIdentifier:@"Place Holder Label"];
    return phLabel;
}
+ (UILabel *)getPlaceHolderLabel2{
    UILabel *phLabel =[[UILabel alloc] init];
    phLabel.backgroundColor = [UIColor clearColor];
    phLabel.text=@"*Drag to move text";
    phLabel.font = [UIFont fontWithName:kAUCFontFamilySecondary size:kAUCFontSizePlaceholder2];
    phLabel.textColor =[UIColor colorWithWhite:1.0 alpha:0.42];
    phLabel.textAlignment = NSTextAlignmentCenter;
    phLabel.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.45];
    phLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
    phLabel.numberOfLines = 0;
    [phLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [phLabel setAccessibilityIdentifier:@"Place Holder Label 2"];
    return phLabel;
}

+ (UILabel *)getCharacterCountLabel{
    UILabel *ccLabel =[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
   // ccLabel.backgroundColor = [UIColor clearColor];
    [ccLabel setText:@"200"];
    ccLabel.font = [UIFont fontWithName:kAUCFontFamilySecondary size:kAUCFontSizeComposeText];
    ccLabel.textColor =[UIColor colorWithWhite:1.0 alpha:0.42];//[AppUIManager getColorOfType:kAUCColorTypeTextQuinary];
    ccLabel.textAlignment = NSTextAlignmentCenter;
   
    ccLabel.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.45];//[UIColor whiteColor];
    ccLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
    //phLabel.shadowRadius = 4.0f;

    
    [ccLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    // accessibilty
    [ccLabel setAccessibilityIdentifier:@"Character Count Label"];
    
    return ccLabel;
}
#pragma mark -  View Helper Methods: TextViews
+ (UITextView *)getComposeTextViewWithDelegate:(id)delegate{
    UITextView *textView =[[UITextView alloc] init];
  //  NSLog(@"....1...");
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
    textView.returnKeyType = UIReturnKeyDefault;
    
    // inset for text
    //textView.textContainerInset = UIEdgeInsetsMake(0, 0, 5.0, 0.0);
    // attirubtes - ios 7
    NSMutableParagraphStyle *paraStyle = [NSMutableParagraphStyle new];
    paraStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paraStyle.alignment = NSTextAlignmentCenter;
    
    
    //paraStyle.lineSpacing = 10;// -kAUCFontSizeContentText/2.0 + 9.0;
    
    NSShadow *shadow = [[NSShadow alloc] init];
//    shadow.shadowOffset = CGSizeMake(0.0,1.0);
//    shadow.shadowBlurRadius = (CGFloat) 2.0;
//    shadow.shadowColor = [UIColor colorWithWhite:0.1 alpha:1.0];
    
    textView.typingAttributes = @{
                                  NSFontAttributeName: [UIFont fontWithName:kAUCFontFamilySecondary size:kAUCFontSizeComposeText],
                                  NSForegroundColorAttributeName:[UIColor whiteColor],
                                  NSParagraphStyleAttributeName:paraStyle,
                                  NSStrokeColorAttributeName:[CommonUtility getColorFromHSBACVec:kAUTextStrokeColor],
                                  NSStrokeWidthAttributeName:@-4.0,
                                  NSShadowAttributeName:shadow,
                                  NSKernAttributeName:@1.0 // inter letter spacing
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
    [button setImage:[UIImage imageNamed:kAUCBackButtonImage] forState:UIControlStateNormal];
    [button setFrame:CGRectMake(0, 0, 30, 30)];
    [button setAccessibilityIdentifier:@"Cancel"];
    return button;
}
+ (UIButton *)getPostButton{
    UIButton *button =  [AppUIManager getTransparentUIButton];
    [button setImage:[UIImage imageNamed:kAUCComposeSpreadButtonImage] forState:UIControlStateNormal];
    [button setFrame:CGRectMake(0, 0, 61, 27)];
    [button setAccessibilityIdentifier:@"Post"];
    return button;
}
+ (UIButton *)getCameraOptionsButton{
    UIButton *button =  [AppUIManager getTransparentUIButton];
    [button setImage:[UIImage imageNamed:kAUCCameraOptionsButtonImage] forState:UIControlStateNormal];
    [button setAccessibilityIdentifier:@"Camera Options"];
    return button;
}

#pragma mark - Input Accessory view buttons
+ (UIButton *)getBackButton{
    UIButton *button =  [AppUIManager getTransparentUIButton];
    [button setImage:[UIImage imageNamed:kAUCCancelButtonImage] forState:UIControlStateNormal];
    [button setAccessibilityIdentifier:@"Back"];
    return button;
}

+ (UIButton *)getDoneButton{
    UIButton *button =  [AppUIManager getTransparentUIButton];
    [button setTitle:@"Done" forState:UIControlStateNormal];
    [button setAccessibilityIdentifier:@"Done"];
    return button;
}
+ (UIButton *)getRemoveImageButton{
    UIButton *button =  [AppUIManager getTransparentUIButton];
    [button setImage:[UIImage imageNamed:kAUCDeleteImageButtonImage] forState:UIControlStateNormal];
    [button setTranslatesAutoresizingMaskIntoConstraints:NO];
    [button setAccessibilityIdentifier:@"Remove Image"];
    return button;
}

#pragma mark - Toolbar Buttons
+ (UIButton *)getTextButton{
    UIImage *buttonImage = [UIImage imageNamed:@"text-btn.png"];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [button.imageView setContentMode:UIViewContentModeScaleAspectFit];
 //   button.frame = CGRectMake(0, 0, 56, 57);
    [button setTranslatesAutoresizingMaskIntoConstraints:NO];
    [button setAccessibilityIdentifier:@"TextButton"];
    return button;
}

+ (UIButton *)getImageButton{
    UIImage *buttonImage = [UIImage imageNamed:@"photo-btn.png"];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [button.imageView setContentMode:UIViewContentModeScaleAspectFit];
 //   button.frame = CGRectMake(0, 0, 56, 57);
    [button setTranslatesAutoresizingMaskIntoConstraints:NO];
    [button setAccessibilityIdentifier:@"ImageButton"];
    return button;
}

+ (UIButton *)getFilterButton{
    UIImage *buttonImage = [UIImage imageNamed:@"mapicon.jpeg"];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [button.imageView setContentMode:UIViewContentModeScaleAspectFit];
    button.frame = CGRectMake(0, 0, 20, 20);
    [button setAccessibilityIdentifier:@"FilterButton"];
    return button;
}

#pragma mark - Accessory Buttons
+ (UIButton *)getXButton{
    UIImage *buttonImage = [UIImage imageNamed:kAUCClearIconButtonImage];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [button.imageView setContentMode:UIViewContentModeScaleAspectFit];
    button.frame = CGRectMake(0, 0, 16, 16);
    [button setAccessibilityIdentifier:@"XButton"];
    return button;
}

+ (UIButton *)getCheckButton{
    UIImage *buttonImage = [UIImage imageNamed:kAUCCheckIconButtonImage];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [button.imageView setContentMode:UIViewContentModeScaleAspectFit];
    button.frame = CGRectMake(0, 0, 20, 16);
    [button setAccessibilityIdentifier:@"CheckButton"];
    return button;
}

+ (UIButton *)getTextColorButton{
    UIImage *buttonImage = [UIImage imageNamed:kAUCTextColorButtonImage];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [button.imageView setContentMode:UIViewContentModeScaleAspectFit];
    button.frame = CGRectMake(0, 0, 36, 28);
    [button setAccessibilityIdentifier:@"BackgroundButton"];
    return button;
}

+ (UIButton *)getKeyboardButton{
    UIImage *buttonImage = [UIImage imageNamed:kAUCKeyboardButtonImage];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [button.imageView setContentMode:UIViewContentModeScaleAspectFit];
    button.frame = CGRectMake(0, 0, 36, 28);
    [button setAccessibilityIdentifier:@"KeyboardButton"];
    return button;
}

+ (UIButton *)getColor1{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
   // [button setBackgroundColor:[CommonUtility getColorFromHSBACVec:kAUTextColor1]];
    [button setBackgroundColor:[UIColor whiteColor]];
    button.layer.cornerRadius = 4;
    [[button layer] setBorderWidth:3.0f];
    [button setAccessibilityIdentifier:@"Color1"];
    return button;
}

+ (UIButton *)getColor2{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundColor:[CommonUtility getColorFromHSBACVec:kAUTextColor2]];
    button.layer.cornerRadius = 4;
    [button setAccessibilityIdentifier:@"Color2"];
    return button;
}

+ (UIButton *)getColor3{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundColor:[CommonUtility getColorFromHSBACVec:kAUTextColor3]];
    button.layer.cornerRadius = 4;
    [button setAccessibilityIdentifier:@"Color3"];
    return button;
}

+ (UIButton *)getColor4{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundColor:[CommonUtility getColorFromHSBACVec:kAUTextColor4]];
    button.layer.cornerRadius = 4;
    [button setAccessibilityIdentifier:@"Color4"];
    return button;
}

+ (UIButton *)getColor5{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundColor:[CommonUtility getColorFromHSBACVec:kAUTextColor5]];
    button.layer.cornerRadius = 4;
    [button setAccessibilityIdentifier:@"Color5"];
    return button;
}
+ (UIButton *)getColor6{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundColor:[CommonUtility getColorFromHSBACVec:kAUTextColor6]];
    button.layer.cornerRadius = 4;
    [button setAccessibilityIdentifier:@"Color6"];
    return button;
}
+ (UIButton *)getColor7{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundColor:[CommonUtility getColorFromHSBACVec:kAUTextColor7]];
    button.layer.cornerRadius = 4;
    [button setAccessibilityIdentifier:@"Color7"];
    return button;
}
+ (UIButton *)getColor8{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundColor:[CommonUtility getColorFromHSBACVec:kAUTextColor8]];
    button.layer.cornerRadius = 4;
    [[button layer] setBorderWidth:3.0f];
    [button setAccessibilityIdentifier:@"Color8"];
    return button;
}
@end
