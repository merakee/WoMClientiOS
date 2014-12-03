//
//  NotificationViewController.m
//  WordOfMouthEngine
//
//  Created by Kevin Moy on 11/25/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import "NotificationViewController.h"
#import "AppUIManager.h"
#import "ApiManager.h"
#import "FlurryManager.h"
#import "NotificationTableViewCell.h"

@interface NotificationViewController ()

@end

@implementation NotificationViewController

- (id)init {
    if (self = [super init]) {
    }
    return self;
}

- (void)loadView {
    [super loadView];
    [self setView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotate{
    return  YES;
}
- (NSUInteger)supportedInterfaceOrientations{
    return [AppUIManager getSupportedOrentation];
}

- (void)setView{
    // set app defaults
    [AppUIManager setUIView:self.view ofType:kAUCPriorityTypePrimary];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupTableView];
    [self.view addSubview:notificationTableView];
    [self layoutView];
}

- (void)layoutView{
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(notificationTableView);
   
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[notificationTableView]|"                                                                      options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[notificationTableView]-50-|"                                                                      options:0 metrics:nil views:viewsDictionary]];
}

#pragma mark - Table View setup
- (void) setupTableView{
    notificationTableView = [[UITableView alloc] init];
    [notificationTableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    // ios7
    if ([ notificationTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [ notificationTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    // ios 8
    if ([ notificationTableView respondsToSelector:@selector(layoutMargins)]) {
         notificationTableView.layoutMargins = UIEdgeInsetsZero;
    }

    notificationTableView.delegate = self;
    notificationTableView.dataSource = self;
    
    notificationTableView.backgroundColor = [UIColor whiteColor];
    
    //make sure our table view resizes correctly
    notificationTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth |
    UIViewAutoresizingFlexibleHeight;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section. should be returning the number of comments
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    NotificationTableViewCell *cell = (NotificationTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        //         cell = [[CommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell = [[NotificationTableViewCell alloc] init];
    }
    // Add image to left of the cell
 //   cell.imageView.image = [UIImage imageNamed:@"mapicon.jpeg"];
    if ([cell respondsToSelector:@selector(layoutMargins)]) {
        cell.layoutMargins = UIEdgeInsetsZero;
    }
    return cell;
}

#pragma mark - Customize cell
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//    cell.textLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
//    //   cell.backgroundColor = [UIColor greenColor]; //must do here in willDisplayCell
//    //   cell.textLabel.backgroundColor = [UIColor redColor]; //must do here in willDisplayCell
//    cell.textLabel.textColor = [UIColor greenColor]; //can do here OR in cellForRowAtIndexPath
//    tableView.separatorColor = [UIColor orangeColor];
}
@end
