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
    
    ImageProcessingManager   *photoManager;
}
@end
