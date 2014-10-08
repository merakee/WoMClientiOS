//
//  CustomActivityIndicator.h
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 9/26/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, AUCCustomActivityIndicatorStyle) {
    kAUCCustomActivityIndicatorStyleWhite,
    kAUCCustomActivityIndicatorStyleGray
};

@interface CustomActivityIndicator : UIImageView{

}

@property(nonatomic) AUCCustomActivityIndicatorStyle activityIndicatorStyle; // default is UIActivityIndicatorViewStyleWhite
@property(nonatomic) BOOL                         hidesWhenStopped;           // default is YES. calls -setHidden when animating gets set to NO


- (void)startAnimatingCI;
//- (void)stopAnimating;
//- (BOOL)isAnimating;

@end

