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
    UIImage *buttonImage = [UIImage imageNamed:@"reply-send-btn.png"];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [button.imageView setContentMode:UIViewContentModeScaleAspectFit];
   // button.frame = CGRectMake(0, 0, 40, 40);
    [button setTranslatesAutoresizingMaskIntoConstraints:NO];
    [button setAccessibilityIdentifier:@"SendButton"];
    return button;
}

+ (UIImage *)getCellImage{
    UIImage *accessoryImage = [UIImage imageNamed:@"reply-heart-empty.png"];
    return accessoryImage;
}

+ (CustomLilkeButton *)getCellButton{
    UIImage *image = [UIImage imageNamed:@"reply-heart-empty.png"];
  //  UIImageView *cellImageView = [[UIImageView alloc] initWithImage:image];
   // UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    CustomLilkeButton *button = [[CustomLilkeButton alloc] init];
    // colors and fonts
    button.backgroundColor = [UIColor clearColor];
    // for auto layout
    [button setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [button setImage:image forState:UIControlStateNormal];
    //[button setFrame:CGRectMake(290, 15, 18.0, 18.0)];
    return button;
}

+ (UILabel *)getCellText{
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:kAUCFontFamilySecondary size:16];
    label.textColor =[UIColor colorWithWhite:1.0 alpha:0.42];//[AppUIManager getColorOfType:kAUCColorTypeTextQuinary];
    label.textAlignment = NSTextAlignmentLeft;
    
    label.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.45];//[UIColor whiteColor];
    label.shadowOffset = CGSizeMake(0.0f, 1.0f);
    
    label.numberOfLines = 0;
   
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
    likeLabel.textColor =[UIColor colorWithWhite:1.0 alpha:0.42];//[AppUIManager getColorOfType:kAUCColorTypeTextQuinary];
    likeLabel.textAlignment = NSTextAlignmentCenter;
    
    likeLabel.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.45];//[UIColor whiteColor];
    likeLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
    [likeLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    // accessibilty
    [likeLabel setAccessibilityIdentifier:@"Like Count Label"];
    return likeLabel;
}

+ (UITextView *)getCommentText:(id)delegate{
    UITextView *textView =[[UITextView alloc] init];
    textView.backgroundColor = [UIColor lightGrayColor];
    textView.allowsEditingTextAttributes = NO;
    textView.dataDetectorTypes = UIDataDetectorTypeAll ;
    
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


@end
