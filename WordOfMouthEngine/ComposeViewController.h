//
//  AddContentViewController.h
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 2/15/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageProcessingManager.h"

@interface ComposeViewController : UIViewController<UITextViewDelegate,ImageProcessingManagerDelegate,UIActionSheetDelegate,UIAlertViewDelegate>{
    // UISegmentedControl *categoryControl;
    UITextView         *composeTextView;
    UIImageView        *contentImageView;
    UILabel            *placeHolderLabel;
    
    ImageProcessingManager   *photoManager;
    //UIView                   *photoOptionsView;
    //UIButton                 *cameraButton;
    //UIButton                 *albumButton;
    
    UIButton                 *postButton;
    UIButton                 *cameraOptionsButton;
    UIButton                 *cancelButton;
    
    UIActivityIndicatorView *activityIndicator;
}

@end
