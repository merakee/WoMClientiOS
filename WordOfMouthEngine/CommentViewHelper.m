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
    button.frame = CGRectMake(0, 0, 40, 40);
    [button setAccessibilityIdentifier:@"SendButton"];
    return button;
}

+ (UIImage *)getCellImage{
    UIImage *accessoryImage = [UIImage imageNamed:@"reply-heart-empty.png"];
    return accessoryImage;
}

+ (UIButton *)getCellButton{
    UIImage *image = [UIImage imageNamed:@"reply-heart-empty.png"];
  //  UIImageView *cellImageView = [[UIImageView alloc] initWithImage:image];
   // UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *button = [AppUIManager getTransparentUIButton];
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
//    CGFloat hotizontalPadding = 100;
//    CGFloat desiredWidth = [UIScreen mainScreen].bounds.size.width - hotizontalPadding;
//    [label sizeToFit];
    [label setTranslatesAutoresizingMaskIntoConstraints:NO];
    // accessibilty
    [label setAccessibilityIdentifier:@"Comment Text"];
    return label;

}
@end
