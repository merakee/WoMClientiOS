//
//  ImageProcessingManager.m
//  Math Smart Universal
//
//  Created by Bijit Halder on 2/29/12.
//  Copyright (c) 2012 Indriam Inc. All rights reserved.
//

#import "ImageProcessingManager.h"
#import <QuartzCore/QuartzCore.h>
#import <MobileCoreServices/MobileCoreServices.h>

@implementation ImageProcessingManager
@synthesize delegate;
@synthesize viewController;
@synthesize allowEditting;
//@synthesize controller;

#pragma mark - init
- (id)init{
    if(self = [super init]) {
        // initialization code
        [self setAllDefaults];
        
    }
    return self;
}

- (void)setAllDefaults{
    self.allowEditting = YES;
}


#pragma mark -  Camera Capture Methods
//- (BOOL)


#pragma mark -  Photo Library methods
- (BOOL)isPhotoLibraryAvailable {
    return [UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeSavedPhotosAlbum] ||
           [UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypePhotoLibrary];
}

- (void) displayPhotoLibrary {

    // check if the library is unavilable or controller is missing
    if ((![self isPhotoLibraryAvailable])|| (self.viewController == nil)) {
        [self photoCaptureCancelled];
        return;
    }

    // start imagepicker
    UIImagePickerController *photoController = [[UIImagePickerController alloc] init];
    // pick avilable library
    if([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypePhotoLibrary]) {
        photoController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    else if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypePhotoLibrary]) {
        photoController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    }
    else {
        [self photoCaptureCancelled];
        return;
    }

    // set media type to photo
    photoController.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeImage, nil];
    // Show the controls, use YES.
    photoController.allowsEditing = self.allowEditting;
    // set delegate
    photoController.delegate = self;

    // set controller
    //self.controller = vcontroller;
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        // iPad
        [self presentImagePickerForiPad:photoController];
    }
    else{
        // iPhone
        [self presentImagePickerForiPhone:photoController];
    }

}

#pragma mark -  Camera methods
- (BOOL)isCameraAvailable {
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

- (void) displayCamera {

    // check if the library is unavilable or controller is missing
    if ((![self isCameraAvailable])|| (self.viewController == nil)) {
        [self photoCaptureCancelled];
        return;
    }

    // start imagepicker
    UIImagePickerController *cameraController = [[UIImagePickerController alloc] init];
    // set source type to camer
    cameraController.sourceType = UIImagePickerControllerSourceTypeCamera;

    // set media type to photo
    cameraController.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeImage, nil];
    // Show the controls, use YES.
    cameraController.allowsEditing = self.allowEditting;
    // set delegate
    cameraController.delegate = self;

    // set controller
    //self.controller = vcontroller;
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        // iPad
        [self presentImagePickerForiPad:cameraController];
    }
    else{
        // iPhone
        [self presentImagePickerForiPhone:cameraController];
    }
}


#pragma mark -  Image picker Set up and dismissal
- (void)presentImagePickerForiPhone:(UIImagePickerController *)imagePickerController {
    [self.viewController presentViewController:imagePickerController animated:YES completion:nil];
}
- (void)presentImagePickerForiPad:(UIImagePickerController *)imagePickerController {
    popoverController = [[UIPopoverController alloc] initWithContentViewController:imagePickerController];
    // [popoverController presentPopoverFromRect:self.viewController.view.bounds
    [popoverController presentPopoverFromRect:CGRectMake(kPopoverControllerLayout[0],
                                                         kPopoverControllerLayout[1],
                                                         kPopoverControllerLayout[2],
                                                         kPopoverControllerLayout[3])
     inView:[self.viewController view]
     permittedArrowDirections:UIPopoverArrowDirectionLeft
     animated:YES];
}
- (void)dismissImagePickerForiPhone {
    [self.viewController dismissViewControllerAnimated: YES completion:nil];
}
- (void)dismissImagePickerForiPad {
    [popoverController dismissPopoverAnimated:YES];
}


#pragma mark -  Image picker Delegate methods
// Image picker delegate methods
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    //NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    UIImage *originalImage, *editedImage, *image;

    // Handle a still image picked from a photo album
    editedImage = (UIImage *) [info objectForKey: UIImagePickerControllerEditedImage];
    originalImage = (UIImage *) [info objectForKey:UIImagePickerControllerOriginalImage];

    // pick edited image or the original image
    if (editedImage) {
        image = editedImage;

    } else {
        image = originalImage;
    }
    // call delegate method
    [self photoCaptureDoneWithImage:image];

    // dismiss the picker
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        // iPad
        [self dismissImagePickerForiPad];
    }
    else{
        // iPhone
        [self dismissImagePickerForiPhone];
    }
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    // dismiss the picker
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        // iPad
        [self dismissImagePickerForiPad];
    }
    else{
        // iPhone
        [self dismissImagePickerForiPhone];
    }

    // call delegate method
    [self photoCaptureCancelled];
}



#pragma mark -  Delegate methods
- (void) photoCaptureCancelled {
    // call delegate method
    if ([self.delegate respondsToSelector:@selector(photoCaptureCancelled)]) {
        [self.delegate photoCaptureCancelled];
    }

}
- (void) photoCaptureDoneWithImage:(UIImage *)image {
    // call delegate method
    // Delegate method
    if ([self.delegate respondsToSelector:@selector(photoCaptureDoneWithImage:)]) {
        [self.delegate photoCaptureDoneWithImage:image];
    }
}


#pragma mark -  Class methods
// class methods
+(UIImage *)getImageFromView:(UIView *)view {
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO,0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}

+(UIImage *)cropImageToSqure:(UIImage *)image {
    CGSize size = [image size];
    CGSize sqsize;
    CGPoint spoint;
    float diff = (size.width-size.height);
    // create squre frame
    if(diff==0) {
        // do nothing
        return image;
    }
    else if(diff>0.0) {
        // lareger width
        sqsize = CGSizeMake(size.height,size.height);
        spoint = CGPointMake(-diff/2.0, 0.0);
    }
    else{
        sqsize= CGSizeMake(size.width,size.width);
        spoint = CGPointMake(0.0,diff/2.0);
    }
    // crop image
    UIGraphicsBeginImageContextWithOptions(sqsize,YES,0.0);
    [image drawAtPoint:spoint];
    UIImage *imagesq = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return imagesq;
}

#pragma mark - change image color
+ (UIImage *)changeColorOfImage:(UIImage *)image withColor:(UIColor *)color withFlipCorrection:(BOOL)flipCorrection {
    // begin a new image context, to draw our colored image onto
    UIGraphicsBeginImageContext(image.size);

    // get a reference to that context we created
    CGContextRef context = UIGraphicsGetCurrentContext();

    // set the fill color
    [color setFill];

    // translate/flip the graphics context (for transforming from CG* coords to UI* coords
    if(flipCorrection) {
        CGContextTranslateCTM(context, 0, image.size.height);
        CGContextScaleCTM(context, 1.0, -1.0);
    }

    // set the blend mode to color burn, and the original image
    CGContextSetBlendMode(context, kCGBlendModeColorBurn);
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    CGContextDrawImage(context, rect, image.CGImage);

    // set a mask that matches the shape of the image, then draw (color burn) a colored rectangle
    CGContextClipToMask(context, rect, image.CGImage);
    CGContextAddRect(context, rect);
    CGContextDrawPath(context,kCGPathFill);

    // generate a new UIImage from the graphics context we drew onto
    UIImage *coloredImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    //return the color-burned image
    return coloredImg;
}
@end
