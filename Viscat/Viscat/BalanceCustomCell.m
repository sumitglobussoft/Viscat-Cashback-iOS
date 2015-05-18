//
//  BalanceCustomCell.m
//  Viscat
//
//  Created by Sumit Ghosh on 31/03/15.
//  Copyright (c) 2015 Sumit Ghosh. All rights reserved.
//

#import "BalanceCustomCell.h"

@implementation BalanceCustomCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        windowSie=[UIScreen mainScreen].bounds.size;
        
        self.containerView=[[UIView alloc]init];
        self.containerView.backgroundColor=[UIColor colorWithRed:(CGFloat) 68/255 green:(CGFloat) 161/255 blue:(CGFloat) 224/255 alpha:(CGFloat)1.0];
        [self.contentView addSubview:self.containerView];
        
        self.leftLabel=[[UILabel alloc]init];
        self.leftLabel.font=[UIFont systemFontOfSize:12];
        self.leftLabel.textColor=[UIColor whiteColor];
        self.leftLabel.numberOfLines=0;
        self.leftLabel.lineBreakMode=NSLineBreakByWordWrapping;
        [self.containerView addSubview:self.leftLabel];
        
        self.rightLabel=[[UILabel alloc]init];
        self.rightLabel.textAlignment=NSTextAlignmentRight;
        self.rightLabel.font=[UIFont systemFontOfSize:12];
        self.rightLabel.textColor=[UIColor whiteColor];
        [self.containerView addSubview:self.rightLabel];
        
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
