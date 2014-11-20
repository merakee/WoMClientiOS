//
//  CommentViewController.h
//  WordOfMouthEngine
//
//  Created by Kevin Moy on 11/11/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import <UIKit/UIKit.h>
static const int kCellButtonTag = 10;

@interface CommentViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextViewDelegate>{
    UIButton                *sendButton;
    UITableView             *commentsTableView;
    UIToolbar               *replyToolBar;
    UIBarButtonItem         *barItem;
    UIBarButtonItem         *sButton;
    UITextView              *commentText;
    
    UIButton                *likeButton;
    UILabel                 *cellText;
    NSArray                 *recentArray;
    NSArray                 *popularArray;
    NSArray                 *activeArray;
}
@property (nonatomic, strong) UISegmentedControl *segmentedControl;
@property NSIndexPath *editingIndexPath;
extern NSArray const *testArray;

@end
