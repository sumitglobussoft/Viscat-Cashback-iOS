//
//  CustomTableViewCell.m
//  Viscat
//
//  Created by Sumit Ghosh on 18/05/15.
//  Copyright (c) 2015 Sumit Ghosh. All rights reserved.
//

#import "CustomTableViewCell.h"

@implementation CustomTableViewCell


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        windowSie=[UIScreen mainScreen].bounds.size;
        
        if ([reuseIdentifier isEqualToString:@"clickHistory"]) {
            
            self.cellTitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(25, 5, windowSie.width/2-60, self.contentView.frame.size.height)];
            self.cellTitleLabel.numberOfLines=0;
            self.cellTitleLabel.textColor=[UIColor blueColor];
            self.cellTitleLabel.lineBreakMode=NSLineBreakByWordWrapping;
            self.cellTitleLabel.font=[UIFont systemFontOfSize:12];
            [self.contentView addSubview:self.cellTitleLabel];
            
            self.cellVisitors=[[UILabel alloc]initWithFrame:CGRectMake(windowSie.width/2-60, 5, 50, self.contentView.frame.size.height)];
            self.cellVisitors.numberOfLines=0;
            self.cellVisitors.textColor=[UIColor blackColor];
            self.cellVisitors.lineBreakMode=NSLineBreakByWordWrapping;
            self.cellVisitors.font=[UIFont systemFontOfSize:12];
            [self.contentView addSubview:self.cellVisitors];
            
            self.cellLastVisit=[[UILabel alloc]initWithFrame:CGRectMake((windowSie.width/2-60)+50, 5, 50, self.contentView.frame.size.height)];
            self.cellLastVisit.numberOfLines=0;
            self.cellLastVisit.textColor=[UIColor blackColor];
            self.cellLastVisit.lineBreakMode=NSLineBreakByWordWrapping;
            self.cellLastVisit.font=[UIFont systemFontOfSize:12];
            [self.contentView addSubview:self.cellLastVisit];
        }
        
    }
    return  self;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
