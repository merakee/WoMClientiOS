//
//  HistoryViewController.m
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 2/15/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import "HistoryViewController.h"
#import "AppUIManager.h"
#import "HistoryTableViewCell.h"

@implementation HistoryViewController
@synthesize segmentedControl;

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
    [self.view addSubview:historyTableView];
    [self onSegmentedControlChanged:segmentedControl];
    [self addSegmentedControl];
    [self layoutView];
}

- (void)layoutView{
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(historyTableView);
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[historyTableView]|"                                                                      options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[historyTableView]-200-|"                                                                      options:0 metrics:nil views:viewsDictionary]];
}

#pragma mark - Table View setup
- (void) setupTableView{
    historyTableView = [[UITableView alloc] init];
    [historyTableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    // Inset of cell seperators
    // ios7
    if ([historyTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [historyTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    // ios 8
    if ([historyTableView respondsToSelector:@selector(layoutMargins)]) {
        historyTableView.layoutMargins = UIEdgeInsetsZero;
    }
    historyTableView.delegate = self;
    historyTableView.dataSource = self;
    historyTableView.backgroundColor = [UIColor whiteColor];
    
    //make sure our table view resizes correctly
    historyTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth |
    UIViewAutoresizingFlexibleHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    HistoryTableViewCell *cell = (HistoryTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        //         cell = [[CommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell = [[HistoryTableViewCell alloc] init];
    }
    // Add image to left of the cell
    //   cell.imageView.image = [UIImage imageNamed:@"mapicon.jpeg"];
    if ([cell respondsToSelector:@selector(layoutMargins)]) {
        cell.layoutMargins = UIEdgeInsetsZero;
    }
    return cell;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section. should be returning the amount of history
    return 3;
}

#pragma mark - Segmented Control

- (void) addSegmentedControl {
    NSArray *segmentItems = [NSArray arrayWithObjects: @"Posts", @"Comments", nil];
    segmentedControl = [[UISegmentedControl alloc] initWithItems: segmentItems];
    
    [segmentedControl addTarget: self action: @selector(onSegmentedControlChanged:) forControlEvents: UIControlEventValueChanged];
    
    segmentedControl.selectedSegmentIndex = 0;
    self.navigationItem.titleView = segmentedControl;
}

- (void) onSegmentedControlChanged:(UISegmentedControl *) sender {
    
    // NSLog(@"%ld", sender.selectedSegmentIndex);
    if (sender.selectedSegmentIndex == 0) {
        segmentedControl.selectedSegmentIndex = 0;
        // switch active array pointer to popular array
       // activeArray = popularArray;
        [historyTableView reloadData];
    }
    else if (sender.selectedSegmentIndex == 1){
        segmentedControl.selectedSegmentIndex = 1;
        // switch active array pointer to recent array
   //     activeArray = recentArray;
        [historyTableView reloadData];
    }
    // reset the scrolling to the top of the table view
    if ([self tableView:historyTableView numberOfRowsInSection:0] > 0) {
        NSIndexPath *topIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [historyTableView scrollToRowAtIndexPath:topIndexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
    }
}

@end
