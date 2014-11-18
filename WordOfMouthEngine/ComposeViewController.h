//
//  AddContentViewController.h
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 2/15/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageProcessingManager.h"
#import "ContentViewController.h"

@interface ComposeViewController : UIViewController<UITextViewDelegate,ImageProcessingManagerDelegate,UIActionSheetDelegate,UIAlertViewDelegate>{
    // UISegmentedControl *categoryControl;
    UITextView         *composeTextView;
    UIImageView        *contentImageView;
    UILabel            *placeHolderLabel;
    UILabel             *characterCount;
    ImageProcessingManager   *photoManager;
    //UIView                   *photoOptionsView;
    //UIButton                 *cameraButton;
    //UIButton                 *albumButton;
    
    UIButton                 *postButton;
    UIButton                 *cameraOptionsButton;
    UIButton                 *cancelButton;
    
    UIActivityIndicatorView *activityIndicator;
    UIPanGestureRecognizer *panRecognized;
 
    //UIScrollView            *scrollView;
    
    UIView                  *inputAccView;
    UIButton                *backButton;
    UIButton                *doneButton;
    
    // Toolbar buttons
    UIToolbar           *composeToolBar;
    UIBarButtonItem     *textBarButton;
    UIBarButtonItem     *imageBarButton;
    UIBarButtonItem     *filterBarButton;
    UIButton            *textButton;
    UIButton            *imageButton;
    UIButton            *filterButton;

    // Accessory Buttons
    UIToolbar           *keyboardToolBar;
    UIView              *accView;
    UIButton            *xButton;
    UIButton            *checkButton;
    UIButton            *backgroundButton;
    UIBarButtonItem     *xBarButton;
    UIBarButtonItem     *checkBarButton;
    UIBarButtonItem     *backgroundBarButton;
    
    // Image Buttons
    UIWebView           *webView;
    UITextField         *searchTextField;
}


@end
