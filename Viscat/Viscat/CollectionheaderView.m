//
//  CollectionheaderView.m
//  Viscat
//
//  Created by Sumit Ghosh on 31/03/15.
//  Copyright (c) 2015 Sumit Ghosh. All rights reserved.
//

#import "CollectionheaderView.h"
#import "SingletonClass.h"
#import "UIImageView+WebCache.h"

@implementation CollectionheaderView

-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        
        UIView * backView=[[UIView alloc]initWithFrame:CGRectMake(20, frame.size.height-25, frame.size.width-40, 50)];
        [self addSubview:backView];
        
      
        
         UIScrollView * scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, backView.frame.size.width, backView.frame.size.height)];
        scrollView.delegate=self;
        scrollView.pagingEnabled=YES;
        scrollView.showsHorizontalScrollIndicator=NO;
        [backView addSubview:scrollView];
        
        self.pageControle=[[UIPageControl alloc]init];
        self.pageControle.frame=CGRectMake(frame.size.width/2-20,5, 0, 0);
        self.pageControle.numberOfPages=[SingletonClass sharedSingleton].bannerImages.count;
        self.pageControle.currentPageIndicatorTintColor=[UIColor colorWithRed:(CGFloat)255/255 green:(CGFloat)165/255 blue:(CGFloat)0/255 alpha:(CGFloat)1];
        self.pageControle.pageIndicatorTintColor = [UIColor lightGrayColor];
        self.pageControle.currentPage=0;
        [backView insertSubview:self.pageControle aboveSubview:scrollView];
        
        for (int i=0; i<[SingletonClass sharedSingleton].bannerImages.count; i++) {
            CGFloat x=i*backView.frame.size.width;
            headerImage=[[UIImageView alloc]init];
            headerImage.frame=CGRectMake(x, 0, backView.frame.size.width, backView.frame.size.height);
            NSURL * url =[NSURL URLWithString:[[SingletonClass sharedSingleton].bannerImages objectAtIndex:i]];
            [headerImage sd_setImageWithURL:url];
            [scrollView addSubview:headerImage];
        }
        
        
        scrollView.contentSize=CGSizeMake(scrollView.frame.size.width*[SingletonClass sharedSingleton].bannerImages.count, scrollView.frame.size.height);
       
        
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

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.pageControle.currentPage=page;
}

@end
