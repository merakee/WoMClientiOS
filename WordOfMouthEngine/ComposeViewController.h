//
//  AddContentViewController.h
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 2/15/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ComposeViewController : UIViewController<UITextViewDelegate>{
    UISegmentedControl *categoryControl;
    UITextView         *composeTextView;
    
    UIActivityIndicatorView *activityIndicator;
}

@end
