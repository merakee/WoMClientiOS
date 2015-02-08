//
//  ContentOverlayView.h
//  WordOfMouthEngine
//
//  Created by Kevin Moy on 1/14/15.
//  Copyright (c) 2015 Bijit Halder. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger , OverlayViewMode) {
    OverlayViewModeLeft,
    OverlayViewModeRight
};
static NSString *kAUCReleaseToSpread =@"release-to-spread";
static NSString *kAUCReleaseToKill =@"release-to-Kill";

@interface ContentOverlayView : UIView
@property (nonatomic) OverlayViewMode mode;
@end
