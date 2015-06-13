//
//  SingletonClass.h
//  Viscat
//
//  Created by Sumit Ghosh on 18/04/15.
//  Copyright (c) 2015 Sumit Ghosh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SingletonClass : NSObject

+(SingletonClass *) sharedSingleton;

@property(nonatomic)BOOL isLogin,isFromHome;

// Detail page data

@property(nonatomic,strong)NSMutableArray * imageUrl,* detailDescription,* detail_title,*dataArr,* bannerImages;
@property(nonatomic,strong)NSString * topTitle,* detail_description;
@property(nonatomic,strong)NSString * detailImgUrl,* cashBackStr;
@property(nonatomic,strong)NSString * coupns, *reviews,*fav,* added,* webUrl;

@property(nonatomic,strong)NSString* login_userId,*fname,*userEmail,* lname,*fbId;
@property(nonatomic)BOOL isFromDetailpage;

@property(nonatomic)BOOL isActivenetworkConnection,isFromTab;
@end
