//
//  AppUIManager.h
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 2/13/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^Block)(BOOL success);
@interface UIImageView (AnimationCompletion)
-(void)startAnimatingWithCompletionBlock:(Block)block;
@end
