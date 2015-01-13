//
//  CommentTableViewCell.h
//  WordOfMouthEngine
//
//  Created by Kevin Moy on 11/18/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomLilkeButton.h"

@interface CommentTableViewCell : UITableViewCell

@property (nonatomic, retain) UILabel *commentCellLabel;
@property (nonatomic, retain) CustomLilkeButton *likeButton;
@property (nonatomic, retain) UILabel *likeCount;
@property (nonatomic, retain) UIButton *touchLike;
@end
