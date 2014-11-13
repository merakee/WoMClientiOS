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
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //        self.getLoginOutLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 100, 300, 30)];
        //     //   self.getLoginOutLabel.text = @"Sign in";
        //        self.getLoginOutLabel.textColor = [UIColor blackColor];
        //        self.getLoginOutLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
        //
        //        [self addSubview:self.getLoginOutLabel];
        //
        //        self.getHistoryLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 10, 300, 30)];
        //     //   self.getLoginOutLabel.text = @"History";
        //        self.getHistoryLabel.textColor = [UIColor blackColor];
        //        self.getHistoryLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
        //
        //        [self addSubview:self.getHistoryLabel];
        self.getDescriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 100, 300, 30)];
        //   self.getLoginOutLabel.text = @"Sign in";
        self.getDescriptionLabel.textColor = [UIColor blackColor];
        self.getDescriptionLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
        
        [self addSubview:self.getDescriptionLabel];
        
        
    }
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
+ (UIImage *)getAccessoryImage{
    UIImage *accessoryImage = [UIImage imageNamed:@"reply-heart-empty.png"];
    return accessoryImage;
                               
//    UIImage *accessoryImage = [[UIImage alloc] initWithImage:[UIImage imageNamed:@"reply-heart-empty.png"]];
//    [accessoryImage setFrame:CGRectMake(0, 0, 18.0, 18.0)];
//    accessoryImage.contentMode = UIViewContentModeScaleAspectFit;
//    accessoryImage.userInteractionEnabled = YES;
//    return accessoryImage;
}
@end
