//
//  ContentViewController.h
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 2/15/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContentManager.h"

@interface ContentViewController : UIViewController<UITextViewDelegate>{
    UITextView         *contentTextView;
    UILabel            *contentSpreadCount;
    UILabel             *authorID;
    UIButton           *spreadButton;
    UIButton           *killButton;
    
    ContentInfo        *contentInfo;
}

@end
