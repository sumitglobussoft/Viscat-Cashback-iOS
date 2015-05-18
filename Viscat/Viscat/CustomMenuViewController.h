//
//  CusttomMenuViewController.h
//  Viscat
//
//  Created by Sumit Ghosh on 17/03/15.
//  Copyright (c) 2015 Sumit Ghosh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomMenuViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>


@property(nonatomic,strong)UINavigationController * nav;
@property (nonatomic, assign) CGFloat screen_height;

@property (nonatomic, strong) UIButton *menuButton;
@property (nonatomic, strong) UILabel *headerTitleLabel;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *contentContainerView;
@property (nonatomic, strong) UILabel *menuLabel;
@property (nonatomic, strong) UITableView *menuTableView;
@property (nonatomic, strong) UILabel *secondHeaderLabel;



@property (nonatomic, copy) NSArray *viewControllers,*signupViewController;
@property (nonatomic, strong) NSArray *secondSectionViewControllers;
@property (nonatomic, assign) NSInteger numberOfSections;

@property (nonatomic, copy) UIViewController *selectedViewController;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, assign) NSInteger selectedSection;

@property (nonatomic, strong) UIView *mainsubView;

@property (nonatomic, strong) UISwipeGestureRecognizer *swipeGesture;

@property(nonatomic,strong)UITabBar * customBar;
-(NSArray *) getAllViewControllers;
@end

@interface UIViewController (CustomMenuViewControllerItem)

@property (nonatomic, strong) CustomMenuViewController *customMenuViewController;


@end
