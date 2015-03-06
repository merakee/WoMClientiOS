//
//  PublicProfileViewHelper.m
//  WordOfMouthEngine
//
//  Created by Kevin Moy on 3/3/15.
//  Copyright (c) 2015 Bijit Halder. All rights reserved.
//

#import "PublicProfileViewHelper.h"

@implementation PublicProfileViewHelper
#pragma mark -  View Helper Methods: Views
+ (void)setView:(UIView *)view{
    // set app defaults
    [AppUIManager setUIView:view ofType:kAUCPriorityTypePrimary];
    view.backgroundColor = [UIColor whiteColor];
    // view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:[CommonUtility adjustImageFileName:kAUCSignUpInBackgroundImage]]];
}

#pragma mark - Navigation Bar
+ (UIButton *)getCancelButton{
    UIButton *button =  [AppUIManager getTransparentUIButton];
    [button setImage:[UIImage imageNamed:kAUCCancelButtonImage] forState:UIControlStateNormal];
    [button setAccessibilityIdentifier:@"Cancel"];
    return button;
}
+ (UIButton *)getSettingsButton{
    UIButton *button =  [AppUIManager getTransparentUIButton];
    [button setImage:[UIImage imageNamed:kAUPSettingsButtonImage] forState:UIControlStateNormal];
    [button setAccessibilityIdentifier:@"Settings"];
    return button;
}
+ (UILabel *)getProfileTitle{
    UILabel *titleLabel =[[UILabel alloc] init];
    titleLabel.text=@"Profile";
    titleLabel.font = [UIFont boldSystemFontOfSize:kAUAppleTitleDefault];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    // accessibilty
    [titleLabel setAccessibilityIdentifier:@"Title label"];
    return titleLabel;
}
@end
