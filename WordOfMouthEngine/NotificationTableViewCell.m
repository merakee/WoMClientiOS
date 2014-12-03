//
//  NotificationTableViewCell.m
//  WordOfMouthEngine
//
//  Created by Kevin Moy on 11/25/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import "NotificationTableViewCell.h"
#import "NotificationViewHelper.h"

@implementation NotificationTableViewCell
@synthesize notificationLabel;
@synthesize notificationImageView;

- (id)init {
    if (self = [super init]) {
        [self setView];
    }
    return self;
}
- (void)setView{

    
    self.notificationImageView = [NotificationViewHelper getNotificationImage];
    [self addSubview:notificationImageView];
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(notificationImageView);
    
    // notification image
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[notificationImageView(18)]-5-|"                                                                      options:0 metrics:nil views:viewsDictionary]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[notificationImageView(18)]-5-|"                                                                      options:0 metrics:nil views:viewsDictionary]];

}

@end
