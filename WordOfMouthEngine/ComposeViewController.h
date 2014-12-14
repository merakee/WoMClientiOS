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
    UILabel             *placeHolderLabel2;
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
    UITapGestureRecognizer *touchRecognized;
    
    //UIScrollView            *scrollView;
    
    UIView                  *inputAccView;
    UIButton                *backButton;
    UIButton                *doneButton;
    UIButton                *deleteImage;
    
    // Toolbar buttons
    UIToolbar           *composeToolBar;
    UIBarButtonItem     *textBarButton;
    UIBarButtonItem     *imageBarButton;
    UIBarButtonItem     *filterBarButton;
    UIButton            *textButton;
    UIButton            *imageButton;
    UIButton            *filterButton;

    // Keyboard Accessory Buttons
    UIToolbar           *keyboardToolBar;
    UIView              *accView;
    UIButton            *xButton;
    UIButton            *checkButton;
    UIButton            *backgroundButton;
    UIButton            *keyboardButton;
    UIBarButtonItem     *xBarButton;
    UIBarButtonItem     *checkBarButton;
    UIBarButtonItem     *backgroundBarButton;
    UIBarButtonItem     *keyboardBarButton;
    UIToolbar           *colorKeyboardToolBar;
    
    UICollectionView    *colorGrid;
    UICollectionViewFlowLayout *collectionLayout;
    
   // Image accessory Buttons
    UIToolbar           *imageToolBar;
    
    // Filter accessory Buttons
    UIToolbar           *filterToolBar;
    
    // Color text
    UIButton            *color1;
    UIButton            *color2;
    UIButton            *color3;
    UIButton            *color4;
    UIButton            *color5;
    UIButton            *color6;
    UIButton            *color7;
    UIButton            *color8;
    NSArray             *buttonItems;
    
    NSMutableParagraphStyle *paraStyle;
    
}


@end
