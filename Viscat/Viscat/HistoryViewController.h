//
//  HistoryViewController.h
//  Viscat
//
//  Created by Sumit Ghosh on 18/05/15.
//  Copyright (c) 2015 Sumit Ghosh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    CGSize windowSize;
}

@property(nonatomic)UITableView * HistoryTable;
@end
