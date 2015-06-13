//
//  CustomTableViewCell.m
//  Viscat
//
//  Created by Sumit Ghosh on 18/05/15.
//  Copyright (c) 2015 Sumit Ghosh. All rights reserved.
//

#import "CustomTableViewCell.h"

@implementation CustomTableViewCell


/*-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        windowSie=[UIScreen mainScreen].bounds.size;
        
//        if ([reuseIdentifier isEqualToString:@"clickHistory"]) {
//            
//            self.cellTitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(25, 5, windowSie.width/2-60, self.contentView.frame.size.height)];
//            self.cellTitleLabel.numberOfLines=0;
//            self.cellTitleLabel.textColor=[UIColor blueColor];
//            self.cellTitleLabel.lineBreakMode=NSLineBreakByWordWrapping;
//            self.cellTitleLabel.font=[UIFont systemFontOfSize:12];
//            [self.contentView addSubview:self.cellTitleLabel];
//            
//            self.cellVisitors=[[UILabel alloc]initWithFrame:CGRectMake(windowSie.width/2-60, 5, 50, self.contentView.frame.size.height)];
//            self.cellVisitors.numberOfLines=0;
//            self.cellVisitors.textColor=[UIColor blackColor];
//            self.cellVisitors.lineBreakMode=NSLineBreakByWordWrapping;
//            self.cellVisitors.font=[UIFont systemFontOfSize:12];
//            [self.contentView addSubview:self.cellVisitors];
//            
//            self.cellLastVisit=[[UILabel alloc]initWithFrame:CGRectMake((windowSie.width/2-60)+50, 5, 50, self.contentView.frame.size.height)];
//            self.cellLastVisit.numberOfLines=0;
//            self.cellLastVisit.textColor=[UIColor blackColor];
//            self.cellLastVisit.lineBreakMode=NSLineBreakByWordWrapping;
//            self.cellLastVisit.font=[UIFont systemFontOfSize:12];
//            [self.contentView addSubview:self.cellLastVisit];
//        }
       
        
    }
    return  self;
}*/

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        windowSie=[UIScreen mainScreen].bounds.size;
        
        if ([reuseIdentifier isEqualToString:@"dropDown"]) {
            self.contentView.backgroundColor=[UIColor grayColor];
            self.cellTitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0,self.contentView.frame.size.width , self.contentView.frame.size.height)];
            self.cellTitleLabel.numberOfLines=0;
            self.cellTitleLabel.textColor=[UIColor whiteColor];
            self.cellTitleLabel.lineBreakMode=NSLineBreakByWordWrapping;
            self.cellTitleLabel.font=[UIFont systemFontOfSize:15];
            [self.contentView addSubview:self.cellTitleLabel];
        }
        
        if ([reuseIdentifier isEqualToString:@"storeList"]) {
        
            
            self.bgImgView=[[UIImageView alloc]init];
            self.bgImgView.frame=CGRectMake(20, 5, windowSie.width-40, 150);
            self.bgImgView.image=[UIImage imageNamed:@"product_detailbox_star.png"];
            [self.contentView addSubview:self.bgImgView];
            
            self.storeLogo=[[UIImageView alloc]init];
            self.storeLogo.frame=CGRectMake(windowSie.width/2-60, 10, 60, 40);
            [self.contentView addSubview:self.storeLogo];
            
            self.title=[[UILabel alloc]init];
            self.title.frame=CGRectMake(25, 50, windowSie.width/2+20, 20);
            self.title.numberOfLines=0;
            self.title.font=[UIFont systemFontOfSize:12];
            self.title.textColor=[UIColor colorWithRed:(CGFloat)67/255 green:(CGFloat)166/255 blue:(CGFloat)233/255 alpha:(CGFloat)1];
            self.title.lineBreakMode=NSLineBreakByWordWrapping;
            [self.contentView addSubview:self.title];

            
            self.storeDescription=[[UILabel alloc]init];
            self.storeDescription.frame=CGRectMake(25, 70, windowSie.width/2+20, 80);
            self.storeDescription.numberOfLines=0;
            self.storeDescription.lineBreakMode=NSLineBreakByWordWrapping;
            [self.contentView addSubview:self.storeDescription];
            
            self.cashBack=[[UILabel alloc]init];
            self.cashBack.frame=CGRectMake(self.bgImgView.frame.size.width-50, 80, 50, 40);
            self.cashBack.font=[UIFont boldSystemFontOfSize:16];
            self.cashBack.textColor=[UIColor whiteColor];
            self.cashBack.backgroundColor=[UIColor greenColor];
            self.cashBack.textAlignment=NSTextAlignmentCenter;
            self.cashBack.numberOfLines=0;
            self.cashBack.lineBreakMode=NSLineBreakByWordWrapping;
            self.cashBack.layer.cornerRadius=5;
            self.cashBack.clipsToBounds=YES;
            [self.contentView addSubview:self.cashBack];
            
            self.ratingStar=[[UIImageView alloc]init];
            self.ratingStar.frame=CGRectMake(25, 70, 58, 11);
            [self.contentView addSubview:self.ratingStar];
            
            
        }
        if ([reuseIdentifier isEqualToString:@"rateStore"]) {
            self.rateLbl=[[UILabel alloc]init];
            self.rateLbl.frame=CGRectMake(20, 0, windowSie.width-40, 150);
            [self.contentView addSubview:self.rateLbl];
        }
        
        if ([reuseIdentifier isEqualToString:@"clickHistory"]) {
            self.title=[[UILabel alloc]init];
            self.title.numberOfLines=0;
            self.title.font=[UIFont systemFontOfSize:12];
            self.title.textColor=[UIColor blackColor];
            self.title.lineBreakMode=NSLineBreakByWordWrapping;
            [self.contentView addSubview:self.title];
            
            self.visitorsLbl=[[UILabel alloc]init];
            self.visitorsLbl.numberOfLines=0;
            self.visitorsLbl.font=[UIFont systemFontOfSize:12];
            self.visitorsLbl.textColor=[UIColor blackColor];
            self.visitorsLbl.lineBreakMode=NSLineBreakByWordWrapping;
            [self.contentView addSubview:self.visitorsLbl];
            
            self.DateTimeLbl=[[UILabel alloc]init];
            self.DateTimeLbl.numberOfLines=0;
            self.DateTimeLbl.font=[UIFont systemFontOfSize:12];
            self.DateTimeLbl.textColor=[UIColor blackColor];
            self.DateTimeLbl.lineBreakMode=NSLineBreakByWordWrapping;
            [self.contentView addSubview:self.DateTimeLbl];


            self.gotoStore=[UIButton buttonWithType:UIButtonTypeCustom];
            [self.gotoStore setBackgroundImage:[UIImage imageNamed:@"clickhistorystore_button.png"] forState:UIControlStateNormal];
            [self.contentView addSubview:self.gotoStore];
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
