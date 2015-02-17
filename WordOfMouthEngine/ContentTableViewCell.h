//
//  CommentTableViewCell.h
//  WordOfMouthEngine
//
//  Created by Kevin Moy on 11/18/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomLilkeButton.h"
#import "CustomContentView.h"
#import "UIImageView+AFNetworking.h"

@interface ContentTableViewCell : UITableViewCell{
}
@property (nonatomic, retain) CustomContentView *contentImage;
@end
