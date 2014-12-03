//
//  TutorialViewController.m
//  WordOfMouthEngine
//
//  Created by Kevin Moy on 10/30/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import "TutorialViewController.h"
#import "CommonUtility.h"
@interface TutorialViewController ()

@end
@implementation TutorialViewController
//@synthesize screenNumber;
@synthesize index;
@synthesize imageName;
//@synthesize tutorialImageView;
- (void)viewDidLoad {
    [super viewDidLoad];
//    float screenW = [CommonUtility getScreenWidth];
//     float screenH = [CommonUtility getScreenHeight];
    
//    screenNumber = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, screenW, 200)];
//    tutorialImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, screenW, 400)];
    UIImage *image = [UIImage imageNamed:imageName];
    tutorialImageView = [[UIImageView alloc] initWithImage:image];
    [tutorialImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    //       screenNumber.text = [NSString stringWithFormat:@"Screen %d", self.index];
    
   // tutorialImageView.image = [UIImage imageNamed:imageName];
  //  [tutorialImageView setContentMode:UIViewContentModeScaleAspectFill];
    tutorialImageView.contentMode = UIViewContentModeScaleAspectFit;
   // [tutorialImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
//    self.view.clipsToBounds = YES;
    tutorialImageView.clipsToBounds = YES;
    [self.view addSubview:tutorialImageView];
 //   [self.view addSubview:screenNumber];
    
//    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(tutorialImageView);
//    
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[tutorialImageView]-10-|"                                                                      options:0 metrics:nil views:viewsDictionary]];
//
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[tutorialImageView]-10-|"                                                                      options:0 metrics:nil views:viewsDictionary]];

}


- (void) setImageName: (NSString *) name
{
    imageName = name;
    tutorialImageView.image = [UIImage imageNamed: imageName];
  //  [self.view addSubview:tutorialImageView];
 //   [tutorialImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
