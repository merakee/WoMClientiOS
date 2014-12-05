//
//  CommentViewController.h
//  WordOfMouthEngine
//
//  Created by Kevin Moy on 11/11/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ApiManager.h"
#import "CommentViewHelper.h"

static const int kCVC_DEFAULT_NUMBER_OF_COMMENTS = 20;

static const int kCVCommentModePopular = 1;
static const int kCVCommentModeRecent = 0;
typedef enum {
    kAPICommentRefreshModeRefresh = 0,
    kAPICommentRefreshModeGetMore = 1,
} kAPICommentRefreshMode;

static const int kCellButtonTag = 10;

@interface CommentViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextViewDelegate>{
    UIButton                *sendButton;
    UITableView             *commentsTableView;
    UIToolbar               *replyToolBar;
    UIBarButtonItem         *barItem;
    UIBarButtonItem         *sButton;
    UITextView              *commentText;
    
    UIActivityIndicatorView *activityIndicator;
    
    
    //CustomLilkeButton       *likeButton;
    UILabel                 *cellText;
    NSMutableArray          *recentArray;
    NSMutableArray          *popularArray;
    NSMutableArray          *activeArray;
    BOOL                    isUpdateActive;
}
@property (nonatomic) ApiContent *currentContent;
@property (nonatomic, strong) UISegmentedControl *segmentedControl;
@property NSIndexPath *editingIndexPath;
extern NSArray const *testArray;

@end
