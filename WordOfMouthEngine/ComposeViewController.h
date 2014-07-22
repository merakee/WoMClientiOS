//
//  AddContentViewController.h
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 2/15/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageProcessingManager.h"

@interface ComposeViewController : UIViewController<UITextViewDelegate,ImageProcessingManagerDelegate>{
    // UISegmentedControl *categoryControl;
    UITextView         *composeTextView;
    
    ImageProcessingManager   *photoManager;
    UIView                   *photoOptionsView;
    UIButton                 *cameraButton;
    UIButton                 *albumButton;
    
    UIActivityIndicatorView *activityIndicator;
}

@end
