//
//  CustomActivityIndicator.m
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 9/26/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import "CustomActivityIndicator.h"

@implementation CustomActivityIndicator

@synthesize activityIndicatorStyle;
@synthesize hidesWhenStopped;

#pragma mark - init methods
- (id)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.hidesWhenStopped = YES;
    self.activityIndicatorStyle = kAUCCustomActivityIndicatorStyleGray;
    self.backgroundColor = [UIColor clearColor];
    self.animationDuration = 2.0f;
    self.animationRepeatCount = 0;
}

#pragma mark - Animation Methods
- (void)startAnimatingCI{
    if(self.activityIndicatorStyle  == kAUCCustomActivityIndicatorStyleGray){
        self.animationImages =[self getGrayWheelAnimationImages];
    }
    else{
        self.animationImages =[self getWhiteWheelAnimationImages];
    }
    [self startAnimating];
}
//- (void)stopAnimating{
//    [self stopAnimating];
//    self.hidden = self.hidesWhenStopped;
//}
//- (BOOL)isAnimating{
//    return [self isAnimating];
//}

- (NSArray *)getWhiteWheelAnimationImages{
    NSMutableArray *marray =[[NSMutableArray alloc] init];
    for(int ind=1;ind<=6;ind++){
        NSString *fileName =[@"s" stringByAppendingFormat:@"%dw.png",ind];
        [marray addObject:[UIImage imageNamed:fileName]];
    }
    return (NSArray *)marray;
}
- (NSArray *)getGrayWheelAnimationImages{
    NSMutableArray *marray =[[NSMutableArray alloc] init];
    for(int ind=1;ind<=6;ind++){
        NSString *fileName =[@"preloader_gray" stringByAppendingFormat:@"%d.png",ind];
        [marray addObject:[UIImage imageNamed:fileName]];
    }
    
    return (NSArray *)marray;
}

@end
