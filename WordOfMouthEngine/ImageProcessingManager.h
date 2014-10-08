//
//  ImageProcessingManager.h
//  Math Smart Universal
//
//  Created by Bijit Halder on 2/29/12.
//  Copyright (c) 2012 Indriam Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

static const float kPopoverControllerLayout[4]={425,339,1,1};

@protocol ImageProcessingManagerDelegate <NSObject>
@required
- (void) photoCaptureCancelled;
- (void) photoCaptureDoneWithImage:(UIImage *)image;
@optional
@end


@interface ImageProcessingManager : NSObject<UIImagePickerControllerDelegate,
UINavigationControllerDelegate>{
    UIPopoverController *popoverController;
    
}

@property (assign, nonatomic) id <ImageProcessingManagerDelegate>  delegate;
@property (strong, nonatomic) UIViewController *viewController;
@property (assign) BOOL allowEditting; 

// class methods
+(UIImage *)getImageFromView:(UIView *)view;
+(UIImage *)cropImageToSqure:(UIImage *)image;


#pragma mark -  Photo Library methods
- (BOOL)isPhotoLibraryAvailable;
- (void)displayPhotoLibrary;


#pragma mark -  Camera methods
- (BOOL)isCameraAvailable;
- (void)displayCamera;


#pragma mark -  Delegate Methods
- (void) photoCaptureCancelled;
- (void) photoCaptureDoneWithImage:(UIImage *)image;

#pragma mark - image drawing methods
+ (UIImage *)changeColorOfImage:(UIImage *)name withColor:(UIColor *)color withFlipCorrection:(BOOL)flipCorrection;
@end
