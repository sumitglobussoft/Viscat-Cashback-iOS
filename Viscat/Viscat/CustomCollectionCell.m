//
//  CustomCollectionCell.m
//  Viscat
//
//  Created by Sumit Ghosh on 01/04/15.
//  Copyright (c) 2015 Sumit Ghosh. All rights reserved.
//

#import "CustomCollectionCell.h"

@implementation CustomCollectionCell

-(id)initWithFrame:(CGRect)frame{
    
    self=[super initWithFrame:frame];
    if (self) {
        
        self.profileImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height-20)];
       // self.profileImageView.layer.cornerRadius=4;
        self.profileImageView.clipsToBounds=YES;
        self.profileImageView.backgroundColor=[UIColor whiteColor];
      
        [self addSubview:self.profileImageView];
        
        self.nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(0,frame.size.height-20, frame.size.width,(frame.size.height-(frame.size.height-20)))];
        self.nameLabel.backgroundColor=[UIColor colorWithRed:(CGFloat)236/255 green:(CGFloat)236/255 blue:(CGFloat)236/255 alpha:(CGFloat)1];
        self.nameLabel.textAlignment=NSTextAlignmentCenter;
        self.nameLabel.font=[UIFont systemFontOfSize:12];
        
        self.layer.borderColor=[[UIColor lightGrayColor]CGColor];
        self.layer.borderWidth=0.5f;
        self.clipsToBounds=YES;
        //self.layer.cornerRadius=4.0f;
        
        [self addSubview:self.nameLabel];
    }
    return  self;
}


@end
