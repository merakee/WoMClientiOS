//
//  ContentViewController.h
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 2/15/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContentManager.h"

@interface ContentViewController : UIViewController{
    UITextView         *contentTextView;
    UIView             *textBackGround;
    UILabel            *contentSpreadCount;
    UILabel             *authorID;
    UIButton           *spreadButton;
    UIButton           *killButton;
    
    UIImageView         *userImage;
    UILabel             *spreadCount;
    UILabel             *timeCount;
    
    
    ContentInfo        *contentInfo;
}

@end
