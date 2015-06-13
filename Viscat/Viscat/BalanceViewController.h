//
//  BalanceViewController.h
//  Viscat
//
//  Created by Sumit Ghosh on 31/03/15.
//  Copyright (c) 2015 Sumit Ghosh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BalanceViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    CGSize windowSize;
    NSNumberFormatter * formater;
}
@property(nonatomic)UITableView * balanceTable;
@property(nonatomic)UIActivityIndicatorView * activityLoad;
@end
