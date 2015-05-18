//
//  BalanceCustomCell.h
//  Viscat
//
//  Created by Sumit Ghosh on 31/03/15.
//  Copyright (c) 2015 Sumit Ghosh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BalanceCustomCell : UITableViewCell
{
    CGSize windowSie;
}
@property(nonatomic)UIView * containerView;
@property(nonatomic)UILabel * leftLabel,* rightLabel;
@end
