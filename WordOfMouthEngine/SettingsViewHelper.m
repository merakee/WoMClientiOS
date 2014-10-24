//
//  SettingsViewHelper.m
//  WordOfMouthEngine
//
//  Created by Kevin Moy on 10/24/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import "SettingsViewHelper.h"
#import "ContentManager.h"

@implementation SettingsViewHelper

//@synthesize getHistoryLabel = _getHistoryLabel;
//@synthesize getLoginOutLabel = _getLoginOutLabel;
@synthesize getDescriptionLabel = _getDescriptioinLabel;

#pragma mark -  View Helper Methods: Views
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


//#pragma mark - LoginOut Button
//+ (UIButton *)getLoginOutButton{
//    UIButton *button =  [AppUIManager getTransparentUIButton];
//    [button setImage:[UIImage imageNamed:kAUCCancelButtonImage] forState:UIControlStateNormal];
//    [button setAccessibilityIdentifier:@"LoginOut"];
//    return button;
//}
//
//#pragma mark - History Button
//+ (UIButton *)getHistoryButton{
//    UIButton *button = [AppUIManager getTransparentUIButton];
//    [button setImage:[UIImage imageNamed:kAUCCancelButtonImage] forState:UIControlStateNormal];
//    [button setAccessibilityIdentifier:@"History"];
//    return button;
//}

@end
