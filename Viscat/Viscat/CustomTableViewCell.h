//
//  CustomTableViewCell.h
//  Viscat
//
//  Created by Sumit Ghosh on 18/05/15.
//  Copyright (c) 2015 Sumit Ghosh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell
{
    CGSize windowSie;
}
@property(nonatomic,strong)UILabel * cellTitleLabel,* cellVisitors,  *cellLastVisit;

@end
