//
//  CustomContentView.h
//  WordOfMouthEngine
//
//  Created by Kevin Moy on 10/21/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContentManager.h"


@protocol CustomContentViewDelegate <NSObject>
@required
- (void)contentViewUserButton:(id)sender;
@end

@interface CustomContentView : UIView {

UIView                  *contentView;
UITextView              *contentTextView;
UILabel                 *spreadsCount;

}
@property (atomic) UIImageView             *contentImageView;
@property (atomic) UILabel                  *spreadsCount;
@property (atomic) UIView                   *contentData;
@property (atomic) UIButton                 *nicknameButton;
@property (atomic) UIButton                 *profilePic;
@property (atomic) UIImageView              *spreadIcon;

@property (assign) id<CustomContentViewDelegate> delegate;


- (void)setView;
- (void)setAttributedText:(NSAttributedString *)text;

@end

