//
//  CommentViewController.h
//  WordOfMouthEngine
//
//  Created by Kevin Moy on 11/11/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>{
     UIButton                *sendButton;
     UIImageView            *accessoryImageView;
    UIImage                 *accessoryImage;
    UIButton                *accessoryButton;
}

@property (nonatomic, strong) UITableView *commentsTableView;
@property (nonatomic, strong) UISegmentedControl *segmentedControl;

extern NSArray const *testArray;

@end
