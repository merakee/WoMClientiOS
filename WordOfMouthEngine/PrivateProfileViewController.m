//
//  PrivateProfileViewController.m
//  WordOfMouthEngine
//
//  Created by Kevin Moy on 2/25/15.
//  Copyright (c) 2015 Bijit Halder. All rights reserved.
//

#import "PrivateProfileViewController.h"
#import "ProfileViewHelper.h"
#import "PublicProfileViewHelper.h"
#import "SettingsViewController.h"
#import "FlurryManager.h"
@interface PrivateProfileViewController ()

@end

@implementation PrivateProfileViewController
@synthesize profilePic;
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
    [super loadView];
    [self setView];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // hide navigation bar
    [self.navigationController setNavigationBarHidden:YES];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)shouldAutorotate{
    return  YES;
}
#pragma mark -  Local Methods Implememtation
- (void)setView {
    // set view
    [PublicProfileViewHelper setView:self.view];
    [self setupScrollView];
    self.view.backgroundColor = [CommonUtility getColorFromHSBACVec:kAUCBorderColor];
    // Navigation Bar Items
    
    navigationView = [ProfileViewHelper getNavigationView];
    //  navigationView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:navigationView];
    cancelButton = [ProfileViewHelper getCancelButton];
    [cancelButton addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    [navigationView addSubview:cancelButton];
    settingsButton = [ProfileViewHelper getSettingsButton];
    [settingsButton addTarget:self action:@selector(goToSettingsView:) forControlEvents:UIControlEventTouchUpInside];
    [navigationView addSubview:settingsButton];
    profileTitle = [ProfileViewHelper getPrivateProfileTitle];
    [navigationView addSubview:profileTitle];
    
    // Profile Information
    profilePic = [ProfileViewHelper getProfilePic];
    [mainScrollView addSubview:profilePic];
    profilePic.backgroundColor = [UIColor redColor];
    profilePicBlur = [ProfileViewHelper getProfilePicBlur];
    [profilePic addSubview:profilePicBlur];
//    profilePicBlur.backgroundColor = [UIColor blueColor];
   // profilePic.image = currentContent.contentImageView.image;
//    currentContent.contentImageView.image = profilePic.image;
  //  profilePicBlur.image = self.profilePic.image;
    
    profileBackground = [ProfileViewHelper getProfileBackground];
    [mainScrollView addSubview:profileBackground];
    nicknameLabel = [ProfileViewHelper getProfileName];
    [profileBackground addSubview:nicknameLabel];
    likesIcon = [ProfileViewHelper getLikesIcon];
    [profileBackground addSubview:likesIcon];
    likesCount = [ProfileViewHelper getLikesCount];
    [profileBackground addSubview:likesCount];
    
    userInformation = [ProfileViewHelper getUserInformation];
    [mainScrollView addSubview:userInformation];
    userBio = [ProfileViewHelper getEditableBio];
    [userInformation addSubview:userBio];
    userLocation = [ProfileViewHelper getUserLocation];
    [userInformation addSubview:userLocation];
    
    // Divider
    divider = [[UIView alloc] init];
    divider.backgroundColor = [CommonUtility getColorFromHSBACVec:kAUCBorderColor];
    [divider setTranslatesAutoresizingMaskIntoConstraints:NO];
    [mainScrollView addSubview:divider];
    
    profileSocial = [ProfileViewHelper getProfileSocial];
    [mainScrollView addSubview:profileSocial];
    socialTitle = [ProfileViewHelper getSocialTitle];
    [profileSocial addSubview:socialTitle];
    instagramIcon = [ProfileViewHelper getInstagramIcon];
    [profileSocial addSubview:instagramIcon];
    tumblrIcon = [ProfileViewHelper getTumblrIcon];
    [profileSocial addSubview:tumblrIcon];
    snapchatIcon = [ProfileViewHelper getSnapchatIcon];
    [profileSocial addSubview:snapchatIcon];
    twitterIcon = [ProfileViewHelper getTwitterIcon];
    [profileSocial addSubview:twitterIcon];
    instagramName = [ProfileViewHelper getInstagramText];
    [profileSocial addSubview:instagramName];
    tumblrName = [ProfileViewHelper getTumblrText];
    [profileSocial addSubview:tumblrName];
    snapchatName = [ProfileViewHelper getSnapchatText];
    [profileSocial addSubview:snapchatName];
    twitterName = [ProfileViewHelper getTwitterText];
    [profileSocial addSubview:twitterName];
    
    instagramName.delegate = self;
    tumblrName.delegate = self;
    snapchatName.delegate = self;
    twitterName.delegate = self;
    instagramName.tag = 1;
    tumblrName.tag = 2;
    snapchatName.tag = 3;
    twitterName.tag = 4;
    // Favorites View
    favoritesView = [ProfileViewHelper getFavoriteView];
    [mainScrollView addSubview:favoritesView];
    [favoritesView sizeToFit];
    favoritesTitle = [ProfileViewHelper getFavoriteTitle];
    [favoritesView addSubview:favoritesTitle];
    
    // layout
    [self layoutView];
    
    //    CGRect contentRect = CGRectZero;
    //    for (UIView *view in mainScrollView.subviews) {
    //        contentRect = CGRectUnion(contentRect, view.frame);
    //    }
    //    mainScrollView.contentSize = contentRect.size;
    CGFloat scrollViewHeight = 0.0f;
    for (UIView* view in mainScrollView.subviews)
    {
        scrollViewHeight += view.frame.size.height;
    }
    
    [mainScrollView setContentSize:(CGSizeMake(320, scrollViewHeight))];
    
}
- (void)setupScrollView{
    mainScrollView = [[UIScrollView alloc] init];
    //    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [mainScrollView setTranslatesAutoresizingMaskIntoConstraints:NO];
    //scrollView.delegate = self;
    [self.view addSubview:mainScrollView];
    mainScrollView.backgroundColor = [UIColor greenColor];
    //   mainScrollView.bounces = NO;
    //   mainScrollView.backgroundColor = [CommonUtility getColorFromHSBACVec:kAUCBorderColor];
}
- (void)layoutView{
    // all view elements
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(mainScrollView, navigationView,cancelButton, settingsButton, profileTitle, profilePic, profilePicBlur, profileBackground, nicknameLabel, likesCount, likesIcon, userInformation, userBio, userLocation, divider, profileSocial, socialTitle, instagramIcon, tumblrIcon, snapchatIcon, twitterIcon, instagramName, tumblrName, snapchatName, twitterName, favoritesView, favoritesTitle);
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[navigationView(44)]-0-[mainScrollView]|"                                                                      options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[mainScrollView]|"                                                                      options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[navigationView]|"                                                                      options:0 metrics:nil views:viewsDictionary]];
    // navigation bar
    [navigationView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[cancelButton(22)]"                                                                      options:0 metrics:nil views:viewsDictionary]];
    [navigationView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[settingsButton(22)]-15-|"                                                                      options:0 metrics:nil views:viewsDictionary]];
    [navigationView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[cancelButton(22)]"                                                                      options:0 metrics:nil views:viewsDictionary]];
    [navigationView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[settingsButton(22)]"                                                                      options:0 metrics:nil views:viewsDictionary]];
    [navigationView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[profileTitle(22)]"                                                                      options:0 metrics:nil views:viewsDictionary]];
    [AppUIManager verticallyCenterElement:cancelButton inView:navigationView];
    [AppUIManager verticallyCenterElement:settingsButton inView:navigationView];
    [AppUIManager verticallyCenterElement:profileTitle inView:navigationView];
    [AppUIManager horizontallyCenterElement:profileTitle inView:navigationView];
    
    [mainScrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[profilePic(260)]-0-[profileBackground(42)]-0-[userInformation(65)]-0-[divider(2)]-0-[profileSocial(130)]-0-[favoritesView]"                                                                      options:0 metrics:nil views:viewsDictionary]];
    
    // Profile Information
    [AppUIManager horizontallyCenterElement:profilePic inView:mainScrollView];
    [mainScrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[profilePic]|"                                                                      options:0 metrics:nil views:viewsDictionary]];
    [profilePic addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[profilePicBlur(176)]"                                                                      options:0 metrics:nil views:viewsDictionary]];
    [profilePic addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[profilePicBlur(176)]"                                                                      options:0 metrics:nil views:viewsDictionary]];
    [AppUIManager horizontallyCenterElement:profilePicBlur inView:profilePic];
    [AppUIManager verticallyCenterElement:profilePicBlur inView:profilePic];
    
    [mainScrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[profileBackground]|"                                                                      options:0 metrics:nil views:viewsDictionary]];
    [profileBackground addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[nicknameLabel]"                                                                      options:0 metrics:nil views:viewsDictionary]];
    [profileBackground addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-3-[nicknameLabel]-3-[likesIcon]"                                                                      options:0 metrics:nil views:viewsDictionary]];
    [profileBackground addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-3-[nicknameLabel]-3-[likesCount]"                                                                      options:0 metrics:nil views:viewsDictionary]];
    [profileBackground addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[likesIcon]-[likesCount]"                                                                      options:0 metrics:nil views:viewsDictionary]];
    
    [mainScrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[userInformation]|"                                                                      options:0 metrics:nil views:viewsDictionary]];
    [userInformation addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[userBio]"                                                                      options:0 metrics:nil views:viewsDictionary]];
    [userInformation addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[userLocation]"                                                                      options:0 metrics:nil views:viewsDictionary]];
    [userInformation addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-12-[userBio]-6-[userLocation]"                                                                      options:0 metrics:nil views:viewsDictionary]];
    
    [mainScrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[divider]|"                                                                      options:0 metrics:nil views:viewsDictionary]];
    // Social Constraints
    [mainScrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[profileSocial]|"                                                                      options:0 metrics:nil views:viewsDictionary]];
    [profileSocial addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-3-[socialTitle(6)]"                                                                      options:0 metrics:nil views:viewsDictionary]];
    [profileSocial addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[socialTitle]"                                                                      options:0 metrics:nil views:viewsDictionary]];
    [AppUIManager verticallyCenterElement:socialTitle inView:profileSocial];
    [profileSocial addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[instagramIcon]-3-[instagramName]"                                                                      options:0 metrics:nil views:viewsDictionary]];
    [profileSocial addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[tumblrIcon]-3-[tumblrName]"                                                                      options:0 metrics:nil views:viewsDictionary]];
    [profileSocial addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[snapchatIcon]-3-[snapchatName]"                                                                      options:0 metrics:nil views:viewsDictionary]];
    [profileSocial addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[twitterIcon]-3-[twitterName]"                                                                      options:0 metrics:nil views:viewsDictionary]];
    [profileSocial addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-16-[twitterIcon]-6-[instagramIcon]-6-[snapchatIcon]-6-[tumblrIcon]"                                                                      options:0 metrics:nil views:viewsDictionary]];
    [profileSocial addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-16-[twitterName]-6-[instagramName]-6-[snapchatName]-6-[tumblrName]"                                                                      options:0 metrics:nil views:viewsDictionary]];
    
    // Favorite View
    [mainScrollView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[favoritesView]"                                                                      options:0 metrics:nil views:viewsDictionary]];
    //    [favoritesView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[favoritesTitle]|"                                                                      options:0 metrics:nil views:viewsDictionary]];
    [favoritesView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-30-[favoritesTitle]"                                                                      options:0 metrics:nil views:viewsDictionary]];
    [AppUIManager horizontallyCenterElement:favoritesTitle inView:favoritesView];
}
#pragma mark - Button Actions
- (void)goBack:(id)sender {
    // go back to previous view
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)goToSettingsView:(id)sender {
    // Analytics: Flurry
    [Flurry logEvent:[FlurryManager getEventName:kFAUserSessionSignIn]];
    
    SettingsViewController *svc = [[SettingsViewController alloc] init];
    svc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:svc animated:NO];
}
#pragma mark - Social Alert Methods
- (void)changeInstagram{
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"Update Instagram"
                                          message:nil
                                          preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField)
     {
         textField.placeholder = NSLocalizedString(@"@username", @"Update Instagram");
     }];
    UIAlertAction *addAction = [UIAlertAction
                                actionWithTitle:NSLocalizedString(@"Add", @"Add action")
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction *action)
                                   {
                                       instagramName = alertController.textFields.firstObject;
                                       [self updateTextFields];
                                       NSLog(@"ig name: %@", instagramName.text);
                                       // Need to send new data to backend!!
                                   }];
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel action")
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction *action)
                                   {
                                   }];
    [alertController addAction:cancelAction];
    [alertController addAction:addAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (void)changeTumblr{
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"Update Tumblr"
                                          message:nil
                                          preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField)
     {
         textField.placeholder = NSLocalizedString(@"@username", @"Update Tumblr");
     }];
    UIAlertAction *addAction = [UIAlertAction
                                actionWithTitle:NSLocalizedString(@"Add", @"Add action")
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction *action)
                                   {
                                       tumblrName = alertController.textFields.firstObject;
                                       NSLog(@"tumblr name: %@", tumblrName.text);
                                       [tumblrName setText:tumblrName.text];
                                       // Need to send new data to backend!!
                                   }];
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel action")
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction *action)
                                   {
                                   }];
    [alertController addAction:cancelAction];
    [alertController addAction:addAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (void)changeSnapchat{
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"Update Snapchat"
                                          message:nil
                                          preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField)
     {
         textField.placeholder = NSLocalizedString(@"@username", @"Update Snapchat");
     }];
    UIAlertAction *addAction = [UIAlertAction
                                actionWithTitle:NSLocalizedString(@"Add", @"Add action")
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction *action)
                                   {
                                       snapchatName = alertController.textFields.firstObject;
                                          NSLog(@"snapchat name: %@", snapchatName.text);
                                       NSString *snapchatString = snapchatName.text;
                                       [twitterName setText:snapchatString];
                                       // Need to send new data to backend!!
                                   }];
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel action")
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction *action)
                                   {
                                   }];
    [alertController addAction:cancelAction];
    [alertController addAction:addAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (void)changeTwitter{
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"Update Twitter"
                                          message:nil
                                          preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField)
     {
         textField.placeholder = NSLocalizedString(@"@username", @"Update Twitter");
     }];
    UIAlertAction *addAction = [UIAlertAction
                                   actionWithTitle:NSLocalizedString(@"Add", @"Add action")
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction *action)
                                   {
                                       twitterName = alertController.textFields.firstObject;
                                       
                                          NSLog(@"twitter name: %@", twitterName.text);
                                    //   [instagramName setText:twitterName.text];
                                       // Need to send new data to backend!!
                                   }];
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel action")
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction *action)
                                   {
                                   }];
    [alertController addAction:cancelAction];
    [alertController addAction:addAction];
     NSLog(@"where");
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - ScrollView methods
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y >= scrollView.contentSize.height - scrollView.frame.size.height) {
        [scrollView setContentOffset:CGPointMake(scrollView.contentOffset.x, scrollView.contentSize.height - scrollView.frame.size.height)];
    }
}
#pragma mark - Text Field methods
- (void)updateTextFields{
    NSLog(@"blah");
    [instagramName setText:instagramName.text];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSLog(@"update label");
//    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    NSLog(@"hi");
   
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField.tag == 1){
        [self changeInstagram];
    }
    if (textField.tag == 2){
        [self changeTumblr];
    }
    if (textField.tag == 3){
        [self changeSnapchat];
    }
    if (textField.tag == 4){
        [self changeTwitter];
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
//       NSLog(@"ending: %@", instagramName.text);
}
@end
