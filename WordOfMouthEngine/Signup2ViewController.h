//
//  Signup2ViewController.h
//  WordOfMouthEngine
//
//  Created by Kevin Moy on 2/10/15.
//  Copyright (c) 2015 Bijit Halder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WomSignInViewController.h"
#import "ImageProcessingManager.h"
#import "ApiManager.h"
static const NSInteger kAUCProfilePhotoOptionsActionSheetTag = 226;
@interface Signup2ViewController : UIViewController<UIScrollViewDelegate, ImageProcessingManagerDelegate,UIActionSheetDelegate,UIAlertViewDelegate>{

    UITextField        *nicknameField;
    UIButton            *cancelButton;
    UIButton            *doneButton;
    
    UIView              *lineView;
    UIImageView         *titleImage;
    UIScrollView        *imageScrollview;
    
    UIButton            *cameraButton;
    UIImageView         *profileImageView;
    
    UIActivityIndicatorView *activityIndicator;
    ImageProcessingManager   *photoManager;
    
    NSArray         *allSystemProfileImages;
}
@property (nonatomic)  UITextField        *emailField;
@property (nonatomic)  UITextField        *passwordField;
@end
