//
//  HistoryViewController.h
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 2/15/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppUIManager.h"
#import "ApiManager.h"
#import "FlurryManager.h"

@interface HistoryViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    UITableView             *historyTableView;
}
@property (nonatomic, strong) UISegmentedControl *segmentedControl;

@end
