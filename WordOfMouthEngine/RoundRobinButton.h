//
//  RoundRobinButton.h
//  WordOfMouthEngine
//
//  Created by Kevin Moy on 2/18/15.
//  Copyright (c) 2015 Bijit Halder. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RoundRobinButton : UIButton{
    int buttonState;
}

@property (nonatomic) NSArray *actionList;
@property (nonatomic) id delegate;

#pragma mark -  Instance methods
- (void)resetButtonState;
@end
