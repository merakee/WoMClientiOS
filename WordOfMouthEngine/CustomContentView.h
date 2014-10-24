//
//  CustomContentView.h
//  WordOfMouthEngine
//
//  Created by Kevin Moy on 10/21/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomContentView : UIView {

UIView                  *contentView;
UITextView              *contentTextView;
UIImageView             *contentImageView;
}
- (void)setView;
@end

