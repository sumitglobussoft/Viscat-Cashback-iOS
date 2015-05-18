//
//  CollectionheaderView.m
//  Viscat
//
//  Created by Sumit Ghosh on 31/03/15.
//  Copyright (c) 2015 Sumit Ghosh. All rights reserved.
//

#import "CollectionheaderView.h"

@implementation CollectionheaderView

-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        
        UIView * backView=[[UIView alloc]initWithFrame:CGRectMake(20, frame.size.height-25, frame.size.width-40, 44)];
        backView.backgroundColor=[UIColor colorWithRed:(CGFloat) 147/255 green:(CGFloat) 205/255 blue:(CGFloat) 245/255 alpha:(CGFloat)1.0];
        backView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"homeheader_bg.png"]];
        [self addSubview:backView];
        
        self.headrLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 5, frame.size.width-30, 25)];
        self.headrLabel.font=[UIFont boldSystemFontOfSize:15];
        self.headrLabel.textAlignment=NSTextAlignmentCenter;
        
        //[backView addSubview:self.headrLabel];
        
        self.subHeader=[[UILabel alloc]initWithFrame:CGRectMake(20, 30, frame.size.width-80, 10)];
        self.subHeader.font=[UIFont boldSystemFontOfSize:10];
        self.subHeader.textAlignment=NSTextAlignmentCenter;
        self.subHeader.backgroundColor=[UIColor colorWithRed:(CGFloat) 242/255 green:(CGFloat) 150/255 blue:(CGFloat) 186/255 alpha:(CGFloat)1];

        //[backView addSubview:self.subHeader];
        
        
        self.footerLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, frame.size.height-5, frame.size.width-80, 30)];
        self.footerLabel.font=[UIFont boldSystemFontOfSize:10];
        self.footerLabel.textAlignment=NSTextAlignmentCenter;
        [backView addSubview:self.footerLabel];

        
    }
    return  self;
}

@end
