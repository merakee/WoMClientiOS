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

//@interface ContentViewController : UIViewController <CVCircleCounterViewDelegate>{
@interface ContentViewController : UIViewController{
    UITextView         *contentTextView;
    UIImageView        *contentBackGround;
    //UILabel            *contentSpreadCount;
    //UILabel             *authorID;
    UIButton           *spreadButton;
    UIButton           *killButton;
    UIButton           *composeButton;
    UIButton           *signInOutButton;
    
    UIImageView         *pageLogo;
    
    //UIImageView         *userImage;
    //UILabel             *spreadCount;
    
    UIActivityIndicatorView *activityIndicator;
    
    // circular timer
    // CVCircularProgressView      *progressClock;
    //CVCircleCounterView         *progressCounter;
    //NSTimer                     *progressTimer;
    //float                       timeRemaining;
    
    
    ContentManager     *contentManager;
    ApiContent        *currentContent;
    
    // gestures
    UISwipeGestureRecognizer *oneFingerSwipeLeft;
    UISwipeGestureRecognizer *oneFingerSwipeRight;
    
}

@end
