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
#pragma mark - Views
+ (void)setView:(UIView *)view{
    // set app defaults
    [AppUIManager setUIView:view ofType:kAUCPriorityTypePrimary];
    //view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:[CommonUtility adjustImageFileName:kAUCComposeBackgroundImage]]];
    view.backgroundColor = [AppUIManager getColorOfType:kAUCColorTypeTextQuaternary];//[UIColor whiteColor];
}
+ (UIView *)getNavigationShadow{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:kAURNavigationViewImage]];

    [view setTranslatesAutoresizingMaskIntoConstraints:NO];
    return view;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    return self;
}

#pragma mark - Image Views
+ (CustomContentView *)getContentView{
    CustomContentView *view = [[CustomContentView alloc] init];
//    contentImageView.contentMode = UIViewContentModeScaleAspectFill;
//    [contentImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
//    contentImageView.clipsToBounds = YES;
    [view setTranslatesAutoresizingMaskIntoConstraints:NO];
    return view;
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
+ (CustomFavoriteButton *)getFavoriteButton{
    CustomFavoriteButton *button = [CustomFavoriteButton buttonWithType:UIButtonTypeCustom];
    [button setTranslatesAutoresizingMaskIntoConstraints:NO];
    button.didFavorite = false;
    return button;
}
+ (CustomLikeButton *)getCellButton{
    CustomLikeButton *button = [CustomLikeButton buttonWithType:UIButtonTypeCustom];
    [button setTranslatesAutoresizingMaskIntoConstraints:NO];
    button.didLike = false;
 //   [button setImage:[UIImage imageNamed:kAURFilledLikeImage] forState:UIControlStateNormal];
    return button;
}

+ (UIButton *)getShareButton{
    UIButton *button = [AppUIManager getTransparentUIButton];
    [button setImage:[UIImage imageNamed:kAUCShareButtonImage] forState:UIControlStateNormal];
    [button setAccessibilityIdentifier:@"Share"];
    return button;
}
+ (UIButton *)getReportButton{
    UIButton *button =  [AppUIManager getTransparentUIButton];
    [button setImage:[UIImage imageNamed:kAUCReportButtonImage] forState:UIControlStateNormal];
    [button setAccessibilityIdentifier:@"ReportButton"];
    return button;
}
#pragma mark - Content Data
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
    textView.text = @"add your reply";
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
#pragma mark - User Data
+ (UILabel *)getNickname{
    UILabel *label = [[UILabel alloc] init];
    [label setFont: [UIFont fontWithName:kAUCFontFamilySecondary size:kAUCFontSizeSpreadCount]];
    label.textColor = [UIColor whiteColor];
    label.shadowOffset = CGSizeMake(1, 1);
    label.textAlignment = NSTextAlignmentLeft;
    [label setTranslatesAutoresizingMaskIntoConstraints:NO];
    return label;
}
+ (UIImageView *)getProfilePic{
    UIImageView *image = [[UIImageView alloc] init];
    image.contentMode = UIViewContentModeScaleAspectFill;
    [image setTranslatesAutoresizingMaskIntoConstraints:NO];
    return image;
}
#pragma mark - Content Table View
+ (UIView *)getCommentCountView{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor lightGrayColor];
    [view setTranslatesAutoresizingMaskIntoConstraints:NO];
    return view;
}
+ (UILabel *)getCommentCount{
    UILabel *label = [[UILabel alloc] init];
    [label setFont: [UIFont fontWithName:kAUCFontFamilySecondary size:kAUCFontSizeSpreadCount]];
    label.textColor = [UIColor whiteColor];
    label.shadowOffset = CGSizeMake(1, 1);
   // label.textAlignment = NSTextAlignmentLeft;
    [label setTranslatesAutoresizingMaskIntoConstraints:NO];
    return label;
}
@end
