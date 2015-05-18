//
//  PaymentHistoryCustomCell.h
//  Viscat
//
//  Created by Sumit Ghosh on 31/03/15.
//  Copyright (c) 2015 Sumit Ghosh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaymentHistoryCustomCell : UITableViewCell

@property(nonatomic)UILabel * dateLabel,*phoneNo,* label3,* processedOn,* value;
@property(nonatomic)UIView * containerView;
@property(nonatomic)UIImageView * statusView;
@end
