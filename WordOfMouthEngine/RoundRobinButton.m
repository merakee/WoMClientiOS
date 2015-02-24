//
//  RoundRobinButton.m
//  WordOfMouthEngine
//
//  Created by Kevin Moy on 2/18/15.
//  Copyright (c) 2015 Bijit Halder. All rights reserved.
//

#import "RoundRobinButton.h"



@implementation RoundRobinButton

@synthesize  actionList;
@synthesize  delegate;

#pragma mark - Init Methods
- (id)init{
    if(self =[super init]) {
        // initialization code
        self.delegate = nil;
        buttonState = 0;
        actionList = nil;
    }
    [self  addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    return self;
}

#pragma mark -  Instance methods
- (void)resetButtonState{
    buttonState = 0;
}

#pragma mark - action method
- (void)buttonPressed:(id)sender{
    if(buttonState>= [self.actionList count]){
        [self resetButtonState];
    }
    if([self.actionList count]==0){
        return;
    }
    
    SEL actionSelector = NSSelectorFromString([self.actionList objectAtIndex:buttonState]);
    
    if ([self.delegate respondsToSelector:actionSelector]) {
        [self.delegate performSelector:actionSelector withObject:nil afterDelay:0];
    }
    buttonState++;
}
@end
