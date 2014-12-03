//
//  CommentTableViewCell.h
//  WordOfMouthEngine
//
//  Created by Kevin Moy on 11/18/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentTableViewCell : UITableViewCell

@property (nonatomic, retain) UILabel *commentCellLabel;
@property (nonatomic, retain) UIButton *likeButton;
@property (nonatomic, retain) UILabel *likeCount;
@end