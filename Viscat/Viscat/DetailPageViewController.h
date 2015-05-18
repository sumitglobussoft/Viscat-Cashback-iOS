//
//  DetailPageViewController.h
//  Viscat
//
//  Created by Sumit Ghosh on 03/04/15.
//  Copyright (c) 2015 Sumit Ghosh. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ContextMenuCell.h"
#import "YALContextMenuTableView.h"
#import "YALNavigationBar.h"


@interface DetailPageViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UITableViewDelegate,
UITableViewDataSource,YALContextMenuTableViewDelegate>
{
    CGSize windowSize;
    UIView * bottomCollectioView;
     NSMutableArray  * imageUrl,* dataArr,* addedArr, * coupnArr,* favArr,* reviewArr,*retailerId,* storeUrl;;
}
@property(nonatomic)UICollectionView * mainCollectionView;
@property(nonatomic,strong)NSString * topTitle,* detailDescription;
@property(nonatomic,strong)NSString * detailImgUrl,* cashBackStr,*retailId;

@property (nonatomic, strong) YALContextMenuTableView* contextMenuTableView;

@property (nonatomic, strong) NSArray *menuTitles;
@property (nonatomic, strong) NSArray *menuIcons;
@end