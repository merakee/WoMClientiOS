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
#import "CustomIOS7AlertView.h"
#import "ImageSearchViewController.h"
#import "RoundRobinButton.h"
#import <CoreImage/CoreImage.h>

@interface ComposeViewController : UIViewController<UITextViewDelegate,ImageProcessingManagerDelegate,UIActionSheetDelegate,UIAlertViewDelegate>{
    // UISegmentedControl *categoryControl;
    UITextView         *composeTextView;
    UIImageView        *contentImageView;
    UIImage             *finalContentImage;
    UILabel            *placeHolderLabel;
    UILabel             *characterCount;
    ImageProcessingManager   *photoManager;
    //UIView                   *photoOptionsView;
    //UIButton                 *cameraButton;
    //UIButton                 *albumButton;
    
    UIButton                 *postButton;
    UIButton                *doneButton;
    UIButton                 *cameraOptionsButton;
    UIButton                 *cancelButton;
    UIActivityIndicatorView *activityIndicator;
    UIPanGestureRecognizer *panRecognized;
    UITapGestureRecognizer *touchRecognized;
    
    //UIScrollView            *scrollView;
    
    UIView                  *inputAccView;
   
    UIButton                *deleteImage;
    
    // Toolbar buttons
    UIToolbar           *composeToolBar;
    UIBarButtonItem     *textBarButton;
    UIBarButtonItem     *imageBarButton;
    UIBarButtonItem     *filterBarButton;
    RoundRobinButton    *textButton;
    RoundRobinButton    *imageButton;
    RoundRobinButton    *filterButton;

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
    NSArray             *buttonItems;
    NSMutableParagraphStyle *paraStyle;
    CustomIOS7AlertView *successAlertView;
    UITextView *searchTextField;
    UIImageView         *imageSearchView;
    
    // Filters
    CIFilter            *imageFilter;
    CIContext           *context;
    CIImage             *outputImage;
    UIImage             *imageWithFilter;
    UIImageView         *defaultContentImage;
    
    // Border View
    UIView              *borderLine;
}


@end
