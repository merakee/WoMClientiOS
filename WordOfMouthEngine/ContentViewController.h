
//
//  ContentViewController.h
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 2/15/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContentManager.h"
#import "ContentViewHelper.h"
#import "UIImageView+AFNetworking.h"
#import "CustomActivityIndicator.h"
#import "CustomContentView.h"
#import "ContentOverlayView.h"

//@interface ContentViewController : UIViewController <CVCircleCounterViewDelegate>{
@interface ContentViewController : UIViewController <UIAlertViewDelegate, UIPopoverControllerDelegate>{
    
    //UILabel            *contentSpreadCount;
    //UILabel             *authorID;
    UIButton           *spreadButton;
    UIButton           *killButton;
    UIButton           *pageLogo;
    UIButton            *mapButton;
    UIButton            *buttonTest;
    UIButton            *repliesButton;
    
    // navigation buttons
    UIButton           *composeButton;
    UIButton            *profileButton;
    
    // animation
    //UIActivityIndicatorView *activityIndicator;
    CustomActivityIndicator *activityIndicator;
    UIView                  *animationView;
    UIImageView             *spreadAnimationView;
    UIImageView             *killAnimationView;
    
    UIView                  *contentView;
    UITextView              *contentTextView;
    UIImageView             *contentBackGround;
    
    BOOL               isAnimationActive;
    BOOL                isRefreshingContent;
    BOOL                isEmptyContent;
    
    CustomContentView  *customContentView1;
    CustomContentView  *customContentView2;
    CustomContentView   *ccv;
    CustomContentView   *scv;
    
    UIImageView         *blurredImage;
    
    //UIImageView         *pageLogo;
    
    //UIImageView         *userImage;
    //UILabel             *spreadCount;
    
    //UIToolbar            *infoToolBar;
    
    UIButton                *viewsImage;
    UIButton                *commentImage;
    UIButton                *reportButton;
    UIButton                *notificationButton;
    
    UILabel                *commentCount;
    
    UIButton        *shareButton;
    UIImage         *bgImage;
    // circular timer
    // CVCircularProgressView      *progressClock;
    //CVCircleCounterView         *progressCounter;
    //NSTimer                     *progressTimer;
    //float                       timeRemaining;
    ContentManager     *contentManager;
    ApiContent        *currentContent;
    
    // gestures
    //    UISwipeGestureRecognizer *oneFingerSwipeLeft;
    //    UISwipeGestureRecognizer *oneFingerSwipeRight;
    UIPanGestureRecognizer *panRecognized;
    UIPanGestureRecognizer *panRecognized2;
    UITapGestureRecognizer *touchRecognized;
    UITapGestureRecognizer *touchRecognized2;
    
    //    CGFloat                 *xCoord;
    
    // dummy content index
    int pic_index;
    
}
@property (nonatomic) CGFloat originX;
@property (nonatomic) CGFloat originY;
@property (nonatomic) CGFloat startingTap;
@property (nonatomic) CGFloat endingTap;
@property (nonatomic) CGFloat startingTap2;
@property (nonatomic) CGFloat endingTap2;

@property (nonatomic) CGFloat startVerticalTap;
@property (nonatomic) CGFloat endVerticalTap;

@property CGPoint startPoint;
@property CGPoint endPoint;
@property (nonatomic) CGFloat xCoord;

@property(nonatomic, strong) ContentOverlayView *overlayView;
#pragma mark - Utility methods
- (void)clearContents;
- (void)refreshContentOnlyForTopView:(bool)onlyTop;

@end
