
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

//@interface ContentViewController : UIViewController <CVCircleCounterViewDelegate>{
@interface ContentViewController : UIViewController <UIAlertViewDelegate>{
    
    //UILabel            *contentSpreadCount;
    //UILabel             *authorID;
    UIButton           *spreadButton;
    UIButton           *killButton;
//    UIButton           *composeButton;
    UIButton           *pageLogo;
    
    UIButton            *mapButton;
    UIButton            *buttonTest;
    
    UIButton            *repliesButton;
    
    // animation
    //UIActivityIndicatorView *activityIndicator;
    CustomActivityIndicator *activityIndicator;
    UIView                  *animationView;
    UIImageView             *spreadAnimationView;
    UIImageView             *killAnimationView;
    
    UIView                  *contentView;
    UITextView              *contentTextView;
    UIImageView             *contentBackGround;
    
    UIView                  *nextContentView;
    UITextView              *nextContentTextView;
    UIImageView             *nextContentBackGround;
    
    BOOL               isAnimationActive;
    
    CustomContentView  *customContentView1;
    CustomContentView  *customContentView2;
    
    //UIImageView         *pageLogo;
    
    //UIImageView         *userImage;
    //UILabel             *spreadCount;
    
    UIToolbar            *infoToolBar;
    
    UIButton                *viewsImage;
    UIButton                *commentImage;
    UIButton                *reportButton;
    UILabel                *viewsCount;
    UILabel                *commentCount;
    
    UIBarButtonItem *rButton;
    UIBarButtonItem *vImage;
    UIBarButtonItem *cImage;
    UIBarButtonItem *vCount;
    UIBarButtonItem *cCount;
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
//    UITapGestureRecognizer *touchRecognized;

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


@property CGPoint startPoint;
@property CGPoint endPoint;
@property (nonatomic) CGFloat xCoord;

#pragma mark - Utility methods
- (void)clearContents;
- (void)refreshContent;

@end
