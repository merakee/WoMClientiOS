//
//  NotificationViewHelper.m
//  WordOfMouthEngine
//
//  Created by Kevin Moy on 11/25/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import "NotificationViewHelper.h"

@implementation NotificationViewHelper

+ (UILabel *)getNotificationLabel{
    UIImage *labelImage = [UIImage imageNamed:@"reply-send-btn.png"];
    UIImageView *notificationImage = [[UIImageView alloc] init];
    [notificationImage setImage:labelImage];
    UILabel *label =[[UILabel alloc] init];
    label.backgroundColor = [UIColor colorWithPatternImage:labelImage];
    
    [label setTranslatesAutoresizingMaskIntoConstraints:NO];
    [label setAccessibilityIdentifier:@"NotificationLabel"];
    return label;
}
+ (UIImageView *)getNotificationImage {
    UIImage *labelImage = [UIImage imageNamed:@"reply-send-btn.png"];
    UIImageView *notificationImage = [[UIImageView alloc] init];
    [notificationImage setImage:labelImage];
    
    [notificationImage setTranslatesAutoresizingMaskIntoConstraints:NO];
    [notificationImage setAccessibilityIdentifier:@"NotificationImage"];
    return notificationImage;
}
@end
