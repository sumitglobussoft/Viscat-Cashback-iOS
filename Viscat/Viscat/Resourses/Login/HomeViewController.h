//
//  HomeViewController.h
//  Viscat
//
//  Created by Sumit Ghosh on 23/03/15.
//  Copyright (c) 2015 Sumit Ghosh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource>
{
    CGSize windowSize;
    NSMutableArray  * imageUrl,* dataArr,* addedArr, * coupnArr,* favArr,* reviewArr,*retailerId,* storeUrl;
}
@property(nonatomic,strong)UICollectionView * mainCollectionView;
@property(nonatomic)UIActivityIndicatorView * activityLoad;
@property(nonatomic)NSString * retailerIdStr;
@end
