//
//  CollectionheaderView.h
//  Viscat
//
//  Created by Sumit Ghosh on 31/03/15.
//  Copyright (c) 2015 Sumit Ghosh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionheaderView : UICollectionReusableView<UIScrollViewDelegate>
{
    UIImageView * headerImage;
    
}
@property(nonatomic)UILabel * headrLabel, *subHeader ,* footerLabel;
@property(nonatomic,strong) UIPageControl * pageControle;
@end
