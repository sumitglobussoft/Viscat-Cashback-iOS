//
//  PaymentHistoryCustomCell.m
//  Viscat
//
//  Created by Sumit Ghosh on 31/03/15.
//  Copyright (c) 2015 Sumit Ghosh. All rights reserved.
//

#import "PaymentHistoryCustomCell.h"

@implementation PaymentHistoryCustomCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.containerView=[[UIView alloc]init];
        self.containerView.backgroundColor=[UIColor clearColor];
        [self.contentView addSubview:self.containerView];
        
        self.dateLabel=[[UILabel alloc]init];
        self.dateLabel.font=[UIFont systemFontOfSize:10];
        self.dateLabel.numberOfLines=0;
        self.dateLabel.lineBreakMode=NSLineBreakByCharWrapping;
        [self.containerView addSubview:self.dateLabel];
        
        self.phoneNo=[[UILabel alloc]init];
        self.phoneNo.font=[UIFont systemFontOfSize:10];
        self.phoneNo.numberOfLines=0;
        self.phoneNo.lineBreakMode=NSLineBreakByCharWrapping;
        [self.containerView addSubview:self.phoneNo];
        
        self.statusView=[[UIImageView alloc]init];
        
        [self.containerView addSubview:self.statusView];
        
        self.processedOn=[[UILabel alloc]init];
        self.processedOn.font=[UIFont systemFontOfSize:10];
        self.processedOn.numberOfLines=0;
        self.processedOn.lineBreakMode=NSLineBreakByCharWrapping;
        [self.containerView addSubview:self.processedOn];
        
        
        self.value=[[UILabel alloc]init];
        self.value.font=[UIFont systemFontOfSize:10];
        self.value.numberOfLines=0;
        self.value.lineBreakMode=NSLineBreakByCharWrapping;
        [self.containerView addSubview:self.value];
        
        
    }
    return self;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
