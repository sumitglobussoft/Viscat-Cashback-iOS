//
//  PaymentHistoryViewController.h
//  Viscat
//
//  Created by Sumit Ghosh on 31/03/15.
//  Copyright (c) 2015 Sumit Ghosh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaymentHistoryViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    CGSize windowSize;
}

@property(nonatomic)UITableView * paymentHistoryTable;
@property(nonatomic)UIActivityIndicatorView * activityLoad;
@end
