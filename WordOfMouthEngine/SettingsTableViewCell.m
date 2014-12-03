//
//  SettingsTableViewCell.m
//  WordOfMouthEngine
//
//  Created by Kevin Moy on 11/21/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import "SettingsTableViewCell.h"

@implementation SettingsTableViewCell
@synthesize accessoryImage;
- (id)init {
    if (self = [super init]) {
        [self setView];
    }
    return self;
}

-(void)setView{
    accessoryImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mapicon.jpeg"]];
    accessoryImage.contentMode = UIViewContentModeScaleAspectFill;
    [accessoryImage setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:self.accessoryImage];
    
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(accessoryImage);
    
    // like Button
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-15-[accessoryImage(15)]"                                                                      options:0 metrics:nil views:viewsDictionary]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[accessoryImage(15)]-5-|"                                                                      options:0 metrics:nil views:viewsDictionary]];
}

@end
