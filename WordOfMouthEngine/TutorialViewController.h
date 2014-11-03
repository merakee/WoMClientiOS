//
//  TutorialViewController.h
//  WordOfMouthEngine
//
//  Created by Kevin Moy on 10/30/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TutorialViewController : UIViewController {
   // NSInteger *index;
    UILabel     *screenNumber;
    UIImageView     *tutorialImageView;
}
@property (nonatomic, strong) NSString *imageName;

@property (nonatomic) NSUInteger index;
//@property (strong, nonatomic) IBOutlet UILabel *screenNumber;

@end
