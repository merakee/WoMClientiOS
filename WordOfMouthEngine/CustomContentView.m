//
//  CustomContentView.m
//  WordOfMouthEngine
//
//  Created by Kevin Moy on 10/21/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import "CustomContentView.h"
#import "ContentViewHelper.h"
#import "CommonUtility.h"
#import "CommentViewController.h"
#import "PublicProfileViewController.h"

@implementation CustomContentView

@synthesize contentImageView;
@synthesize spreadsCount;
@synthesize contentData;
@synthesize nicknameButton;
@synthesize profilePic;
@synthesize spreadIcon;
@synthesize delegate;

- (void)loadView {
    //[super loadView];
    // view customization code
  //  currentContent =[[ApiContent  alloc] init];
    //[self setViewWithDelegate:nil];
}

- (void)setView{
    // set customContentView
    contentView = [[UIView alloc] init];
    [contentView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    [contentTextView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [contentImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
   
    contentImageView = [ContentViewHelper getContentBackGroundView];
    contentTextView = [ContentViewHelper getContentTextViewWithDelegate:self];
    [self addSubview:contentView];
    contentImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.clipsToBounds = YES;
    [contentView addSubview:contentImageView];
    
    contentData = [[UIView alloc] init];
    [contentData setTranslatesAutoresizingMaskIntoConstraints:NO];
   // contentData.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
    contentData.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
    [contentView addSubview:contentData];
    
    nicknameButton = [ContentViewHelper getNicknameButton];
    [nicknameButton addTarget:self action:@selector(contentViewUserButton:) forControlEvents:UIControlEventTouchUpInside];
    profilePic = [ContentViewHelper getProfilePic];
    [profilePic addTarget:self action:@selector(contentViewUserButton:) forControlEvents:UIControlEventTouchUpInside];
    
    spreadsCount = [ContentViewHelper getSpreadsCount];
    [contentData addSubview:spreadsCount];
    
    spreadIcon = [ContentViewHelper getSpreadIcon];
    [contentData addSubview:spreadIcon];
    
    [contentData addSubview:nicknameButton];
    [contentData addSubview:profilePic];
    
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 3);
    self.layer.shadowOpacity = 0.1;
    self.layer.shadowRadius = 2.0;
 //   self.clipsToBounds = NO;

    [self layoutView];
}

- (void)layoutView{
    // Constraints
    
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(contentView, contentImageView, spreadsCount, contentData, nicknameButton, profilePic, spreadIcon);
       //image view
    [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[contentImageView]|"
                                                                          options:0 metrics:nil views:viewsDictionary]];
    
    [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[contentImageView]|"
                                                                          options:0 metrics:nil views:viewsDictionary]];
    [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[contentData]|" options:0 metrics:nil views:viewsDictionary]];
     [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[contentData(50)]|" options:0 metrics:nil views:viewsDictionary]];
    
    // Spread Count
    [contentData addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[profilePic(35)]-4-[nicknameButton(146)]-8-[spreadIcon(13)]-3-[spreadsCount(110)]" options:0 metrics:nil views:viewsDictionary]];
    [AppUIManager verticallyCenterElement:spreadsCount inView:contentData];
    [AppUIManager verticallyCenterElement:nicknameButton inView:contentData];
    [AppUIManager verticallyCenterElement:profilePic inView:contentData];
    
//    [contentData addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[spreadIcon(15)]|"
//                                                                 options:0 metrics:nil views:viewsDictionary]];
    [AppUIManager verticallyCenterElement:spreadIcon inView:contentData];
    
        // text view placement
//        [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-16-[contentTextView]-16-|"
//                                                                            options:0 metrics:nil views:viewsDictionary]];
//    
//        [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-16-[contentTextView]-16-|"
//                                                                            options:0 metrics:nil views:viewsDictionary]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[contentView]|"
                                                                        options:0 metrics:nil views:viewsDictionary]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[contentView]|"
                                                                        options:0 metrics:nil views:viewsDictionary]];
}

-(void)goToNicknameView:(id)sender{
    PublicProfileViewController *pvc = [[PublicProfileViewController alloc] init];
    pvc.hidesBottomBarWhenPushed=YES;
  //  [self.navigationController pushViewController:pvc animated:NO];
}
- (void)setImage:(UIImage *)image{
    contentImageView.image = image;
}

- (void)setAttributedText:(NSAttributedString *)text{
    contentTextView.attributedText = text;
}

#pragma mark - Delegate methods
- (void)contentViewUserButton:(id)sender{
       if([self.delegate respondsToSelector:@selector(contentViewUserButton:)]){
        [self.delegate contentViewUserButton:sender];
    }
}
@end
