//
//  CommentViewHelper.m
//  WordOfMouthEngine
//
//  Created by Kevin Moy on 11/11/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import "CommentViewHelper.h"
#import "ContentManager.h"

@implementation CommentViewHelper

+ (void)setView:(UIView *)view{
    // set app defaults
    [AppUIManager setUIView:view ofType:kAUCPriorityTypePrimary];
    //view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:[CommonUtility adjustImageFileName:kAUCComposeBackgroundImage]]];
    view.backgroundColor = [AppUIManager getColorOfType:kAUCColorTypeTextQuaternary];//[UIColor whiteColor];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    return self;
}

#pragma mark - Buttons
+ (UIButton *)getSendButton{
    UIImage *buttonImage = [UIImage imageNamed:kAURSendButtonImage];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [button.imageView setContentMode:UIViewContentModeScaleAspectFit];
   // button.frame = CGRectMake(0, 0, 40, 40);
    [button setTranslatesAutoresizingMaskIntoConstraints:NO];
    [button setAccessibilityIdentifier:@"SendButton"];
    return button;
}

+ (CustomLilkeButton *)getCellButton{
    CustomLilkeButton *button = [CustomLilkeButton buttonWithType:UIButtonTypeCustom];
    [button setTranslatesAutoresizingMaskIntoConstraints:NO];
    button.didLike = false;
 //   [button setImage:[UIImage imageNamed:kAURFilledLikeImage] forState:UIControlStateNormal];
    return button;
}

+ (UILabel *)getCellText{
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:kAUCFontFamilySecondary size:kAUCFontSizeRepliesText];
    label.textColor =[CommonUtility getColorFromHSBACVec:kAUCColorSecondary];
    label.textAlignment = NSTextAlignmentLeft;

  //  label.numberOfLines = 0;
   
    [label setNumberOfLines:0];
    label.lineBreakMode = NSLineBreakByWordWrapping;
    [label setTranslatesAutoresizingMaskIntoConstraints:NO];
    // accessibilty
    [label setAccessibilityIdentifier:@"Comment Text"];
    return label;
}
+ (UILabel *)getLikeCount{
    UILabel *likeLabel =[[UILabel alloc] init];
    // ccLabel.backgroundColor = [UIColor clearColor];
    likeLabel.font = [UIFont fontWithName:kAUCFontFamilySecondary size:kAUCFontSizeLikeLabel];
    likeLabel.textColor =[CommonUtility getColorFromHSBACVec:kAUCColorPrimary];
    likeLabel.textAlignment = NSTextAlignmentCenter;
//    likeLabel.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.45];//[UIColor whiteColor];
//    likeLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
    [likeLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    // accessibilty
    [likeLabel setAccessibilityIdentifier:@"Like Count Label"];
    return likeLabel;
}
+ (UIButton *)getTouchLike{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTranslatesAutoresizingMaskIntoConstraints:NO];
 //   [button setBackgroundColor:[UIColor redColor]];
    return button;
}
+ (UITextView *)getCommentText:(id)delegate{
    UITextView *textView =[[UITextView alloc] init];
    textView.backgroundColor = [CommonUtility getColorFromHSBACVec:kAUCommentTextColor];
    textView.allowsEditingTextAttributes = NO;
    textView.dataDetectorTypes = UIDataDetectorTypeAll ;
    
    
    textView.returnKeyType = UIReturnKeyDefault;
    // inset for text
    //textView.textContainerInset = UIEdgeInsetsMake(0, 0, 5.0, 0.0);
    
    // attirubtes - ios 7
    NSMutableParagraphStyle *paraStyle = [NSMutableParagraphStyle new];
    paraStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    //    paraStyle.alignment = NSTextAlignmentCenter;
    //paraStyle.lineSpacing = 10;// -kAUCFontSizeContentText/2.0 + 9.0;
    
//    NSShadow *shadow = [[NSShadow alloc] init];
//    shadow.shadowOffset = CGSizeMake(0.0,1.0);
//    shadow.shadowBlurRadius = (CGFloat) 2.0;
//    shadow.shadowColor = [UIColor colorWithWhite:0.1 alpha:1.0];
    
    textView.typingAttributes = @{
                                  NSFontAttributeName: [UIFont fontWithName:kAUCFontFamilySecondary size:kAUCFontSizeComposeText],
                                  NSForegroundColorAttributeName:[CommonUtility getColorFromHSBACVec:kAUCColorSecondary],
                                  NSParagraphStyleAttributeName:paraStyle,
                                //  NSStrokeColorAttributeName:[UIColor blackColor],
                                  //NSStrokeWidthAttributeName:@-3.0,
                                 // NSShadowAttributeName:shadow
                                  // NSKernAttributeName:@1.0 // inter letter spacing
                                  };
    textView.layer.cornerRadius = 6;
    textView.delegate=delegate;
    
    [textView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    // accessibilty
    [textView setAccessibilityIdentifier:@"Add Text"];
    return textView;
}

+ (UIButton *)getCancelButton{
    UIButton *button = [AppUIManager getTransparentUIButton];
    [button setImage:[UIImage imageNamed:kAURCloseButtonImage] forState:UIControlStateNormal];
    [button setFrame:CGRectMake(0, 0, 40, 40)];
    [button setAccessibilityIdentifier:@"Cancel"];
    return button;
}

@end
