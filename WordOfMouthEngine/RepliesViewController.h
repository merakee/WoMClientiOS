//
//  RepliesViewController.h
//  WordOfMouthEngine
//
//  Created by Kevin Moy on 11/10/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContentViewController.h"

@interface RepliesViewController : UIViewController<UITextViewDelegate,UIAlertViewDelegate,UIActionSheetDelegate> {
    
    UITextView          *repliesTextView;
    UIScrollView        *scrollView;
    UIActivityIndicatorView *activityIndicator;
    
    UIButton            *backButton;
    UIButton            *sendButton;
    
    UILabel             *placeHolderLabel;
}

@end
